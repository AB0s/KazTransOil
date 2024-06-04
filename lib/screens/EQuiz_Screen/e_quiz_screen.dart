import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kaz_trans_oil/API_Calls/Fetch_Quizzes.dart';
import 'package:kaz_trans_oil/AppColors.dart';
import 'package:kaz_trans_oil/generated/locale_keys.g.dart';
import 'package:kaz_trans_oil/methods/url_launch.dart';

import '../../drawer.dart';

class EQuiz extends StatefulWidget {
  const EQuiz({super.key});

  @override
  _EQuizState createState() => _EQuizState();
}

class _EQuizState extends State<EQuiz> with SingleTickerProviderStateMixin {
  List<dynamic> items = [];
  int currentPage = 1;
  int pageSize = 10;
  bool isLoading = false;
  bool isLoadingData = true; // Track if data is loading
  bool hasMoreItems = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchNextPage();
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  Future<void> fetchNextPage() async {
    if (!isLoading && hasMoreItems) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      final newItems = await fetchQuizzes(currentPage, pageSize);
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          items.addAll(newItems);
          currentPage++;
          hasMoreItems = newItems.isNotEmpty;
          isLoading = false;
          isLoadingData = false; // Data loading complete
        });
      }

      if (!hasMoreItems) {
        _animationController.reset();
        _animationController.forward();
      }
    }
  }

  Widget getLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void showLanguageDialog(String ruUrl, String kazUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(LocaleKeys.choose.tr()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(LocaleKeys.ru_Len.tr()),
                onTap: () {
                  Navigator.pop(context);
                  UrlLauncher.launchFileURL(ruUrl);
                },
              ),
              ListTile(
                title:  Text(LocaleKeys.kaz_Len.tr()),
                onTap: () {
                  Navigator.pop(context);
                  UrlLauncher.launchFileURL(kazUrl);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer1(),
      appBar: AppBar(
        title: const Text('E-Quiz',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: AppColors.colors['colorPrimary'],
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
      ),
      body: Container( decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/light_background_menu.png'),
          fit: BoxFit.cover,
        ),
      ),
        child: Scrollbar(
          child: isLoadingData
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : items.isEmpty
              ? Center(
            child: Text(
              LocaleKeys.no_data.tr(),
              style: const TextStyle(fontSize: 24),
            ),
          )
              : ListView.builder(
            itemCount: items.length + (hasMoreItems ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < items.length) {
                var item = items[index];
                var ruItemName = item['title'] ?? 'N/A';
                var kazItemName = item['kazTitle'] ?? 'N/A';
                var infoUrls = item['infoUrls'];
                final createdDateTime = item['createdDateTime'];
                final parsedDateTime =
                DateTime.parse(createdDateTime);
                final formattedDateTime =
                DateFormat('dd.MM.yyyy').format(parsedDateTime);
                String? leadingUrl;
                leadingUrl = item['url'];
                var kazUrl=item['kazUrl'];

                return GestureDetector(
                  onTap: () {
                    if (leadingUrl != null) {
                      showLanguageDialog(leadingUrl,kazUrl);
                    } else {
                      print('s');
                    }
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.newspaper,
                      size: 38,
                      color: AppColors.colors['colorPrimary'],
                    ),
                    title: Text(
                      context.locale==const Locale('ru')?ruItemName:kazItemName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(formattedDateTime),
                    // Customize ListTile with additional fields as needed
                  ),
                );
              } else if (hasMoreItems) {
                if (!isLoading) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    fetchNextPage();
                  });
                }
                return getLoadingIndicator();
              } else {
                // Last loading indicator with animation
                return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: getLoadingIndicator(),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

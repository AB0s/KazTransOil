import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaz_trans_oil/AppColors.dart';
import 'package:kaz_trans_oil/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';
import '../API_Calls/Fetch_Info.dart';
import 'package:kaz_trans_oil/methods/url_launch.dart';

import '../drawer.dart';

class ShowInfo extends StatefulWidget {
  final int type;
  final String title;

  const ShowInfo({super.key, required this.type, required this.title});

  @override
  _ShowInfoState createState() => _ShowInfoState();
}

class _ShowInfoState extends State<ShowInfo>
    with SingleTickerProviderStateMixin {
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
      final newItems = await fetchInfo(widget.type, currentPage, pageSize);
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

  Future<void> _refreshData() async {
    setState(() {
      items.clear();
      currentPage = 1;
      hasMoreItems = true;
      isLoading = false;
      isLoadingData = true;
    });
    await fetchNextPage();
    setState(() {
      isLoadingData = false;
    });
  }

  Widget getLeadingIcon(String url) {
    final extension = url.split('.').last;
    switch (extension) {
      case 'pdf':
        return Icon(
          FontAwesomeIcons.filePdf,
          color: AppColors.colors['colorPrimary'],
          size: 38,
        );
      case 'doc':
      case 'docx':
        return Icon(
          FontAwesomeIcons.fileWord,
          color: AppColors.colors['colorPrimary'],
          size: 38,
        );
      case 'jpg':
      case 'jpeg':
        return Icon(
          FontAwesomeIcons.fileImage,
          color: AppColors.colors['colorPrimary'],
          size: 38,
        );
      case 'png':
        return Icon(
          FontAwesomeIcons.fileImage,
          color: AppColors.colors['colorPrimary'],
          size: 38,
        );
      case 'mp4':
      case 'MP4':
        return Icon(
          FontAwesomeIcons.fileVideo,
          color: AppColors.colors['colorPrimary'],
          size: 38,
        );
      default:
        return const Icon(Icons.insert_drive_file);
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

  void showLanguageDialog(String? ruUrl, String? kazUrl) {
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
                  UrlLauncher.launchFileURL('https://www.mbportal.kz/$ruUrl');
                },
              ),
              ListTile(
                title: Text(LocaleKeys.kaz_Len.tr()),
                onTap: () {
                  Navigator.pop(context);
                  UrlLauncher.launchFileURL('https://www.mbportal.kz/$kazUrl');
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.colors['colorPrimary'],
      ),
      drawer: widget.title == 'Munaiqubyrshy' ? const Drawer1() : null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/light_background_menu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refreshData,
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
                            var itemName = item['title'] ?? 'N/A';
                            var infoUrls = item['infoUrls'];
                            final createdDateTime = item['createdDateTime'];
                            final parsedDateTime =
                                DateTime.parse(createdDateTime);
                            final formattedDateTime =
                                DateFormat('dd.MM.yyyy').format(parsedDateTime);
                            String? leadingUrl;
                            String? kazUrl;
                            String? ruUrl;
                            if (infoUrls is List && infoUrls.isNotEmpty) {
                              if (infoUrls.length > 1) {
                                if (infoUrls[0]['language'] == 1) {
                                  kazUrl = infoUrls[0]['url'];
                                } else if (infoUrls[1]['language'] == 1) {
                                  kazUrl = infoUrls[1]['url'];
                                } if (infoUrls[0]['language'] == 2) {
                                  ruUrl = infoUrls[0]['url'];
                                } else if (infoUrls[1]['language'] == 2) {
                                  ruUrl = infoUrls[1]['url'];
                                }
                              }
                                leadingUrl = infoUrls[0]['url'];
                            }

                            return GestureDetector(
                              onTap: () {
                                if (leadingUrl != null || ruUrl!=null || kazUrl!=null ) {
                                  if (infoUrls.length > 1) {
                                    showLanguageDialog(ruUrl, kazUrl);
                                  }
                                  else{
                                    UrlLauncher.launchFileURL(
                                        'https://www.mbportal.kz/$leadingUrl');
                                  }
                                } else {
                                  print('s');
                                }
                              },
                              child: ListTile(
                                leading: leadingUrl != null
                                    ? getLeadingIcon(leadingUrl)
                                    : null,
                                title: Text(
                                  itemName,
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
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

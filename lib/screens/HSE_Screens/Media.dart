import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../API_Calls/Fetch_Videos.dart';
import '../../AppColors.dart';
import '../Video_Screen/Video_Card.dart';

class ShowMedia extends StatefulWidget {
  final int type;
  String title;
  ShowMedia({Key? key, required this.type,required this.title}) : super(key: key);

  @override
  _ShowMediaState createState() => _ShowMediaState();
}

class _ShowMediaState extends State<ShowMedia> {
  List<dynamic> videosList = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchNewVideos();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!isLoading && currentPage < totalPages) {
        fetchNewVideos();
      }
    }
  }

  Future<void> fetchNewVideos() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        final response = await fetchMedia(widget.type, currentPage);
        final List<dynamic> newVideosList = response['videosList'];
        totalPages = response['totalPages'];

        setState(() {
          videosList.addAll(newVideosList);
          currentPage++;
          isLoading = false;
        });
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        print('Error: $error');
        // Handle the error condition
      }
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      videosList.clear();
      currentPage = 1;
    });
    await fetchNewVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF0A386A),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/light_background_menu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: videosList.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < videosList.length) {
                final videos = videosList[index];
                final createdDateTime = videos['createdDateTime'];
                final parsedDateTime = DateTime.parse(createdDateTime);
                final formattedDateTime = DateFormat('dd.MM.yyyy').format(parsedDateTime);
                return Column(
                  children: [
                    VideoCard(
                      imageUrl: videos['url'],
                      title: videos['title'],
                      createdDateTime: formattedDateTime,
                      id: videos['id'],
                      noOfViews: videos['noOfViews'],
                    ),
                    const Divider(height:10,color: Colors.grey,)
                  ],
                );
              } else {
                // Display loading indicator at the end of the list while fetching new data
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.colors['colorPrimary']!),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

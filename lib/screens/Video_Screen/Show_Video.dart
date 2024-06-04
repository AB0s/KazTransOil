import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaz_trans_oil/Post_Card/post_card.dart';
import 'package:kaz_trans_oil/API_Calls/Fetch_News.dart';

import '../../API_Calls/Fetch_Videos.dart';
import '../../AppColors.dart';
import '../../Post_Card/PostCardSmall.dart';
import 'Video_Card.dart';

class ShowVideoScreen extends StatefulWidget {
  final int year;
  const ShowVideoScreen({Key? key, required this.year}) : super(key: key);

  @override
  _ShowVideoScreenState createState() => _ShowVideoScreenState();
}

class _ShowVideoScreenState extends State<ShowVideoScreen> {
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
        final response = await fetchVideos(widget.year, currentPage);
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
    return RefreshIndicator(
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
    );
  }
}

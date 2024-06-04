import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaz_trans_oil/Post_Card/post_card.dart';
import 'package:kaz_trans_oil/API_Calls/Fetch_News.dart';

import '../../AppColors.dart';
import '../../Post_Card/PostCardSmall.dart';

class Corporative_Block extends StatefulWidget {
  const Corporative_Block({Key? key}) : super(key: key);

  @override
  _Corporative_BlockState createState() => _Corporative_BlockState();
}

class _Corporative_BlockState extends State<Corporative_Block> {
  List<dynamic> newsList = [];
  int currentPage = 1;
  int totalPages = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchNewNews();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLoading && currentPage < totalPages) {
        fetchNewNews();
      }
    }
  }

  Future<void> fetchNewNews({bool refresh = false}) async {
    if (!isLoading && mounted) {
      setState(() {
        isLoading = true;
      });

      try {
        if (refresh) {
          currentPage = 1;
          newsList.clear();
        }

        final response = await fetchNews(1, currentPage);
        final List<dynamic> newNewsList = response['newsList'];
        totalPages = response['totalPages'];

        setState(() {
          newsList.addAll(newNewsList);
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

  Future<void> _onRefresh() async {
    await fetchNewNews(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: newsList.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < newsList.length) {
              final news = newsList[index];
              final createdDateTime = news['createdDateTime'];
              final parsedDateTime = DateTime.parse(createdDateTime);
              final formattedDateTime =
                  DateFormat('dd.MM.yyyy').format(parsedDateTime);

              if (index == 0) {
                // Display the first news item with a larger image
                return Postcard(
                  imageUrl: news['imageUrl'],
                  title: news['title'],
                  createdDateTime: formattedDateTime,
                  id: news['id'],
                  noOfViews: news['noOfViews'],
                );
              } else {
                // Display the remaining news items with smaller images
                return PostcardSmallImage(
                  imageUrl: news['imageUrl'],
                  title: news['title'],
                  createdDateTime: formattedDateTime,
                  id: news['id'],
                  noOfViews: news['noOfViews'],
                );
              }
            } else {
              // Display loading indicator at the end of the list while fetching new data
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.colors['colorPrimary']!),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

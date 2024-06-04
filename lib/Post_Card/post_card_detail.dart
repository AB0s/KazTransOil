import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:kaz_trans_oil/methods/url_launch.dart';
import 'package:share_plus/share_plus.dart';

import '../API_Calls/Fetch_News.dart';
import '../AppColors.dart';
import '../generated/locale_keys.g.dart';

class PostCardDetail extends StatefulWidget {
  final String? imageUrl;
  final createdDateTime;
  final id;

  const PostCardDetail(
      {Key? key,
      this.imageUrl,
      required this.createdDateTime,
      required this.id,})
      : super(key: key);

  @override
  State<PostCardDetail> createState() => _PostCardDetailState();
}

class _PostCardDetailState extends State<PostCardDetail> {
  final baseUrl = 'https://www.mbportal.kz';
  String getYouTubeVideoId(String url) {
    RegExp regExp = RegExp(
      r'^https?:\/\/(?:www\.)?(?:youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)',
      caseSensitive: false,
      multiLine: false,
    );
    Match? match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchNewsData(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final newsData = snapshot.data as Map<String, dynamic>;
          final title = newsData['title'];
          final body = newsData['body'];
          final subtitle = body != null ? parse(body).body?.text : '';
          final noOfViews = newsData['noOfViews'];
          final source=newsData['source'];
          return Scaffold(
            appBar: AppBar(
              backgroundColor:
                  Colors.transparent, // Set the background color to transparent
              elevation: 0, // Set the elevation to 0 to remove the shadow
              iconTheme: const IconThemeData(
                color: Colors.white,
                // Set the color of the back button to white
                size: 30, // Set the size of the back button
              ),
              actions: [
                Opacity(
                  opacity: source==null? 0.6:1,
                  child: IconButton(
                    onPressed: () {
                      if(source!=null){
                        Share.share(source);
                      }
                    },
                    icon: const Icon(
                      Icons.share,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            extendBodyBehindAppBar: true, // Extend the body behind the AppBar
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(bottom:50 ),
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxHeight: 400),
                        child: widget.imageUrl != null
                            ? Image.network(
                                '$baseUrl/${widget.imageUrl}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ) // Conditionally render the Image.network widget
                            : const SizedBox(
                                height: 200,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(widget.createdDateTime),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Icon(Icons.visibility),
                                  ),
                                  SizedBox(width: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text('$noOfViews'),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                subtitle!,
                                style: const TextStyle(fontSize: 16),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: source != null? Container(
              width: double.infinity,
              color: AppColors.colors['colorPrimary'],
              child: TextButton(
                onPressed: () {
                  UrlLauncher.launchSource(source);
                },
                child:  Text(
                LocaleKeys.source.tr(),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ):null
          );
        }
      },
    );
  }
}

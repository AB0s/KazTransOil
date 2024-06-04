import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../../methods/url_launch.dart';

class VideoCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final createdDateTime;
  final id;
  final int? noOfViews;

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

  const VideoCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.createdDateTime,
    required this.id,
    this.noOfViews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isImageLoading = true;
    return GestureDetector(
        onTap: () {
          final response = http.get(
              Uri.parse('https://www.mbportal.kz/api/videoGalleries/{$id}'));
          UrlLauncher.launchYoutubeURL(imageUrl!);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              imageUrl != null
                  ? Image.network(
                      'https://img.youtube.com/vi/${getYouTubeVideoId(imageUrl!)}/0.jpg',
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // Image has finished loading
                          isImageLoading = false;
                          return child;
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        // Display a fallback image when the request fails
                        return Container(height: 200,color: Colors.grey,);
                      },
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   const Icon(FontAwesomeIcons.calendar),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(createdDateTime,style: const TextStyle(fontSize: 16),),
                  Expanded(child: Container()),
                  const Icon(Icons.visibility),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('$noOfViews',style: const TextStyle(fontSize: 16),)
                ],
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:kaz_trans_oil/Post_Card/post_card_detail.dart';

import '../AppColors.dart';

class Postcard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final createdDateTime;
  final baseUrl = 'https://www.mbportal.kz';
  final String id;
  final int noOfViews;

  const Postcard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.createdDateTime,
    required this.id,
    required this.noOfViews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (_, animation, __) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: PostCardDetail(
                    imageUrl: imageUrl,
                    createdDateTime: createdDateTime,
                    id: id),
              );
            },
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        color: AppColors.colors['colorPrimary'],
        child: IntrinsicHeight(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            imageUrl != null
                ? Image.network(
                    '$baseUrl/$imageUrl',
                  ) // Conditionally render the Image.network widget
                : const SizedBox(),
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/4.png'))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 15,top: 30),
                        child: Row(
                          children: [
                            Text(
                              createdDateTime,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '$noOfViews',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

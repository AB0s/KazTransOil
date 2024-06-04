import 'package:flutter/material.dart';
import 'package:kaz_trans_oil/Post_Card/post_card.dart';
import 'package:kaz_trans_oil/Post_Card/post_card_detail.dart';

import '../AppColors.dart';

class PostcardSmallImage extends Postcard {
  const PostcardSmallImage({
    Key? key,
    String? imageUrl,
    required String title,
    required dynamic createdDateTime,
    required dynamic id,
    required int noOfViews,
  }) : super(
            key: key,
            imageUrl: imageUrl,
            title: title,
            createdDateTime: createdDateTime,
            id: id,
            noOfViews: noOfViews);

  @override
  Widget build(BuildContext context) {
    final baseUrl = 'https://www.mbportal.kz';
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
                  id: id,
                ),
              );
            },
          ),
        );
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 150,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: AppColors.colors['colorPrimary'],
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/4.png'),
                    fit: BoxFit.cover
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            '$baseUrl/$imageUrl',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Text(
                          createdDateTime,
                          style:
                              const TextStyle(color: Colors.white, fontSize: 16),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

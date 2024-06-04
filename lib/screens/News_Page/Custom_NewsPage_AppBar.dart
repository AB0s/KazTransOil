import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaz_trans_oil/methods/url_launch.dart';

import '../../generated/locale_keys.g.dart';

class Custom_NewsPage_AppBar extends AppBar {
  Custom_NewsPage_AppBar({
    required String title,
  }) : super(
    backgroundColor: const Color(0xFF0A386A),
    titleSpacing: 0,
    title: Text(
      title,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    ),
    iconTheme: const IconThemeData(
        color: Colors.white
    ),
    actions: [
      IconButton(
        visualDensity:
        const VisualDensity(horizontal: -4.0, vertical: -4.0),
        icon: const Icon(
          FontAwesomeIcons.instagram,
          color: Colors.white,
          size: 26,
        ),
        tooltip: 'Instagram',
        onPressed: () {
          UrlLauncher.launchInstagramURL();
        },
      ),
      IconButton(
        visualDensity:
        const VisualDensity(horizontal: -4.0, vertical: -4.0),
        icon: const Icon(
          FontAwesomeIcons.linkedin,
          color: Colors.white,
          size: 26,
        ),
        tooltip: 'Linkedin',
        onPressed: () {
          UrlLauncher.launchLinkedInURL();
        },
      ),
      IconButton(
        visualDensity:
        const VisualDensity(horizontal: -4.0, vertical: -4.0),
        icon: const Icon(
          FontAwesomeIcons.facebook,
          color: Colors.white,
          size: 26,
        ),
        tooltip: 'Facebook',
        onPressed: () {
          UrlLauncher.launchFacebookURL();
        },
      ),
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          visualDensity:
          const VisualDensity(horizontal: -4.0, vertical: -4.0),
          icon: const Icon(
            FontAwesomeIcons.youtube,
            color: Colors.white,
            size: 26,
          ),
          tooltip: 'YouTube',
          onPressed: () {
            UrlLauncher.launchYouTubeURL();
          },
        ),
      ),
    ],
    bottom: TabBar(
      unselectedLabelColor: Colors.white,
      labelColor: Colors.white,
      indicatorColor: Colors.white,
      tabs: [
        Tab(
          text: LocaleKeys.NewsTab.tr(),
        ),
        Tab(
          text: LocaleKeys.corporate_blog.tr(),
        ),
        Tab(
          text: LocaleKeys.mass_media_news.tr(),
        ),
      ],
    ),
  );
}

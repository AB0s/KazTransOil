import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaz_trans_oil/generated/locale_keys.g.dart';
import 'package:kaz_trans_oil/methods/url_launch.dart';
import '../../AppColors.dart';
import '../../drawer.dart';
import '../../my_flutter_app_icons.dart';
import '../Video_Screen/Show_Video.dart';
import 'Emergency_Call_Center.dart';
import 'HSE_documents/HSE_documents.dart';
import '../ShowInfo.dart';
import 'Media.dart';

class HSE extends StatelessWidget {
  HSE({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> items = [
    {
      'label': LocaleKeys.incident_reviews.tr(),
      'icon': Icons.warning,
      'screen': ShowInfo(type: 2, title: LocaleKeys.incident_reviews.tr(),),
    },
    {
      'label': LocaleKeys.HSE_documents.tr(),
      'icon': Icons.document_scanner_rounded,
      'screen': HSE_documents(),
    },
    {
      'label': LocaleKeys.emergency_call_center.tr(),
      'icon': Icons.emergency,
      'screen': const Emergency_Call_Center(),
    },
    {
      'label': LocaleKeys.QORGAU_card.tr(),
      'icon': Icons.newspaper,
    },
    {
      'label': LocaleKeys.safety_minutes.tr(),
      'icon': FontAwesomeIcons.fileShield,
      'screen': ShowInfo(type: 5, title: LocaleKeys.safety_minutes.tr(),),
    },
    {
      'label': LocaleKeys.golden_rules.tr(),
      'icon': Icons.rule,
      'screen': ShowInfo(type: 3, title: LocaleKeys.golden_rules.tr(),),
    },
    {
      'label': LocaleKeys.visual_aids.tr(),
      'icon': Icons.monetization_on,
      'screen': ShowInfo(type: 6, title: LocaleKeys.visual_aids.tr(),),
    },
    {
      'label': LocaleKeys.media_library.tr(),
      'icon': MyFlutterApp.ic_hse_media,
      'screen': ShowMedia(title: LocaleKeys.media_library.tr(),type: 2,),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A386A),
        title: const Text("HSE", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const Drawer1(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/light_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: (.35 / .5),
            shrinkWrap: true,
            children: List.generate(items.length, (index) {
              final String itemLabel = items[index]['label'];
              final IconData itemIcon = items[index]['icon'];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    if (index == 3) {
                      UrlLauncher.launchQorgauUrl();
                    } else {
                      final screen = items[index]['screen'] as Widget;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => screen,
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Icon(
                            itemIcon,
                            color: AppColors.colors['colorPrimary'],
                            size: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 15,top: 5),
                          child: Text(
                            itemLabel,
                            style: TextStyle(
                              color: AppColors.colors['colorPrimary'],
                              fontSize: 16.5,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines:
                            (MediaQuery.of(context).textScaleFactor > 1.3)
                                ? 2
                                : 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

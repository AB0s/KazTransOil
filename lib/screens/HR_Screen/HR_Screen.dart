import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaz_trans_oil/generated/locale_keys.g.dart';
import '../../AppColors.dart';
import '../../drawer.dart';
import '../../my_flutter_app_icons.dart';

import '../ShowInfo.dart';

class HR_Screen extends StatelessWidget {
  HR_Screen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> items = [
    {
      'label': LocaleKeys.hr_documents.tr(),
      'icon':FontAwesomeIcons.fileInvoice,
      'screen': ShowInfo(type: 15, title: LocaleKeys.hr_documents.tr(),),
    },
    {
      'label': LocaleKeys.hr_manual.tr(),
      'icon': MyFlutterApp.ic_hse_visual_aids,
      'screen': ShowInfo(type: 0, title: LocaleKeys.hr_manual.tr(),)
    },
    {
      'label': LocaleKeys.hr_template.tr(),
      'icon': FontAwesomeIcons.fileSignature,
      'screen': ShowInfo(type: 0, title: LocaleKeys.hr_template.tr(),)
    },
    {
      'label': LocaleKeys.media_library.tr(),
      'icon': MyFlutterApp.ic_hse_media,
      'screen': ShowInfo(type: 0, title: LocaleKeys.media_library.tr(),)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A386A),
        title: const Text("HR", style: TextStyle(color: Colors.white)),
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
          child: SingleChildScrollView(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: (.4 / .5),
              shrinkWrap: true,
              children: List.generate(items.length, (index) {
                final String itemLabel = items[index]['label'];
                final IconData itemIcon = items[index]['icon'];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                        final screen = items[index]['screen'] as Widget;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => screen,
                          ),
                        );
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
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              itemLabel,
                              style: TextStyle(
                                color: AppColors.colors['colorPrimary'],
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
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
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaz_trans_oil/generated/locale_keys.g.dart';
import 'package:kaz_trans_oil/my_flutter_app_icons.dart';

import '../../../AppColors.dart';
import '../../../drawer.dart';
import '../../ShowInfo.dart';

class HSE_documents extends StatelessWidget {
  HSE_documents({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> items = [
    {
      'label': LocaleKeys.ic_hse_doc_general.tr(),
      'icon': FontAwesomeIcons.fileLines,
      'screen': ShowInfo(
        type: 13,
        title: LocaleKeys.ic_hse_doc_general.tr(),
      )
    },
    {
      'label': LocaleKeys.ic_hse_doc_safe_labor_protect.tr(),
      'icon': FontAwesomeIcons.shieldHalved,
      'screen': ShowInfo(
        type: 7,
        title: LocaleKeys.ic_hse_doc_safe_labor_protect.tr(),
      )
    },
    {
      'label': LocaleKeys.ic_hse_doc_industrial_security.tr(),
      'icon': FontAwesomeIcons.industry,
      'screen': ShowInfo(
        type: 11,
        title: LocaleKeys.ic_hse_doc_industrial_security.tr(),
      )
    },
    {
      'label': LocaleKeys.ic_hse_doc_transport_security.tr(),
      'icon': MyFlutterApp.ic_hse_doc_transport_security,
      'screen': ShowInfo(
        type: 12,
        title: LocaleKeys.ic_hse_doc_transport_security.tr(),
      )
    },
    {
      'label': LocaleKeys.ic_hse_doc_fire_safety.tr(),
      'icon': MyFlutterApp.ic_hse_doc_fire_safety,
      'screen': ShowInfo(
        type: 10,
        title: LocaleKeys.ic_hse_doc_fire_safety.tr(),
      )
    },
    {
      'label': LocaleKeys.ic_hse_doc_health_security.tr(),
      'icon': FontAwesomeIcons.heartPulse,
      'screen': ShowInfo(
        type: 9,
        title: LocaleKeys.ic_hse_doc_health_security.tr(),
      )
    },
    {
      'label': LocaleKeys.ic_hse_doc_environment_security.tr(),
      'icon': FontAwesomeIcons.leaf,
      'screen': ShowInfo(
        type: 9,
        title: LocaleKeys.ic_hse_doc_environment_security.tr(),
      )
    },
    {
      'label': LocaleKeys.ic_hse_doc_civil_defense.tr(),
      'icon': FontAwesomeIcons.personMilitaryToPerson,
      'screen': ShowInfo(
        type: 14,
        title: LocaleKeys.ic_hse_doc_civil_defense.tr(),
      )
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A386A),
        title: Text(LocaleKeys.HSE_documents.tr(),
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              crossAxisCount: 2,
              childAspectRatio: (.6 / .45),
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
                              overflow: TextOverflow.ellipsis,
                              maxLines:
                                  (MediaQuery.of(context).textScaleFactor > 1.3)
                                      ? 1
                                      : 2,
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

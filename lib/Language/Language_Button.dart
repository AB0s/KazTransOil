import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kaz_trans_oil/AppColors.dart';
import 'package:kaz_trans_oil/Language/Language.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../methods/RestartWidget.dart';

class LanguageToggleButton extends StatefulWidget {
  @override
  _LanguageToggleButtonState createState() => _LanguageToggleButtonState();
}

class _LanguageToggleButtonState extends State<LanguageToggleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (context.locale == const Locale('ru')) {
            context.setLocale(const Locale('en'));
            Language.setLanguageCode(context);
          } else {
            context.setLocale(const Locale('ru'));
            Language.setLanguageCode(context);
          }
        });
        RestartWidget.restartApp(context);
      },
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
              alignment: context.locale == const Locale('ru')
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: 45,
                height: 41,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
            Opacity(
              opacity: context.locale == const Locale('ru') ? 1 : 0.4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Rus",
                    style: MediaQuery.of(context).textScaleFactor>1.3?
                    const TextStyle(fontSize: 16):const TextStyle(fontSize: 20)
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: context.locale == const Locale('ru') ? 0.4 : 1,
              child:  Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "Kaz",
                      style: MediaQuery.of(context).textScaleFactor>=1.3?
                      const TextStyle(fontSize: 16):const TextStyle(fontSize: 20)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

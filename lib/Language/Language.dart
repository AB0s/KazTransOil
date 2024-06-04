import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class Language {
  static int languageCode = 1;

  static void setLanguageCode(BuildContext context) {
    if (context.locale == Locale('ru')) {
      languageCode = 2;
    } else {
      languageCode = 1;
    }
  }
}

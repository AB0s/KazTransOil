import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaz_trans_oil/AppColors.dart';
import 'package:kaz_trans_oil/generated/locale_keys.g.dart';
import 'package:kaz_trans_oil/screens/EQuiz_Screen/e_quiz_screen.dart';
import 'package:kaz_trans_oil/screens/HR_Screen/HR_Screen.dart';
import 'package:kaz_trans_oil/screens/HSE_Screens/HSE_screen.dart';
import 'package:kaz_trans_oil/screens/Munaiqubyrshy_screen.dart';
import 'package:kaz_trans_oil/screens/Video_Screen/Video_screen.dart';

import 'Language/Language_Button.dart';
import 'main.dart';
import 'methods/Fade_transition.dart';

class Drawer1 extends StatefulWidget {
  const Drawer1({Key? key}) : super(key: key);

  @override
  State<Drawer1> createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/light_background_menu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
                height: 120,
                color: AppColors.colors['colorPrimary'],
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  width: 180,
                  child: Image.asset('assets/logo_horizontal.png'),
                )),
            ListTile(
                leading: const Icon(FontAwesomeIcons.house),
                title: Text(LocaleKeys.Main.tr()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    FadeRoute(widget: const MyHomePage()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.dvr),
                title: const Text("E-Quiz"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    FadeRoute(widget: EQuiz()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.verified_user),
                title: const Text("HSE"),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(
                      const Duration(milliseconds: 150)); // wait some time
                  Navigator.push(
                    context,
                    FadeRoute(widget: HSE()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("HR"),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(
                      const Duration(milliseconds: 150)); // wait some time
                  Navigator.push(
                    context,
                    FadeRoute(widget: HR_Screen()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text("Видео"),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(
                      const Duration(milliseconds: 150)); // wait some time
                  Navigator.push(
                    context,
                    FadeRoute(widget: const Video_Scr()),
                  );
                }),
            ListTile(
                leading: const Icon(FontAwesomeIcons.oilWell),
                title: const Text("Munaiqubyrshy"),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(
                      const Duration(milliseconds: 150)); // wait some time
                  Navigator.push(
                    context,
                    FadeRoute(widget: const Munaiqubyrshy()),
                  );
                }),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LanguageToggleButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

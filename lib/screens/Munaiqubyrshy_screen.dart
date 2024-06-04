import 'package:flutter/material.dart';
import 'package:kaz_trans_oil/screens/ShowInfo.dart';

import '../drawer.dart';
class Munaiqubyrshy extends StatelessWidget {
  const Munaiqubyrshy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer1(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/light_background_menu.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const ShowInfo(type: 1, title: 'Munaiqubyrshy',),
      ),
    );
  }
}

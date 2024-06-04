import 'package:flutter/material.dart';

import '../../drawer.dart';
import 'Show_Video.dart';

class Video_Scr extends StatelessWidget {
  const Video_Scr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    List<Widget> tabWidgets = [];
    for(int i=currentYear;i>=2019;i--){
      tabWidgets.add(Tab(text: '$i',));
    }
    List<Widget> tabViewWidgets = [];
    for(int i=currentYear;i>=2019;i--){
      tabViewWidgets.add(ShowVideoScreen(year: i,));
    }
    return DefaultTabController(
      length: tabWidgets.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A386A),
          title: const Text(
            "Видео",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: TabBar(
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              isScrollable: tabWidgets.length > 5 ? true : false,
              tabs: tabWidgets
          ),
        ),
        drawer: const Drawer1(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/light_background_menu.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: TabBarView(
            children: tabViewWidgets
          ),
        ),
      ),
    );
  }
}

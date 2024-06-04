import 'package:flutter/material.dart';

import '../drawer.dart';
class HR extends StatelessWidget {
  const HR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A386A),
        title: const Text("HR",style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.white
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
      ),
    );
  }
}

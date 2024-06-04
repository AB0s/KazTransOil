import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kaz_trans_oil/generated/codegen_loader.g.dart';
import 'package:kaz_trans_oil/methods/RestartWidget.dart';
import 'package:kaz_trans_oil/screens/News_Page/Corporative_block.dart';
import 'package:kaz_trans_oil/screens/News_Page/Custom_NewsPage_AppBar.dart';
import 'package:kaz_trans_oil/screens/News_Page/News.dart';
import 'package:kaz_trans_oil/screens/News_Page/Our_TV.dart';
import 'drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: RestartWidget(child: const MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KazTransOil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const int tabsCount = 3;
    return DefaultTabController(
      length: tabsCount,
      child: Scaffold(
        drawer: const Drawer1(),
        appBar: Custom_NewsPage_AppBar(
          title: 'KazTransOil',
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/light_background_menu.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const TabBarView(
            children: [
              News(),
              Corporative_Block(),
              Our_TV(),
            ],
          ),
        ),
      ),
    );
  }
}

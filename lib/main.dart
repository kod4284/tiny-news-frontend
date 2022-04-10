import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstore/localstore.dart';

import 'widgets/pages/main_page.dart';
import 'widgets/pages/onboarding_page.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  await dotenv.load(fileName: ".env");
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  final db = Localstore.instance.collection("storage").doc("settings");
  final collection = await db.get();
  if (collection == null) {
    db.set({
      "autoplay": false,
      "volume": 1,
      "pitch": 1,
      "rate": 1.4,
    });
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiny News',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF3A3A3A),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 20
          ),
          bodyText2: TextStyle(
            fontSize: 14
          ),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: OnBoardingPage(),
        // child: MainPage(),
      )
    );
  }
}

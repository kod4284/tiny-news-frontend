import 'package:flutter/material.dart';

import 'widgets/pages/main_page.dart';

void main() {
  runApp(const MyApp());
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
      home: const DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: MainPage(),
      )
    );
  }
}

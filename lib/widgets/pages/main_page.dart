import 'package:flutter/material.dart';
import 'package:tiny_news/widgets/commons/horizontal_menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          title: const Image(
            width: 210,
            image: AssetImage('images/tiny_news.png'),
            fit: BoxFit.contain
          )
          ),
        ),
      body: Column(
        children: [
          HorizontalMenu(
            menus: const [
              'All',
              'Economics',
              'Entertainment',
              'Health',
              'Lifestyles',
              'Politices',
              'Science',
              'Sports'
            ],
            onClick: (e) => {print(e)},
          )
        ],
      )
    );
  }
}

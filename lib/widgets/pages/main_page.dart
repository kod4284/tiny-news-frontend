import 'package:flutter/material.dart';
import 'package:tiny_news/widgets/commons/horizontal_menu.dart';
import 'package:tiny_news/widgets/commons/news_card.dart';

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
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          title: const Image(
            width: 210,
            image: AssetImage('images/tiny_news.png'),
            fit: BoxFit.contain
          )
          ),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 20,
                color: Colors.indigo,
              ),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 45,
                  width: 370,
                  child: TextField(
                    onSubmitted: (e) => {print(e)},
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      fillColor: const Color(0xff65666D),
                      filled: true,
                      hintStyle: const TextStyle(color: Color(0xffa7a7a7)),
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Search articles',
                    ),
                  )
                ),
              )
            ],
          ),
          HorizontalMenu(
            menus: const [
              'All',
              'Economics',
              'Entertainment',
              'Health',
              'Lifestyles',
              'Politics',
              'Science',
              'Sports'
            ],
            onClick: (e) => {print(e)},
          ),
          NewsCard(
            title: "Sports News: Cricket News, Football News, Hockey News, Sports Breaking News",
            url: "https://www.business-standard.com/article/sports/ind-vs-sl-prediction-1st-t20i-toss-india-sri-lanka-playing-11-at-hpca-122022600518_1.html",
            cleanUrl: "business-standard.com",
            thumbnailUrl: "https://bsmedia.business-standard.com/_media/bs/img/common/no_preview.jpg",
            date: "2020/03/02"
          )
        ],
      )
    );
  }
}

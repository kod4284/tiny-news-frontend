import 'package:flutter/material.dart';
import 'package:tiny_news/utils/tiny_api.dart';
import 'package:tiny_news/widgets/commons/horizontal_menu.dart';
import 'package:tiny_news/widgets/commons/news_card.dart';
import 'package:tiny_news/widgets/commons/tiny_icon_button.dart';
import 'package:tiny_news/widgets/pages/user_preference_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  late Future<List<Article>> futureArticleList = [] as Future<List<Article>>;

  @override
  void initState() {
    futureArticleList = Api.fetchNews(topic: 'Your News');
    super.initState();
  }

  void refetchData(String topic) {
    setState(() {
      futureArticleList = Api.fetchNews(topic: topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
              Container(
                  alignment: Alignment.center,
                  child: const Image(
                      width: 210,
                      image: AssetImage('images/tiny_news.png'),
                      fit: BoxFit.contain
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 13),
                alignment: Alignment.bottomRight,
                child: TinyIconButton(
                    icon: Icons.settings,
                    width: 40,
                    height: 40,
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:
                      (context) => const UserPreferencePage()
                      ));
                    }),
              )
            ],
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
                    onSubmitted: (e) => {refetchData(e)},
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
              'Your News',
              'All',
              'Economics',
              'Entertainment',
              'Health',
              'Lifestyles',
              'Politics',
              'Science',
              'Sports'
            ],
            onClick: (e) => {refetchData(e)},
          ),
          FutureBuilder<List<Article>>(
            future: futureArticleList,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(
                  width: 300,
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Expanded(child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!
                    .map((e) => NewsCard(
                  title: e.title,
                  date: e.date,
                  url: e.url,
                  thumbnailUrl: e.thumbnail,
                  cleanUrl: e.cleanUrl,
                  summary: e.summary,
                )).toList()
              ));
            },
          )
        ],
      )
    );
  }
}

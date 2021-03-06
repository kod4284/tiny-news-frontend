import 'package:flutter/material.dart';
import 'package:tiny_news/widgets/pages/original_article_page.dart';
import 'package:tiny_news/widgets/commons/tts_audio.dart';

class SummaryPage extends StatelessWidget {
  final String title;
  final String summary;
  final String url;

  const SummaryPage({
    Key? key,
    required this.title,
    required this.summary,
    required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('News Summary'),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: const Image(
                        width: double.infinity,
                        image: AssetImage('images/ad.png'),
                        fit: BoxFit.contain
                    )
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          )
                      ),
                      const Divider(),
                      Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                              summary,
                              style: const TextStyle(fontSize: 16, letterSpacing: 1, height: 1.3)
                          )
                      ),
                      TTSAudio(text: title+". "+summary),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder:
                                  (context) => OriginalArticlePage(url: url)
                              ),
                            );
                          },
                          child: const Text("View original news"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        ),
    );
  }
}

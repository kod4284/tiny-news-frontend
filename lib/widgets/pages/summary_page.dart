import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.only(top: 20),
            child: Column(
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
                const Divider(),
                ElevatedButton(
                  onPressed: () {  },
                  child: const Text("View original news"),
                )
              ],
            )
          ),
        ),
    );
  }
}

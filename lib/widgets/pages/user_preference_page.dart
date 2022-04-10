import "package:flutter/material.dart";
import 'package:tiny_news/widgets/commons/tiny_group_button.dart';
import 'package:tiny_news/widgets/commons/tiny_group_photo_button.dart';

class UserPreferencePage extends StatefulWidget {
  const UserPreferencePage({Key? key}) : super(key: key);

  @override
  State<UserPreferencePage> createState() => _UserPreferencePageState();
}

class _UserPreferencePageState extends State<UserPreferencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Preference'),
        ),
        body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Your favorite topics",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TinyGroupButton(
                    buttonList: [
                      "Economics",
                      "Entertainment",
                      "Health",
                      "Lifestyles",
                      "Politics",
                      "Science",
                      "Sports",
                      "Foods",
                      "Beauty",
                      "Business",
                      "Pets",
                      "Technologies"
                    ],
                    selected: ["Science"],
                    onSelected: (e) => print(e),
                  ),
                ),
                Divider(color: Colors.white,),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Your favorite boardcasters",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TinyGroupPhotoButton(
                    buttonList: [
                      "latimes.com",
                      "cnn.com",
                      "foxnews.com",
                      "theatlantic.com",
                      "politico.com",
                      "9to5mac.com",
                      "abc.com",
                      "theguardian.com",
                      "yahoo.com",
                    ],
                    selected: [],
                    onSelected: (e) => print(e),
                  ),
                )
              ],
            )
        )
    );
  }
}

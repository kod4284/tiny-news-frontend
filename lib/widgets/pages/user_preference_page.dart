import "package:flutter/material.dart";
import 'package:tiny_news/widgets/commons/tiny_group_button.dart';
import 'package:tiny_news/widgets/commons/tiny_group_photo_button.dart';
import 'package:localstore/localstore.dart';

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
            child: ListView(
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
                  child: FutureBuilder(
                      future: Localstore.instance.collection("storage").doc("preferences").get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData){
                          return Text("loading...");
                        }
                        print(snapshot.data);
                        return Container(
                          alignment: Alignment.center,
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
                            selected: (snapshot.data as dynamic)!['categories']?.cast<String>(),
                            onSelected: (e) {
                                () async {
                                  final db = Localstore.instance.collection("storage").doc("preferences");
                                  final temp = await db.get();
                                  db.set(
                                    {
                                      "categories": e,
                                      "broadcasters": temp!["broadcasters"],
                                    },
                                  );
                              }();
                            },
                          )
                        );
                      }
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
                FutureBuilder(
                  future: Localstore.instance.collection("storage").doc("preferences").get(),
                  builder: (context, snapshot) {
                      if (!snapshot.hasData){
                        return Text("loading...");
                      }
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 30),
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
                          selected: (snapshot.data as dynamic)!['broadcasters']?.cast<String>(),
                          onSelected: (e) {
                            () async {
                              final db = Localstore.instance.collection("storage").doc("preferences");
                              final temp = await db.get();
                              db.set(
                                  {
                                    "categories": temp!["categories"],
                                    "broadcasters": e,
                                  },
                              );
                            }();
                          },
                        ),
                      );
                    }
                  ),
              ],
            )
        )
    );
  }
}

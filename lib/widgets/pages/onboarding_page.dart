import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tiny_news/widgets/commons/tiny_group_button.dart';
import 'package:tiny_news/widgets/commons/tiny_group_photo_button.dart';
import 'package:localstore/localstore.dart';

import 'package:tiny_news/widgets/pages/main_page.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  List<String> _categories = [];
  List<String> _broadcasters = [];

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MainPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(color: Colors.black87, fontSize: 16.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(color: Colors.black87, fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xE5E5E5),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Color(0xFFE5E5E5),
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "",
          body: "",
          image: Container(
            margin: EdgeInsets.only(top: 150, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Welcome to",
                  style: TextStyle(color: Colors.black54, fontSize: 45, height: 2),
                ),
                Text(
                    "Tiny News",
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 45, height: 1.2),
                ),
                Divider(
                  color: Colors.black,
                ),
                Text(
                  "The best stories from the source you love, selected just for you. The more you read, the more personalized your news becomes.",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.2),
                )
              ],
            ),
          ),
          decoration: pageDecoration.copyWith(
            imageFlex: 12,
          ),
        ),
        PageViewModel(
          title: "Customize your News",
          footer: Container(
            margin: EdgeInsets.only(bottom: 250),
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
              onSelected: (e) => setState(() => {
                _categories = e
              }),
            ),
          ),
          body:
          "Make TinyNews uniquely yours by setting your favorite topic now.",
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 10,
            imageFlex: 2,
          ),
        ),
        PageViewModel(
          title: "Customize your News",
          footer: Container(
            margin: EdgeInsets.only(bottom: 250),
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
              onSelected: (e) => {
                setState(() => {
                  _broadcasters = e
                })
              },
            ),
          ),
          body:
          "Make TinyNews uniquely yours by setting your favorite broadcaster now.",
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 10,
            imageFlex: 2,
          ),
        ),

      ],
      onDone: ()
      {
        final db = Localstore.instance.collection("storage").doc("preferences");
        db.set(
          {
            "categories": _categories,
            "broadcasters": _broadcasters,
          }
        );
        _onIntroEnd(context);
      },
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      // showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
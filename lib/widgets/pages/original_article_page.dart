import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OriginalArticlePage extends StatelessWidget {
  final String url;

  const OriginalArticlePage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Original Article'),
      ),
        body: Container(
          child:WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onProgress: (int progress) {
        print('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
        print('Page started loading: $url');
        },
        onPageFinished: (String url) {
        print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
        )
        )
    );
  }
}
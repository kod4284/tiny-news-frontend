import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String newsUrl = "https://tinynews.ananthd.dev/articles/";

String _getNewsUrl({required String topic, required int pageSize}) {
  String newUrl = newsUrl + topic + "?limit=" + pageSize.toString();
  return newUrl;
}

class Api {
  static Future<List<Article>> fetchNews({ required String topic, int pageSize = 15}) async {
    final response = await http.get(
        Uri.parse(_getNewsUrl(
            topic: topic,
            pageSize: pageSize
        )),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<Article>((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load news info');
    }
  }
}

class Article {
  final String title;
  final String date;
  final String url;
  final String cleanUrl;
  final String summary;
  final String thumbnail;

  const Article({
    required this.title,
    required this.date,
    required this.url,
    required this.cleanUrl,
    required this.summary,
    required this.thumbnail
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    int dotPosition = json['clean_url'].indexOf('.');
    return Article(
        title: json['article_title'] ?? '',
        date: json['article_time'].substring(0, 16) ?? '',
        url: json['article_url'] ?? '',
        cleanUrl: json['clean_url'].substring(0, dotPosition) ?? '',
        summary: json['article_text'] ?? '',
        thumbnail: json['article_picture'] ?? ''
    );
  }
}

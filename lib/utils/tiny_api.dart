import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstore/localstore.dart';

String newsUrl = "https://tinynews.ananthd.dev/articles/";

String _getNewsUrl({required String topic, required int pageSize, List<String>? topics, List<String>? broadcasters}) {
  String newUrl = newsUrl + topic + "?limit=" + pageSize.toString();
  if (topic == "Your News") {
    if (topics?.length != 0 || broadcasters?.length != 0) {
      newUrl = "https://tinynews.ananthd.dev/articles/preference?";
      topics?.forEach((e) => newUrl += ("&categories=" + e));
      broadcasters?.forEach((e) => newUrl += ("&broadcasters=" + e));
    } else {
      newUrl = "Please select your preferences in the setting page.";
    }
  }
  return newUrl;
}

class Api {
  static Future<List<Article>> fetchNews({ required String topic, int pageSize = 15}) async {
    final db = Localstore.instance.collection("storage");
    final preferencesDB = db.doc("preferences");
    final pCollection = await preferencesDB.get();
    List<String> topics = pCollection?["categories"]?.cast<String>();
    List<String> broadcasters = pCollection?["broadcasters"]?.cast<String>();
    if (topic == "Your News") {
      print(topics);
      if (topics.length == 0 && broadcasters.length == 0) {
        throw Exception("Please select your preferences in the setting page.");
      }
    }
    final response = await http.get(
        Uri.parse(_getNewsUrl(
            topic: topic == "All" ? "all": topic,
            pageSize: pageSize,
            topics: topics,
            broadcasters: broadcasters
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

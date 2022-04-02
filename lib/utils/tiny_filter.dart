import 'package:tiny_news/utils/api.dart';

class TinyFilter {
  static List<Article> filter(List<Article> articles) {
    return articles.where((e) => !e.summary.contains(
      "Use of this Website assumes acceptance of Terms & Conditions and Privacy Policy"
    )).toList();
  }
}
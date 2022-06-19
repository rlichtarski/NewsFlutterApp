import 'package:flutter/cupertino.dart';
import 'package:news_app/models/article.dart';

class SavedArticlesViewModel extends ChangeNotifier {

  final List<Article> savedArticles;

  SavedArticlesViewModel() : savedArticles = [];

  void addArticle(Article article) {
    savedArticles.add(article);
    notifyListeners();
  }

  void removeArticle(Article article) {
    savedArticles.remove(article);
    notifyListeners();
  }

  bool isArticleSaved(Article article) => savedArticles.contains(article) ? true : false;

  int get totalArticles => savedArticles.length;

  bool get savedArticlesNotEmpty => savedArticles.isNotEmpty;

}
 
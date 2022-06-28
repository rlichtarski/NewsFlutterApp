import 'package:flutter/cupertino.dart';

class UIUpdatesNotifier extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  String _articleCategory = 'Sport';
  String get articleCategory => _articleCategory;

  void isLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

  void setArticleCategory(String category) {
    _articleCategory = category;
    notifyListeners();
  }

}

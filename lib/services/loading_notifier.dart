import 'package:flutter/cupertino.dart';

class UIUpdatesNotifier extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  void isLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

}

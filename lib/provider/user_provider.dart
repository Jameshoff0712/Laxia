import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late int currentPageIndex = 0;

  get getCurrentPageIndex => currentPageIndex;
  void setCurrentPageIndex(int PageIndex) {
    currentPageIndex = PageIndex;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late int currentPageIndex = 0;

  get getCurrentPageIndex => currentPageIndex;
  void setCurrentPageIndex(int PageIndex) {
    currentPageIndex = PageIndex;
    notifyListeners();
  }
  late int currentPartIndex = 0;

  get getCurrentPartIndex => currentPageIndex;
  void setCurrentPartIndex(int PartIndex) {
    currentPartIndex = PartIndex;
    notifyListeners();
  }
  late String searchtext = "";

  get getSearchtext => searchtext;
  void setSearchtext(String value) {
    searchtext = value;
    notifyListeners();
  }
}

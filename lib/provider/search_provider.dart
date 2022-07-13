import 'package:flutter/material.dart';
import 'package:laxia/models/me_model.dart';

class SearchProvider extends ChangeNotifier {
  List<int> mark = [6,6,6,6,6];
  int minprice=0,maxprice=0,year=0;

  void setMark(List<int> star) {
    for(int i=0;i<5;i++)
    {
      mark[i]=star[i];
    }
    notifyListeners();
  }
  void setminprice(int price) {
    minprice = price;
    notifyListeners();
  }
  void setmaxprice(int price) {
    maxprice= price;
    notifyListeners();
  }
  void setYear(int val){
    year=val;
    notifyListeners();
  }
}

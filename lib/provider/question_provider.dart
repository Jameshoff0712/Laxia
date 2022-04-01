import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier {
  late int curePos = 0;
  late String btnText = "";

  get getSelectedCurePos => curePos;
  void setSelectedCurePos(int PageIndex) {
    curePos = PageIndex;
    notifyListeners();
  }

  get getButtonText => btnText;
  void setButtonText(String text) {
    btnText = text;
    notifyListeners();
  }
}

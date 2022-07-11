import 'package:flutter/material.dart';

class PrefProvider extends ChangeNotifier {
  late List<int> selectedCurePos = [];
  late List<String> selectedCurePosStr = [];
  late String btnText = "";

  get getSelectedCurePos => selectedCurePos;
  get getSelectedCurePosStr {
    String strPos = "";
    if (selectedCurePosStr.isNotEmpty) {
      for (var posStr in selectedCurePosStr) {
        strPos += posStr + ", ";
      }
      strPos = strPos.substring(0, strPos.length - 2);
    }
    return strPos;
  }

  void setSelectedCurePos(int curePos, String curePosStr) {
    int index = 0;
    if (selectedCurePos.contains(curePos)) {
      index = selectedCurePos.indexOf(curePos);
      selectedCurePos.remove(curePos);
    } else
      selectedCurePos.add(curePos);

    if (index > 0)
      selectedCurePosStr.removeAt(index);
    else
      selectedCurePosStr.add(curePosStr);
    notifyListeners();
  }

  void initSelected() {
    selectedCurePos.clear();
    selectedCurePosStr.clear();
    notifyListeners();
  }

  get getButtonText => btnText;
  void setButtonText(String text) {
    btnText = text;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:laxia/models/me_model.dart';

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
  late bool completed = false;

  get getcompleted => completed;
  void setCompleted(bool value) {
    completed = value;
    notifyListeners();
  }

  late Me currentMe;
  get getMe => currentMe;
  void setMe(Me me) {
    currentMe = me;
    notifyListeners();
  }
  void logout(){
    isAuthorized = false;
  }

  late bool isAuthorized = false;

  get getIsAuthorized => isAuthorized;
  void setIsAuthorized(bool newAuthorized) {
    isAuthorized = newAuthorized;
  }

  String selectedClinic = "";
  get getSelectedClinic => selectedClinic;
  void setSelectedClinic(String newSelectedClinic) {
    selectedClinic = newSelectedClinic;
    notifyListeners();
  }

  String selectedDoctor = "";
  get getSelectedDoctor => selectedDoctor;
  void setSelectedDoctor(String newSelectedDoctor) {
    selectedDoctor = newSelectedDoctor;
    notifyListeners();
  }
  void initSelected() {
    searchtext='';
    notifyListeners();
  }
}

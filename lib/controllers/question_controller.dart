import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class QuestionController extends ControllerMVC {
  GlobalKey<ScaffoldState>? scaffoldKey;
  //String cure_content = "";
  List<String>? image_list = [];
  TextEditingController question_titleCtrl = TextEditingController();
  TextEditingController question_contentCtrl = TextEditingController();

  QuestionController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

}

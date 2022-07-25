import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:laxia/models/case/Owner_model.dart';
import 'package:laxia/models/diary/diary/progress.dart';
import 'package:laxia/models/diary/diary/text_question.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';
import 'package:laxia/models/question/media_model.dart';


class MenuDetail_Model extends Equatable {
  final Menu_Sub_Model menu;
  final List<Process_Model> process;
  final List<Diary_Sub_Model> diaries;
  const MenuDetail_Model({
    required this.menu,
    required this.process,
    required this.diaries,
    // required this.diary,
    // required this.owner,
    // this.menus,
    // required this.text_questions,
  });

  factory MenuDetail_Model.fromJson(Map<String, dynamic> json) {
    return MenuDetail_Model(
      menu: Menu_Sub_Model.fromJson(json),
      // owner:Owner.fromJson(json["owner"]),
      diaries: List<Diary_Sub_Model>.from(json["diaries"].map(
              (x) => Diary_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      process:json["process"]==null?[]: List<Process_Model>.from(json["process"]
              .map((x) => Process_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [
    ];
}

class Process_Model extends Equatable {
  final String title;
  final int period;
  const Process_Model({required this.title, required this.period});

  factory Process_Model.fromJson(Map<String, dynamic> json) {
    return Process_Model(
        title: json["title"],
        period: json["period"]);
  }
  @override
  List<Object?> get props => [
      ];
}
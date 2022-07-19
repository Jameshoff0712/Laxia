import 'package:equatable/equatable.dart';
import 'package:laxia/models/case/Owner_model.dart';
import 'package:laxia/models/diary/diary/progress.dart';
import 'package:laxia/models/diary/diary/text_question.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/question/media_model.dart';

import '../../case/menu_sub_model.dart';

class DiaryDetail_Model extends Equatable {
  final Diary_Sub_Model diary;
  final Owner owner;
  final List<Menu_Sub_Model>? menus;
  final List<Test_Question> text_questions;
  final List<Media_model>? medias;
  final List<Progress>? progresses;
  final List<Diary_Sub_Model> diaries;
  const DiaryDetail_Model( {
    required this.diaries,
    this.progresses,
    this.medias,
    required this.diary,
    required this.owner,
    this.menus,
    required this.text_questions,
  });

  factory DiaryDetail_Model.fromJson(Map<String, dynamic> json) {
    return DiaryDetail_Model(
      diary: Diary_Sub_Model.fromJson(json),
      owner:Owner.fromJson(json["owner"]),
      menus: List<Menu_Sub_Model>.from(json["menus"].map(
              (x) => Menu_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      text_questions:json["text_questions"]==null?[]: List<Test_Question>.from(json["text_questions"]
              .map((x) => Test_Question.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      medias:json["medias"]==null?[]: List<Media_model>.from(json["medias"]
              .map((x) => Media_model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      diaries:json["menus"][0][["diaries"]]==null?[]: List<Diary_Sub_Model>.from(json["menus"][0][["diaries"]]
              .map((x) => Diary_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      progresses:json["progresses"]==null?[]: List<Progress>.from(json["progresses"]
              .map((x) => Progress.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [
        owner,
        menus,
        text_questions,
    ];
}

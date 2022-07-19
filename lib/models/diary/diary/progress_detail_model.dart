import 'package:equatable/equatable.dart';
import 'package:laxia/models/diary/diary/comment_model.dart';
import 'package:laxia/models/diary/diary/progress.dart';
import 'package:laxia/models/diary/diary/status_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';

import '../../case/menu_sub_model.dart';

class ProgressDetail_Model extends Equatable {
  final Progress progress;
  final List<Comment_Model> comments;
  final List<Status_Model> statuses;
  final Diary_Sub_Model diary;
  final Menu_Sub_Model menu;
  final List<Diary_Sub_Model> diaries;
  const ProgressDetail_Model({
    required this.comments,
    required this.statuses,
    required this.progress,
    required this.diary,
    required this.menu,
    required this.diaries
  });

  factory ProgressDetail_Model.fromJson(Map<String, dynamic> json) {
    return ProgressDetail_Model(
      progress: Progress.fromJson(json),
      diary: Diary_Sub_Model.fromJson(json["diary"]),
      menu: Menu_Sub_Model.fromJson(json["diary"]["menus"][0]),
      statuses: List<Status_Model>.from(json["statuses"]
                  .map((x) => Status_Model.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
      diaries: List<Diary_Sub_Model>.from(json["diary"]["menus"][0]["diaries"]
                  .map((x) => Diary_Sub_Model.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
      comments: List<Comment_Model>.from(json["comments"]
                  .map((x) => Comment_Model.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [];
}

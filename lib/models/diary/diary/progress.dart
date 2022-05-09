import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:laxia/models/question/media_model.dart';

class Progress extends Equatable {
  final int id;
  final int? diary_id;
  final int? from_treat_day;
  final String? content;
  final String? created_at;
  final String? updated_at;
  final List<Media_model>? medias;

  const Progress({required this.id, this.updated_at, this.medias,this.diary_id,  this.from_treat_day,  this.content,  this.created_at});

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
        diary_id: json["diary_id"],
        from_treat_day: json["from_treat_day"],
        content: json["content"],
        created_at:json["created_at"], 
        id: json["id"],
        updated_at:json["updated_at"],
        medias: json["medias"]==null?[]: List<Media_model>.from(json["medias"]
              .map((x) => Media_model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
        );
  }
  @override
  List<Object?> get props => [
        diary_id,
        from_treat_day,
        content,
        created_at
      ];
}

class Pivot extends Equatable {
  final int? diary_id;
  final int? question_id;
  final int? answer;
  const Pivot({this.answer,this.diary_id, this.question_id});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
        answer:json["answr"],
        diary_id: json["diary_id"],
        question_id: json["question_id"]);
  }
  @override
  List<Object?> get props => [
         diary_id,
        question_id,
        answer
      ];
}
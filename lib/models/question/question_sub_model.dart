import 'package:equatable/equatable.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/models/question/Owner_model.dart';
import 'package:laxia/models/question/answer_model.dart';

class Question_Sub_Model extends Equatable {
  final int id;
  final int? patient_id;
  final String? title;
  final String? content;
  final String? created_at;
  final String? updated_at;
  final int? comments_count;
  final int? views_count;
  final int? likes_count;
  final bool? is_like;
  final bool? is_favorite;
  final List<Answer>? answers;
  final Owner? owner;
  final List<String>? medias;
  final List<Category>? categories;

  const Question_Sub_Model(
      {required this.id,
      this.answers,
      this.owner, 
      this.patient_id,
      this.title,
      this.content,
      this.created_at,
      this.updated_at,
      this.comments_count,
      this.views_count,
      this.likes_count,
      this.is_like,
      this.is_favorite,
      this.medias,
      this.categories
      });

  factory Question_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Question_Sub_Model(
        id: json["id"],
        patient_id: json["patient_id"],
        title: json["title"],
        content: json["content"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        comments_count: json["comments_count"],
        views_count: json["views_count"],
        likes_count: json["likes_count"],
        is_like: json["is_like"],
        is_favorite: json["is_favorite"],
        medias: json["medias"],
        owner:json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        answers: json["answers"] == null ? null : List<Answer>.from(json["answers"]
                .map((x) => Answer.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        categories: json["categories"] == null ? null : List<Category>.from(json["categories"]
                .map((x) => Category.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>)
            );
  }
  @override
  List<Object?> get props => [
        id,
        patient_id,
        title,
        created_at,
        updated_at,
        comments_count,
        views_count,
        content,
        likes_count,
        is_like,
        is_favorite,
        medias,
        categories
      ];
}


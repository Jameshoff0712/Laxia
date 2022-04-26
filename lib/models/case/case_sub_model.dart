import 'package:equatable/equatable.dart';
import 'package:laxia/models/case/Owner_model.dart';
import 'package:laxia/models/home/category_model.dart';

class Case_Sub_Model extends Equatable {
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
  final List<String>? answers;
  final Owner? owner;
  final List<String>? medias;
  final List<Category>? categories;

  const Case_Sub_Model(
      {required this.id,
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
      this.answers,
      this.owner,
      this.medias,
      this.categories});

  factory Case_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Case_Sub_Model(
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
        answers:json["answer"],
        owner:Owner.fromJson(json["owner"]),
        medias:json["meidas"],
        categories: List<Category>.from(json["question_id"]
                .map((x) => Category.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>));
  }
  @override
  List<Object?> get props => [
        id,
        patient_id,
        title,
        content,
        created_at,
        updated_at,
        comments_count,
        views_count,
        created_at,
        updated_at,
        likes_count,
        is_favorite,
        answers,
        owner,
        medias,
        categories
      ];
}

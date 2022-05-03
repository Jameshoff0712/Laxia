import 'package:equatable/equatable.dart';
import 'package:laxia/models/home/category_model.dart';

class Home_Sub_Model extends Equatable {
  final int id;
  final int? patient_id;
  final String? nickname;
  final String? photo;
  final String? clinic;
  final int? clinic_id;
  final String? first_content;
  final String? last_content;
  final String? first_thumb_path;
  final String? last_thumb_path;
  final int? comments_count;
  final int? views_count;
  final String? updated_at;
  final String? type;
  final List<Category>? categories;

  const Home_Sub_Model({ required this.id,  this.patient_id,  this.nickname,  this.photo,  this.clinic,  this.clinic_id, this.first_content,  this.last_content,  this.first_thumb_path, this.last_thumb_path,  this.comments_count,  this.views_count,  this.updated_at, this.type,  this.categories});

  factory Home_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Home_Sub_Model(
        id: json["id"],
        patient_id: json["patient_id"],
        nickname: json["nickname"],
        photo: json["photo"],
        clinic: json["clinic"],
        clinic_id: json["clinic_id"],
        first_content: json["first_content"],
        last_content: json["last_content"],
        first_thumb_path:json["first_thumb_path"],
        last_thumb_path: json["last_thumb_path"],
        comments_count: json["comments_count"],
        views_count: json["views_count"],
        updated_at: json["updated_at"],
        type: json["type"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>)
        );
  }
  @override
  List<Object?> get props => [
         id,
        patient_id,
        nickname, 
        photo, 
        clinic,
        clinic_id, 
        first_content, 
        last_content, 
        first_thumb_path,
        last_thumb_path, 
        comments_count,
        views_count, 
        updated_at, 
        type, 
        categories,
      ];
}

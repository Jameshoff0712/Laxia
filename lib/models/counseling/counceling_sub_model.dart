import 'package:equatable/equatable.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/models/menu/image_model.dart';

class Counceling_Sub_Model extends Equatable {
  final int id;
  final int? patient_id;
  final int? clinic_id;
  final int? doctor_id;
  final String? counseling_date;
  final String? content;
  final String? before_counseling;
  final String? after_ccounseling;
  final int? rate;
  final String? created_at;
  final String? updated_at;
  final int? comments_count;
  final int? views_count;
  final int? likes_count;
  final bool? is_like;
  final String? clinic_name;
  final String? patient_nickname;
  final String? patient_photo;
  final String? doctor_name;
  final bool? is_favorite;
  final List? medias;
  final String? reason;
  final String title;
  final List<Category>? categories;
  final List<Image_model> media_self;
  final List<Image_model> media_like;
  final List<Image_model> media_dislike;

  const Counceling_Sub_Model(
      {required this.id,
      this.patient_id,
      this.reason,
      this.clinic_id,
      required this.media_self,
      required this.media_like,
      required this.media_dislike,
      required this.title,
      this.doctor_id,
      this.counseling_date,
      this.content,
      this.before_counseling,
      this.after_ccounseling,
      this.rate,
      this.created_at,
      this.updated_at,
      this.comments_count,
      this.views_count,
      this.likes_count,
      this.is_like,
      this.clinic_name,
      this.patient_nickname,
      this.patient_photo,
      this.doctor_name,
      this.is_favorite,
      this.medias,
      this.categories});

  factory Counceling_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Counceling_Sub_Model(
        id: json["id"],
        patient_id: json["patient_id"],
        title: json["title"],
        clinic_id: json["clinic_id"],
        doctor_id: json["doctor_id"],
        media_self:List<Image_model>.from(json["media_self"]
                .map((x) => Image_model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        media_like:List<Image_model>.from(json["media_like"]
                .map((x) => Image_model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        media_dislike:List<Image_model>.from(json["media_dislike"]
                .map((x) => Image_model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        counseling_date: json["counseling_date"],
        content: json["content"],
        before_counseling: json["before_counseling"],
        after_ccounseling: json["after_ccounseling"],
        rate: json["rate"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        comments_count: json["comments_count"],
        views_count: json["views_count"],
        likes_count: json["likes_count"],
        is_like: json["is_like"],
        clinic_name: json["clinic_name"],
        patient_nickname: json["patient_nickname"],
        patient_photo: json["patient_photo"],
        doctor_name: json["doctor_name"],
        is_favorite: json["is_favorite"],
        medias: json["medias"],
        reason: json["reason"],
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]
                .map((x) => Category.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>));
  }
  @override
  List<Object?> get props => [
        id,
        patient_id,
        clinic_id,
        doctor_id,
        counseling_date,
        content,
        before_counseling,
        after_ccounseling,
        rate,
        created_at,
        updated_at,
        comments_count,
        views_count,
        content,
        before_counseling,
        likes_count,
        is_like,
        clinic_name,
        patient_nickname,
        patient_nickname,
        patient_photo,
        clinic_name,
        doctor_name,
        is_favorite,
        medias,
        categories
      ];
}

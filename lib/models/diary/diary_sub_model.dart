import 'package:equatable/equatable.dart';
import 'package:laxia/models/home/category_model.dart';

class Diary_Sub_Model extends Equatable {
  final int id;
  final int? patient_id;
  final int? clinic_id;
  final String? treat_date;
  final int? doctor_id;
  final int? price;
  final String? created_at;
  final String? updated_at;
  final int? rate_01;
  final int? rate_02;
  final int? rate_03;
  final int? rate_04;
  final int? rate_05;
  final int? rate_06;
  final int? rate_07;
  final int? rate_08;
  final int? rate_09;
  final int? ave_rate;
  final int? cost_anesthetic;
  final int? cost_drug;
  final int? cost_other;
  final int? comments_count;
  final int? views_count;
  final int? likes_count;
  final bool? is_like;
  final String? before_image;
  final String? after_image;
  final String? patient_nickname;
  final String? patient_gender;
  final String? patient_photo;
  final int? patient_age;
  final String? clinic_name;
  final String? doctor_name;
  final String? last_content;
  final bool? is_favorite;
  final List<Category>? categories;

  const Diary_Sub_Model(
      {required this.id,
      this.patient_id,
      this.clinic_id,
      this.treat_date,
      this.doctor_id,
      this.price,
      this.created_at,
      this.updated_at,
      this.rate_01,
      this.rate_02,
      this.rate_03,
      this.rate_04,
      this.rate_05,
      this.rate_06,
      this.rate_07,
      this.rate_08,
      this.rate_09,
      this.ave_rate,
      this.cost_anesthetic,
      this.cost_drug,
      this.cost_other,
      this.comments_count,
      this.views_count,
      this.likes_count,
      this.is_like,
      this.before_image,
      this.after_image,
      this.patient_nickname,
      this.patient_gender,
      this.patient_photo,
      this.patient_age,
      this.clinic_name,
      this.doctor_name,
      this.last_content,
      this.is_favorite,
      this.categories});

  factory Diary_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Diary_Sub_Model(
        id: json["id"],
        patient_id: json["patient_id"],
        clinic_id: json["clinic_id"],
        treat_date: json["treat_date"],
        doctor_id: json["doctor_id"],
        price: json["price"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        rate_01: json["rate_01"],
        rate_02: json["rate_02"],
        rate_03: json["rate_03"],
        rate_04: json["rate_04"],
        rate_05: json["rate_05"],
        rate_06: json["rate_06"],
        rate_07: json["rate_07"],
        rate_08: json["rate_08"],
        rate_09: json["rate_09"],
        ave_rate: json["ave_rate"],
        cost_anesthetic: json["cost_anesthetic"],
        cost_drug: json["cost_drug"],
        cost_other: json["cost_other"],
        comments_count: json["comments_count"],
        views_count: json["views_count"],
        likes_count: json["likes_count"],
        is_like: json["is_like"],
        before_image: json["before_image"],
        after_image: json["after_image"],
        patient_nickname: json["patient_nickname"],
        patient_gender: json["patient_gender"],
        patient_photo: json["patient_photo"],
        patient_age: json["patient_age"],
        clinic_name: json["clinic_name"],
        doctor_name: json["doctor_name"],
        last_content:json["last_content"],
        is_favorite: json["is_favorite"],
        categories:json["categories"]==null?null: List<Category>.from(json["categories"]
                .map((x) => Category.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>));
  }
  @override
  List<Object?> get props => [
        id,
        patient_id,
        clinic_id,
        treat_date,
        doctor_id,
        price,
        created_at,
        updated_at,
        rate_01,
        rate_02,
        rate_03,
        rate_04,
        rate_05,
        rate_06,
        rate_07,
        rate_08,
        rate_09,
        ave_rate,
        cost_anesthetic,
        cost_drug,
        cost_other,
        comments_count,
        views_count,
        created_at,
        updated_at,
        likes_count,
        is_like,
        before_image,
        after_image,
        patient_nickname,
        patient_gender,
        patient_photo,
        patient_age,
        clinic_name,
        doctor_name,
        last_content,
        is_favorite,
        categories
      ];
}

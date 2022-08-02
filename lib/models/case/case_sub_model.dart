import 'package:equatable/equatable.dart';
import 'package:laxia/models/case/menu_sub_model.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/models/menu/image_model.dart';

class Case_Sub_Model extends Equatable {
  final int id;
  final int? clinic_id;
  final int? doctor_id;
  final int? patient_age;
  final String? name;
  final String? patient_gender;
  final String? case_description;
  final String? treat_risk;
  final String? doctor_option;
  final String? created_at;
  final String? updated_at;
  final int? comments_count;
  final int? views_count;
  final int? likes_count;
  final bool? is_like;
  final Clinic_Sub_Model? clinic;
  final List<Category>? categories;
  final List<Menu_Sub_Model>? menus;
  final Doctor_Sub_Model? doctor;
  final List<Image_model>? beforeimage;
  final List<Image_model>? afterimage;
  final List<Diary_Sub_Model>? diaries;

  const Case_Sub_Model(
      {required this.id,
      this.beforeimage, 
      this.afterimage, 
      this.clinic_id,
      this.name,
      this.diaries,
      this.patient_age,
      this.doctor_id,
      this.patient_gender,
      this.case_description,
      this.treat_risk,
      this.doctor_option,
      this.created_at,
      this.updated_at,
      this.comments_count,
      this.views_count,
      this.likes_count,
      this.is_like,
      this.clinic,
      this.categories,
      this.menus,
      this.doctor});

  factory Case_Sub_Model.fromJson(Map<String, dynamic> json) {
    print('case'+json.toString());
    return Case_Sub_Model(
        id: json["id"],
        clinic_id: json["clinic_id"],
        name: json["name"],
        patient_age: json["patient_age"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        comments_count: json["comments_count"],
        views_count: json["views_count"],
        likes_count: json["likes_count"],
        is_like: json["is_like"],
        doctor_id: json["doctor_id"],
        patient_gender: json["patient_gender"],
        case_description: json["case_description"],
        treat_risk: json["treat_risk"],
        doctor_option: json["doctor_option"],
        clinic:json["clinic"]==null?null:Clinic_Sub_Model.fromJson(json["clinic"]),
        categories:json["categories"]==null?[]: List<Category>.from(json["categories"]
                .map((x) => Category.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        menus: json["menus"]==null?[]:List<Menu_Sub_Model>.from(json["menus"]
                .map((x) => Menu_Sub_Model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        beforeimage:json["beforeimage"]==null?[] :List<Image_model>.from(json["beforeimage"]
                .map((x) => Image_model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        afterimage:json["afterimage"]==null?[] :List<Image_model>.from(json["afterimage"]
                .map((x) => Image_model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        diaries:json["diaries"]==null?[] :List<Diary_Sub_Model>.from(json["diaries"]
                .map((x) => Diary_Sub_Model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        doctor:json["doctor"]==null?null: Doctor_Sub_Model.fromJson(json["doctor"]),
        );
  }
  @override
  List<Object?> get props => [
        id,
        clinic_id,
        name,
        patient_age,
        created_at,
        updated_at,
        comments_count,
        views_count,
        created_at,
        updated_at,
        likes_count,
        clinic,
        categories,
        menus,
        doctor,
        doctor_id,
        patient_gender,
        case_description,
        treat_risk,
        doctor_option,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';


class Me extends Equatable {
  int id;
  int userId;
  String? name;
  String? kana;
  String? gender;
  String? phoneNumber;
  String? birthday;
  dynamic createdAt;
  dynamic updatedAt;
  String? uniqueId;
  String? nickname;
  String? intro;
  String? photo;
  int? point;
  int? areaId;
  String? firebaseKey;
  int? age;
  String? area;
  int? followsCount;
  int? followersCount;
  bool? isFollow;
  String? phoneOnlyNumber;
  List<Diary_Sub_Model>? diaries;
  List<Counceling_Sub_Model>? counselings;
  List<Diary_Sub_Model>? favorite_diaries;
  List<Question_Sub_Model>? favorite_questions;
  List<Doctor_Sub_Model>? favorite_doctors;
  List<Counceling_Sub_Model>? favorite_counseling_reports;
  List<Menu_Sub_Model>? favorite_menus;
  List<Clinic_Sub_Model>? favorite_clinics;

  Me({
    required this.id,
    required this.userId,
    this.name,
    this.kana,
    this.gender,
    this.phoneNumber,
    this.birthday,
    this.createdAt,
    this.updatedAt,
    this.uniqueId,
    this.nickname,
    this.intro,
    this.photo,
    this.point,
    this.areaId,
    this.firebaseKey,
    this.age,
    this.area,
    this.followsCount,
    this.followersCount,
    this.isFollow,
    this.phoneOnlyNumber,
    this.diaries,
    this.counselings,
    this.favorite_diaries,
    this.favorite_questions,
    this.favorite_doctors,
    this.favorite_counseling_reports,
    this.favorite_menus,
    this.favorite_clinics,
  });

  factory Me.fromJson(Map<String, dynamic> json) {
    return Me(
      id: json["id"],
      userId: json["user_id"],
      name: json["name"],
      kana: json["kana"],
      gender: json["gender"],
      phoneNumber: json["phone_number"],
      birthday: json["birthday"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      uniqueId: json["unique_id"],
      nickname: json["nickname"],
      intro: json["intro"],
      photo: json["photo"],
      point: json["point"],
      areaId: json["area_id"],
      firebaseKey: json["firebase_key"],
      age: json["age"],
      area: json["area"],
      followsCount: json["follows_count"],
      followersCount: json["followers_count"],
      isFollow: json["is_follow"],
      phoneOnlyNumber: json["phone_only_number"],
      diaries: List<Diary_Sub_Model>.from(
          json["diaries"].map((x) => Diary_Sub_Model.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
      counselings: List<Counceling_Sub_Model>.from(json["counselings"]
              .map((x) => Counceling_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      favorite_diaries: List<Diary_Sub_Model>.from(json["favorite_diaries"]
              .map((x) => Diary_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      favorite_questions: List<Question_Sub_Model>.from(json["favorite_questions"]
              .map((x) => Question_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      favorite_doctors: List<Doctor_Sub_Model>.from(json["favorite_doctors"]
              .map((x) => Doctor_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      favorite_counseling_reports: List<Counceling_Sub_Model>.from(
          json["favorite_counseling_reports"]
                  .map((x) => Counceling_Sub_Model.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
      favorite_menus: List<Menu_Sub_Model>.from(json["favorite_menus"]
              .map((x) => Menu_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      favorite_clinics: List<Clinic_Sub_Model>.from(json["favorite_clinics"]
              .map((x) => Clinic_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [
        id,
        name,
        kana,
        gender,
        phoneNumber,
        birthday,
        createdAt,
        updatedAt,
        uniqueId,
        nickname,
        intro,
        photo,
        point,
        areaId,
        firebaseKey,
        age,
        area,
        followsCount,
        followersCount,
        isFollow,
        phoneOnlyNumber,
        diaries,
        counselings,
        favorite_diaries,
        favorite_questions,
        favorite_doctors,
        favorite_counseling_reports,
        favorite_menus,
        favorite_clinics,
      ];
}

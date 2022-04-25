import 'package:equatable/equatable.dart';
import 'package:laxia/models/clinic_api_model.dart';
import 'package:laxia/models/counseling_api_model.dart';
import 'package:laxia/models/diary_api_model.dart';
import 'package:laxia/models/doctor_api_model.dart';
import 'package:laxia/models/menu_api_model.dart';

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
  List<Diary>? diaries;
  List<Counseling>? counselings;
  List<Diary>? favorite_diaries;
  // //  List<Question>? favorite_questions;
  List<Doctor>? favorite_doctors;
  List<Counseling>? favorite_counseling_reports;
  List<Menu>? favorite_menus;
  List<Clinic>? favorite_clinics;

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
    // this.favorite_questions,
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
      diaries: List<Diary>.from(
          json["diaries"].map((x) => Diary.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
      counselings: List<Counseling>.from(json["counselings"]
              .map((x) => Counseling.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      favorite_diaries: List<Diary>.from(json["favorite_diaries"]
              .map((x) => Diary.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      // // favorite_questions: json["favorite_questions"],
      favorite_doctors: List<Doctor>.from(json["favorite_doctors"]
              .map((x) => Doctor.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      favorite_counseling_reports: List<Counseling>.from(
          json["favorite_counseling_reports"]
                  .map((x) => Counseling.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
      favorite_menus: List<Menu>.from(json["favorite_menus"]
              .map((x) => Menu.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      favorite_clinics: List<Clinic>.from(json["favorite_clinics"]
              .map((x) => Clinic.fromJson(x as Map<String, dynamic>))
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
        // favorite_questions,
        favorite_doctors,
        favorite_counseling_reports,
        favorite_menus,
        favorite_clinics,
      ];
}

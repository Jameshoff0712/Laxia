import 'package:equatable/equatable.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';

class Home_Search_Model extends Equatable {
  final List<Menu_Sub_Model> menus;
  final List<Clinic_Sub_Model> clinics;
  final List<Doctor_Sub_Model> doctors;
  final List<Diary_Sub_Model> diaries;
  final List<Case_Sub_Model> cases;

  const Home_Search_Model(
      {required this.menus,
      required this.clinics,
      required this.doctors,
      required this.diaries,
      required this.cases});

  factory Home_Search_Model.fromJson(Map<String, dynamic> json) {
    return Home_Search_Model(
      menus: List<Menu_Sub_Model>.from(json["menus"]["data"].map((x) => Menu_Sub_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>) ,
      clinics: List<Clinic_Sub_Model>.from(json["clinics"]["data"].map((x) => Clinic_Sub_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>) ,
      doctors: List<Doctor_Sub_Model>.from(json["doctors"]["data"].map((x) => Doctor_Sub_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>) ,
      diaries:json["diaries"]==null?[]: List<Diary_Sub_Model>.from(json["diaries"]["data"].map((x) => Diary_Sub_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>) ,
      cases:json["cases"]==null?[]: List<Case_Sub_Model>.from(json["cases"]["data"].map((x) => Case_Sub_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>) ,
    );
  }
  @override
  List<Object?> get props => [
    menus,
    clinics,
    doctors,
    diaries,
    cases
  ];
}

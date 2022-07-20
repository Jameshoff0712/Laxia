import 'package:equatable/equatable.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';

class MidSearch_Model extends Equatable {
  final List<int> cases;
  final List<int> menus;
  final List<int> clinics;
  final List<int> doctors;
  final List<int> diaries;

  const MidSearch_Model(
      {required this.cases,
      required this.menus,
      required this.clinics,
      required this.doctors,
      required this.diaries});

  factory MidSearch_Model.fromJson(Map<String, dynamic> json) {
    return MidSearch_Model(
      cases: List<int>.from(json["cases"]), 
      menus: List<int>.from(json["menus"]),
      clinics: List<int>.from(json["clinics"]),
      doctors: List<int>.from(json["doctors"]),
      diaries: List<int>.from(json["diaries"])
    );
  }
  @override
  List<Object?> get props => [];
}

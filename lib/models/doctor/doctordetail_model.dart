import 'package:equatable/equatable.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';

class DoctorDetail_Model extends Equatable {
  final Doctor_Sub_Model doctor;
  final Clinic_Sub_Model clinic;
  final List<Counceling_Sub_Model> counselings;
  final List<Case_Sub_Model> cases;
  final List<Diary_Sub_Model> diaries;
  final List<Question_Sub_Model> questions;
  const DoctorDetail_Model( {
    required this.questions,
    required this.diaries,
    required this.doctor,
    required this.clinic,
    required this.counselings,
    required this.cases,
  });

  factory DoctorDetail_Model.fromJson(Map<String, dynamic> json) {
    return DoctorDetail_Model(
      questions: [],
      diaries: [],
      doctor: Doctor_Sub_Model.fromJson(json),
      counselings: List<Counceling_Sub_Model>.from(json["counselings"].map(
              (x) => Counceling_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      cases: List<Case_Sub_Model>.from(json["cases"]
              .map((x) => Case_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      clinic: Clinic_Sub_Model.fromJson(json["clinic"]),
    );
  }
  @override
  List<Object?> get props => [
        doctor,
        clinic,
        counselings,
        cases,
    ];
}

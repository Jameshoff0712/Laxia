import 'package:equatable/equatable.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/menu/menu_Sub_Model.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/menu/image_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';

class ClinicDetail_Model extends Equatable {
  final List<Image_model> images;
  final Clinic_Sub_Model clinic;
  final List<Counceling_Sub_Model> counselings;
  final List<Doctor_Sub_Model> doctors;
  final List<Menu_Sub_Model> menu;
  final List<Diary_Sub_Model> diaries;
  final List<Question_Sub_Model> questions;
    final List<Case_Sub_Model> cases;
  const ClinicDetail_Model( {
    required this.cases,
    required this.doctors,  
    required this.questions,
    required this.diaries,
    required this.images,
    required this.clinic,
    required this.counselings,
    required this.menu,
  });

  factory ClinicDetail_Model.fromJson(Map<String, dynamic> json) {
    return ClinicDetail_Model(
      cases: [],
      questions: [],
      diaries: [],
      images: List<Image_model>.from(json["images"].map(
              (x) => Image_model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      counselings: List<Counceling_Sub_Model>.from(json["counselings"].map(
              (x) => Counceling_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      menu:json["menus"]==null?[]: List<Menu_Sub_Model>.from(json["menus"]
              .map((x) => Menu_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      clinic: Clinic_Sub_Model.fromJson(json), 
      doctors: List<Doctor_Sub_Model>.from(json["doctors"]
              .map((x) => Doctor_Sub_Model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [
        images,
        clinic,
        counselings,
        menu,
    ];
}

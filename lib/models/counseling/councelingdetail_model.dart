import 'package:equatable/equatable.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/counseling/miniquestion_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';

class CouncelingDetail_Model extends Equatable {
  final Counceling_Sub_Model counceling;
  final Clinic_Sub_Model clinic;
  final Doctor_Sub_Model doctor;
  final List<Mini_Qmodel> questions;
  const CouncelingDetail_Model( {
    required this.questions,
    required this.counceling,
    required this.clinic,
    required this.doctor,
  });

  factory CouncelingDetail_Model.fromJson(Map<String, dynamic> json) {
    return CouncelingDetail_Model(
      counceling: Counceling_Sub_Model.fromJson(json),
      doctor: Doctor_Sub_Model.fromJson(json["doctor"]),
      questions: List<Mini_Qmodel>.from(json["questions"]
              .map((x) => Mini_Qmodel.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
      clinic: Clinic_Sub_Model.fromJson(json["clinic"]),
    );
  }
  @override
  List<Object?> get props => [
        counceling,
        clinic,
        doctor,
        questions,
    ];
}

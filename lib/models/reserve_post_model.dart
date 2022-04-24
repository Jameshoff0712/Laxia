import 'package:equatable/equatable.dart';

class ReservePost extends Equatable {
  final int clinic_id;
  final int? opertion_type;
  final int doctor_id;
  final String question_content;
  final int decision_type_today;
  final List<dynamic> list_visitDates;
  final String firstName;
  final String secondName;
  final String birthday;
  final int gender_id;
  final String mobileNumber;
  final int usedPoint;

  ReservePost({
    required this.clinic_id,
    this.opertion_type,
    required this.doctor_id,
    required this.question_content,
    required this.decision_type_today,
    required this.list_visitDates,
    required this.firstName,
    required this.secondName,
    required this.birthday,
    required this.gender_id,
    required this.mobileNumber,
    required this.usedPoint
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    clinic_id,
    opertion_type,
    doctor_id,
    question_content,
    decision_type_today,
    list_visitDates,
    firstName,
    secondName,
    birthday,
    gender_id,
    mobileNumber,
    usedPoint
  ];

}
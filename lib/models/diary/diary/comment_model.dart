import 'package:equatable/equatable.dart';

class Comment_Model extends Equatable {
  final int id;
  final int patient_id;
  final int parent_id;
  final String comment;
  final String patient_nickname;
  final String patient_photo;

  const Comment_Model(
      {required this.patient_id,
      required this.parent_id,
      required this.comment,
      required this.patient_nickname,
      required this.patient_photo,
      required this.id});

  factory Comment_Model.fromJson(Map<String, dynamic> json) {
    return Comment_Model(
      id: json["id"],
      patient_id: json["patient_id"],
      parent_id: json["parent_id"],
      comment: json["comment"],
      patient_nickname: json["patient_nickname"],
      patient_photo: json["patient_photo"],
    );
  }
  @override
  List<Object?> get props => [];
}
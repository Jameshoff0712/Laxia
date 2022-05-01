import 'package:equatable/equatable.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';

class Answer extends Equatable {
  final int id;
  final int? doctor_id;
  final int? question_id;
  final String? answer;
  final String? created_at;
  final Doctor_Sub_Model? doctor;
  final List<Photo>? photos;

  const Answer(
      {required this.id,
      this.doctor_id,
      this.question_id,
      this.answer,
      this.created_at,
      this.doctor,
      this.photos});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json["id"],
      doctor_id: json["doctor_id"],
      question_id: json["question_id"],
      answer: json["answer"],
      created_at: json["created_at"],
      doctor:json["doctor"]==null?null: Doctor_Sub_Model.fromJson(json["doctor"]),
      photos: List<Photo>.from(json["photos"]
                .map((x) => Photo.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [id, doctor_id, question_id, answer,created_at,doctor,photos];
}

class Photo extends Equatable {
  final int id;
  final String? photo;
  const Photo({required this.id, this.photo});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json["id"],
        photo: json["photo"]);
  }
  @override
  List<Object?> get props => [
         id,
        photo
      ];
}

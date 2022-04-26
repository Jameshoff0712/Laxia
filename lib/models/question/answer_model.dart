import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final int id;
  final int? doctor_id;
  final int? question_id;
  final String? answer;
  final String? created_at;
  final String? doctor;
  final List<String>? photos;

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
      doctor: json["doctor"],
      photos: json["photos"],
    );
  }
  @override
  List<Object?> get props => [id, doctor_id, question_id, answer,created_at,doctor,photos];
}

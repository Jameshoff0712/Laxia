import 'package:equatable/equatable.dart';

class Mini_Qmodel extends Equatable {
  final int id;
  final int? counseling_report_id;
  final String? question;
  final String? answer;
  final String? created_at;
  final String? updatted_at;

  const Mini_Qmodel(
      {this.question,
      this.created_at,
      this.updatted_at,
      required this.id,
      required this.counseling_report_id,
      required this.answer});

  factory Mini_Qmodel.fromJson(Map<String, dynamic> json) {
    return Mini_Qmodel(
        question:json["question"],
        created_at:json["created_at"],
        updatted_at:json["updatted_at"],
        id:json["id"],
        counseling_report_id:json["counseling_report_id"],
        answer:json["answer"]
    );
  }
  @override
  List<Object?> get props => 
  [
    question,
    created_at,
    updatted_at,
    id,
    counseling_report_id,
    answer
  ];
}

import 'package:equatable/equatable.dart';
import 'package:laxia/models/counsel_question_model.dart';

class CounselPostModel extends Equatable {
  final String clinic_id;
  final String doctor_id;
  final String date;
  final String content;
  final String reason;
  final String before_counsel;
  final String after_counsel;
  final String rate;
  final List<int> categories;
  final List<CounselQuestion_Model> question;
  final List<List<int>> imageIds;


  CounselPostModel(
      {required this.categories,
      required this.clinic_id,
      required this.doctor_id,
      required this.date,
      required this.content,
      required this.reason,
      required this.before_counsel,
      required this.after_counsel,
      required this.rate,
      required this.question,
      required this.imageIds
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        categories,
        clinic_id,
        doctor_id,
        date,
        content,
        reason,
        before_counsel,
        after_counsel,
        rate,
        question,
        imageIds
      ];
}


import 'package:equatable/equatable.dart';

class DiaryPostModel extends Equatable {
  final String clinic_id;
  final String doctor_id;
  final String date;
  final List<int> categories;
  final List<List<int>> imageIds;
  final List<String> questions;
  final List<int> rates;
  final int cost_op;
  final int cost_anes;
  final int cost_drug;
  final int cost_other;


  DiaryPostModel(
      {
        required this.clinic_id,
        required this.doctor_id,
        required this.date,
        required this.categories,
        required this.imageIds,
        required this.questions,
        required this.rates,
        required this.cost_op,
        required this.cost_anes,
        required this.cost_drug,
        required this.cost_other
      }
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        clinic_id,
        doctor_id,
        date,
        categories,
        imageIds,
        questions,
        rates,
        cost_op,
        cost_anes,
        cost_drug,
        cost_other
      ];
}

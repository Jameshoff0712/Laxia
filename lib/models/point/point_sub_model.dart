import 'package:equatable/equatable.dart';
import 'package:laxia/models/point/point_model.dart';

class Point_Sub_Model extends Equatable {
  final int? id;
  final int? patient_id;
  final String? title;
  final int? use_point;
  final String? type;
  final int? type_id;
  final String? create_at;

  const Point_Sub_Model(
      {this.id,
      this.patient_id,
      this.title,
      this.use_point,
      this.type,
      this.type_id,
      this.create_at});
  factory Point_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Point_Sub_Model(
      id: json["id"],
      patient_id: json["patient_id"],
      title: json["title"],
      use_point: json["use_point"],
      type: json["type"],
      type_id: json["type_id"],
      create_at: json["created_at"],
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    patient_id,
    title,
    use_point,
    type,
    type_id,
    create_at
  ];
}

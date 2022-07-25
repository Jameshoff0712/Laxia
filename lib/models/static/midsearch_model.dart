import 'package:equatable/equatable.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';

class MidSearch_Model extends Equatable {
  final List<Sub> categories;
  final List<Sub> menus;
  final List<Sub> clinics;
  final List<Sub> doctors;

  const MidSearch_Model(
      {required this.categories,
      required this.menus,
      required this.clinics,
      required this.doctors});

  factory MidSearch_Model.fromJson(Map<String, dynamic> json) {
    return MidSearch_Model(
      categories: List<Sub>.from(json["categories"]
                .map((x) => Sub.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>), 
      menus:List<Sub>.from(json["menus"]
                .map((x) => Sub.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
      clinics: List<Sub>.from(json["clinics"]
                .map((x) => Sub.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
      doctors: List<Sub>.from(json["doctors"]
                .map((x) => Sub.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [];
}
class Sub extends Equatable {
  final int id;
  final int? part_id;
  final String name;

  const Sub(
      {required this.id,
      required this.name,
      this.part_id});

  factory Sub.fromJson(Map<String, dynamic> json) {
    return Sub(
      id: json["id"], 
      part_id: json["part_id"],
      name: json["name"],
    );
  }
  @override
  List<Object?> get props => [];
}

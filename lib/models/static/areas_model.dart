import 'package:equatable/equatable.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';

class Area_Model extends Equatable {
  final int id;
  final int? visible;
  final String? name;
  final String? sort_no;
  final String? created_at;
  final String? updated_at;
  final List<City>? all_Citys;

  const Area_Model(
      {required this.id,
      this.sort_no,
      this.created_at,
      this.updated_at,
      this.visible,
      this.name,
      this.all_Citys});

  factory Area_Model.fromJson(Map<String, dynamic> json) {
    return Area_Model(
      id: json["id"],
      visible: json["visible"],
      name: json["name"],
      sort_no: json["sort_no"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      all_Citys: List<City>.from(
          json["cities"].map((x) => City.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [id, visible, name, all_Citys];
}

class City extends Equatable {
  final int id;
  final int? pref_id;
  final String? name;
  final String? created_at;
  final String? updated_at;

  const City({required this.id, this.pref_id, this.name,this.created_at, this.updated_at});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      pref_id: json["pref_id"],
      name: json["name"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }
  @override
  List<Object?> get props => [id, pref_id, name];
}

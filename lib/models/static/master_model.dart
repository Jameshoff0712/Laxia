import 'package:equatable/equatable.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';

class Master_Model extends Equatable {
  final int id;
  final int? parent_id;
  final String? name;
  final List<Children>? all_childrens;

  const Master_Model(
      {required this.id,
      this.parent_id,
      this.name,
      this.all_childrens});

  factory Master_Model.fromJson(Map<String, dynamic> json) {
    return Master_Model(
      id: json["id"],
      parent_id: json["parent_id"],
      name: json["name"],
      all_childrens: List<Children>.from(json["all_children"]
                .map((x) => Children.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [id, parent_id, name,all_childrens];
}

class Children extends Equatable {
  final int id;
  final int? parent_id;
  final String? name;
  final List<Children>? all_childrens;

  const Children(
      {required this.id,
      this.parent_id,
      this.name,
      this.all_childrens});

  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      id: json["id"],
      parent_id: json["parent_id"],
      name: json["name"],
      all_childrens: List<Children>.from(json["all_children"]
                .map((x) => Children.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [id, parent_id, name,all_childrens];
}
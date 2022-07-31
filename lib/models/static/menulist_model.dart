import 'package:equatable/equatable.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';

class Menulist_Model extends Equatable {
  final int id;
  final String name;
  final List<Menu_Sub_Model> menus;

  const Menulist_Model(
      {required this.id,
      required this.name,
      required this.menus});

  factory Menulist_Model.fromJson(Map<String, dynamic> json) {
    return Menulist_Model(
      id: json["id"],
      name: json["name"],
      menus: List<Menu_Sub_Model>.from(json["menus"]
                .map((x) => Menu_Sub_Model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
    );
  }
  @override
  List<Object?> get props => [];
}
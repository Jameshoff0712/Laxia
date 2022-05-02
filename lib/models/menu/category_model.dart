import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final int parent_id;
  final String name;
  final Pivot pivot;

  const Category({required this.id, required this.parent_id, required this.name, required this.pivot});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json["id"],
        parent_id: json["parent_id"],
        name: json["name"],
        pivot: Pivot.fromJson(json["pivot"])
        );
  }
  @override
  List<Object?> get props => [
         id,
         parent_id,
         name,
         pivot
      ];
}
class Pivot extends Equatable {
  final int menu_id;
  final int category_id;
  const Pivot({required this.menu_id, required this.category_id});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
        menu_id: json["menu_id"],
        category_id: json["category_id"]);
  }
  @override
  List<Object?> get props => [
         menu_id,
        category_id
      ];
}

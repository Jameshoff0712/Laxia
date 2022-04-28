import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final int? parent_id;
  final String name;
  final Pivot pivot;

  const Category({required this.id,  this.parent_id, required this.name, required this.pivot});

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
  final int question_id;
  final int Category_id;
  const Pivot({required this.question_id, required this.Category_id});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
        question_id: json["question_id"],
        Category_id: json["Category_id"]);
  }
  @override
  List<Object?> get props => [
         question_id,
        Category_id
      ];
}

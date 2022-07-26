import 'package:equatable/equatable.dart';

class Status_Model extends Equatable {
  final int id;
  final String name;
  final Pivot pivot;

  const Status_Model(
      {required this.name,
      required this.pivot,
      required this.id});

  factory Status_Model.fromJson(Map<String, dynamic> json) {
    return Status_Model(
      id: json["id"],
      name: json["name"],
      pivot: Pivot.fromJson(json["pivot"]),
    );
  }
  @override
  List<Object?> get props => [];
}

class Pivot extends Equatable {
  final int value;
  const Pivot({required this.value, });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
        value: json["value"]
        );
  }
  @override
  List<Object?> get props => [];
}

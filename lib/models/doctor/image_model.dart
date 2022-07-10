import 'package:equatable/equatable.dart';

class Image_model extends Equatable {
  final int id;
  final String path;

  const Image_model(
      {required this.id,
      required this.path});

  factory Image_model.fromJson(Map<String, dynamic> json) {
    return Image_model(
        id:json["id"],
        path:json["photo"]
    );
  }
  @override
  List<Object?> get props => 
  [
    id,
    path
  ];
}
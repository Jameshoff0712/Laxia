import 'package:equatable/equatable.dart';

class Image_model extends Equatable {
  final int id;
  final String attachable_type;
  final int? attachable_id;
  final String path;
  final int? img_type;
  final String? created_at;
  final String? updatted_at;

  const Image_model(
      {this.attachable_id,
      this.img_type,
      this.created_at,
      this.updatted_at,
      required this.id,
      required this.attachable_type,
      required this.path});

  factory Image_model.fromJson(Map<String, dynamic> json) {
    return Image_model(
        attachable_id:json["attachable_id"],
        img_type:json["img_type"],
        created_at:json["created_at"],
        updatted_at:json["updatted_at"],
        id:json["id"],
        attachable_type:json["attachable_type"],
        path:json["path"]
    );
  }
  @override
  List<Object?> get props => 
  [
    attachable_id,
    img_type,
    created_at,
    updatted_at,
    id,
    attachable_type,
    path
  ];
}
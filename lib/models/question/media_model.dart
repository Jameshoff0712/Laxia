import 'package:equatable/equatable.dart';

class Media_model extends Equatable {
  final int id;
  final String? mediable_type;
  final int? mediable_id;
  final String path;
  final int? type;
  final String? created_at;
  final String? updatted_at;
  final List? category;
  final int? user_id;
  final String? thumb_path;

  const Media_model(
      {this.category,
      this.user_id,
      this.thumb_path,
      this.mediable_id,
      this.type,
      this.created_at,
      this.updatted_at,
      required this.id,
      required this.mediable_type,
      required this.path});

  factory Media_model.fromJson(Map<String, dynamic> json) {
    return Media_model(
        category: json['category'] == null ? [] : json['category'],
        user_id: json['user_id'],
        thumb_path: json['thumb_path'],
        mediable_id: json["mediable_id"],
        type: json["type"],
        created_at: json["created_at"],
        updatted_at: json["updatted_at"],
        id: json["id"],
        mediable_type: json["mediable_type"],
        path: json["path"]);
  }
  @override
  List<Object?> get props => [
        category,
        user_id,
        thumb_path,
        mediable_id,
        type,
        created_at,
        updatted_at,
        id,
        mediable_type,
        path
      ];
}

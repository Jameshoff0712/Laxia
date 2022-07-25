import 'package:equatable/equatable.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';

class Message_Model extends Equatable {
  final int id;
  final int mailbox_id;
  final int user_id;
  final String message;
  final int is_file;
  final String created_at;
  final String updated_at;
  final bool is_mine;
  final String file_thumb_url;
  final String display_time_lable;
  final Sender? sender;

  const Message_Model({
    required this.id,
    required this.mailbox_id,
    required this.user_id,
    required this.message,
    required this.is_file,
    required this.created_at,
    required this.updated_at,
    required this.is_mine,
    required this.file_thumb_url,
    required this.display_time_lable,
    this.sender,
  });

  factory Message_Model.fromJson(Map<String, dynamic> json) {
    return Message_Model(
      id:json['id'],
      mailbox_id:json['mailbox_id'],
      user_id:json['user_id'],
      message:json['message'],
      is_file:json['is_file'],
      created_at:json['created_at'],
      updated_at:json['updated_at'],
      is_mine:json['is_mine'],
      file_thumb_url:json['file_thumb_url'],
      display_time_lable:json['display_time_lable'],
      sender:json['sender']==null?null:Sender.fromJson(json['sender']),
    );
  }
  @override
  List<Object?> get props => [];
}

class Sender extends Equatable {
  final int id;
  final String name;
  final String? photo;

  const Sender({
    required this.id,
    required this.name,
    this.photo,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      name: json['name'],
      photo: json['clinic']==null?null: json['clinic']['photo'],
    );
  }
  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int current_page;
  final List<Comment_Sub_Model> data;
  final String first_page_url;
  final int from;
  final int last_page;
  final String last_page_url;
  final String? next_page_url;
  final String path;
  final int per_page;
  final String? prev_page_url;
  final int to;
  final int total;

  const Comment(
      {required this.current_page,
      required this.data,
      required this.first_page_url,
      required this.from,
      required this.last_page,
      required this.last_page_url,
      required this.next_page_url,
      required this.path,
      required this.per_page,
      required this.prev_page_url,
      required this.to,
      required this.total});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        current_page: json["current_page"],
        data: List<Comment_Sub_Model>.from(json["data"].map(
                (x) => Comment_Sub_Model.fromJson(x as Map<String, dynamic>))
            as Iterable<dynamic>),
        first_page_url: json["first_page_url"],
        from: json["from"],
        last_page: json["last_page"],
        last_page_url: json["last_page_url"],
        next_page_url: json["next_page_url"],
        path: json["path"],
        per_page: int.parse(json["per_page"].toString()),
        prev_page_url: json["prev_page_url"],
        to: json["to"],
        total: json["total"]);
  }
  @override
  List<Object?> get props => [
        current_page,
        data,
        first_page_url,
        from,
        last_page,
        last_page_url,
        next_page_url,
        path,
        per_page,
        prev_page_url,
        to,
        total
      ];
}

class Comment_Sub_Model extends Equatable {
  final int id;
  final int? parent_id;
  final int? patient_id;
  final String? comment;
  final String? created_at;
  final String? updated_at;
  final String? patient_nickname;
  final String? patient_photo;
  final List? all_children;

  const Comment_Sub_Model(
      {this.patient_id,
      this.comment,
      this.patient_nickname,
      this.patient_photo,
      this.all_children,
      required this.id,
      this.parent_id,
      this.created_at,
      this.updated_at});

  factory Comment_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Comment_Sub_Model(
      id: json["id"],
      parent_id: json["parent_id"],
      patient_id: json["patient_id"],
      patient_nickname: json["patient_nickname"],
      comment:json["comment"],
      created_at: json["created_at"],
      updated_at: json["updated_at"], 
      patient_photo: json["patient_photo"], 
    );
  }
  @override
  List<Object?> get props => [
      patient_id,
      comment,
      patient_nickname,
      patient_photo,
      all_children,
      id,
      parent_id,
      created_at,
      updated_at
  ];
}

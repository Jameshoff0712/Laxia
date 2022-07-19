import 'package:equatable/equatable.dart';

class Search_sub_Model extends Equatable {
  final String text;
  final int followcount;

  const Search_sub_Model({
      required this.text,
      required this.followcount,});

  factory Search_sub_Model.fromJson(Map<String, dynamic> json) {
    return Search_sub_Model(
        text: json["text"],
        followcount: json["followcount"],);
  }
  @override
  List<Object?> get props => [
        text,
        followcount
      ];
}

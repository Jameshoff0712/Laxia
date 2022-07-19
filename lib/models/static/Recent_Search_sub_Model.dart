import 'package:equatable/equatable.dart';

class Recent_Search_sub_Model extends Equatable {
  final String text;
  final int followcount;

  const Recent_Search_sub_Model({
      required this.text,
      required this.followcount,});

  factory Recent_Search_sub_Model.fromJson(Map<String, dynamic> json) {
    return Recent_Search_sub_Model(
        text: json['search']["text"],
        followcount: json['search']["followcount"],);
  }
  @override
  List<Object?> get props => [
        text,
        followcount
      ];
}

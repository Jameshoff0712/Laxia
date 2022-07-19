import 'package:equatable/equatable.dart';
import 'package:laxia/models/static/Recent_Search_sub_Model.dart';
import 'package:laxia/models/static/Search_sub_Model.dart';

class Search_Model extends Equatable {
  final List<Recent_Search_sub_Model> recent;
  final List<Search_sub_Model> global;

  const Search_Model({
      required this.recent,
      required this.global,});

  factory Search_Model.fromJson(Map<String, dynamic> json) {
    return Search_Model(
        recent:List<Recent_Search_sub_Model>.from(json["recentsearch"].map((x) => Recent_Search_sub_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>) ,
        global:List<Search_sub_Model>.from(json["globalsearch"].map((x) => Search_sub_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>) ,
        );
  }
  @override
  List<Object?> get props => [
          recent,
          global
      ];
}

import 'dart:html';

import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String unique_id;
  final String nick_name;
  final String intro;
  final dynamic photo;
  final String birthday;
  final String gender;
  final int area_id;
  final List<int> patient_categories;

  ProfileModel(
      {required this.birthday,
      required this.gender,
      required this.unique_id,
      required this.nick_name,
      required this.intro,
      required this.photo,
      required this.area_id,
      required this.patient_categories});

  list(){
      return {
        "birthday":this.birthday,
        'gender':this.gender,
        'unique_id':this.unique_id,
        'nick_name':this.nick_name,
        'intro':this.intro,
        'medias':this.photo,
        'area_id':this.area_id,
        'patient_categories':this.patient_categories
      };
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
        birthday,
        gender,
        unique_id,
        nick_name,
        intro,
        photo,
        area_id,
        patient_categories
      ];
}

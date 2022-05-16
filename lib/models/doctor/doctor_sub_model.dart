import 'package:equatable/equatable.dart';

class Doctor_Sub_Model extends Equatable {
  final int id;
  final int? user_id;
  final int clinic_id;
  final String kata_name;
  final String hira_name;
  final String? gender;
  final String? phone_number;
  final String? birthday;
  final String? area_id;
  final int? job_id;
  final int? experience_year;
  final int? spec0;
  final int? spec1;
  final int? spec2;
  final String? profile;
  final String? career;
  final String? photo;
  final String? firebase_key;
  final String? job_name;
  final String? spec0_name;
  final String? spec1_name;
  final String? spec2_name;
  final String? name;
  final String? email;
  final String? role;
  final int? likes_count;
  final bool? is_like;
  final int? favoriters_count;
  final bool? is_favorite;
  final int? views_count;

  const Doctor_Sub_Model({
    required this.id,
    this.user_id,
    required this.clinic_id,
    required this.kata_name,
    required this.hira_name,
    this.gender,
    this.phone_number,
    this.birthday,
    this.area_id,
    this.job_id,
    this.experience_year,
    this.spec0,
    this.spec1,
    this.spec2,
    this.profile,
    this.career,
    this.photo,
    this.firebase_key,
    this.job_name,
    this.spec0_name,
    this.spec1_name,
    this.spec2_name,
    this.name,
    this.email,
    this.role,
    this.likes_count,
    this.is_like,
    this.favoriters_count,
    this.is_favorite,
    this.views_count,
  });

  factory Doctor_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Doctor_Sub_Model(
        id: json["id"],
        user_id: json["user_id"],
        clinic_id: json["clinic_id"] == null ? 0 : json["clinic_id"],
        kata_name: json["kata_name"],
        hira_name: json["hira_name"] == null ? "" : json["hira_name"],
        gender: json["gender"],
        phone_number: json["phone_number"],
        birthday: json["birthday"],
        area_id: json["area_id"],
        job_id: json["job_id"],
        experience_year: json["experience_year"]==null?0:json["experience_year"],
        spec0: json["spec0"],
        spec1: json["spec1"],
        spec2: json["spec2"],
        profile: json["profile"],
        career: json["career"],
        photo: json["photo"] == null ? "" : json["photo"],
        firebase_key: json["firebase_key"],
        job_name: json["job_name"] == null ? "" : json["job_name"],
        spec0_name: json["spec0_name"],
        spec1_name: json["spec1_name"],
        spec2_name: json["spec2_name"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        likes_count: json["likes_count"],
        is_like: json["is_like"],
        favoriters_count: json["favoriters_count"],
        is_favorite: json["is_favorite"],
        views_count: json["views_count"]
        );
  }
  @override
  List<Object?> get props => [
        id,
        user_id,
        clinic_id,
        kata_name,
        hira_name,
        gender,
        phone_number,
        birthday,
        area_id,
        job_id,
        experience_year,
        spec0,
        spec1,
        spec2,
        profile,
        career,
        photo,
        firebase_key,
        job_name,
        spec0_name,
        spec1_name,
        spec2_name,
        name,
        email,
        role,
        likes_count,
        is_like,
        favoriters_count,
        is_favorite,
        views_count,
      ];
}

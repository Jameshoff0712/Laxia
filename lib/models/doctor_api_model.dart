class Doctor {
  int? id;
  int? user_id;
  int? clinic_id;
  String? kata_name;
  String? hira_name;
  String? gender;
  String? phone_number;
  String? birthday;
  int? area_id;
  int? job_id;
  int? experience_year;
  int? spec0;
  int? spec1;
  int? spec2;
  String? profile;
  String? career;
  String? photo;
  String? firebase_key;
  String? job_name;
  String? spec0_name;
  String? spec1_name;
  String? spec2_name;
  String? name;
  String? email;
  String? role;
  int? likes_count;
  bool? is_like;
  int? favorites_count;
  bool? is_favorite;
  int? views_count;

  Doctor( {
    this.id,
    this.user_id,
    this.clinic_id,
    this.kata_name,
    this.hira_name,
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
    this.favorites_count,
    this.is_favorite,
    this.views_count,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        id: json["id"] == null ? null : json["id"] as int,
        user_id: json["user_id"] == null ? null : json["user_id"] as int,
        clinic_id: json["clinic_id"] == null ? null : json["clinic_id"] as int,
        kata_name: json["kata_name"] == null ? null : json["kata_name"] as String,
        hira_name: json["hira_name"] == null ? null : json["hira_name"] as String,
        gender: json["gender"] == null ? null : json["gender"] as String,
        phone_number: json["phone_number"] == null ? null : json["phone_number"] as String,
        birthday: json["birthday"] == null ? null : json["birthday"] as String,
        area_id: json["area_id"] == null ? null : json["area_id"] as int,
        job_id: json["job_id"] == null ? null : json["job_id"] as int,
        experience_year: json["experience_year"] == null ? null : json["experience_year"] as int,
        spec0: json["spec0"] == null ? null : json["spec0"] as int,
        spec1: json["spec1"] == null ? null : json["spec1"] as int,
        spec2: json["spec2"] == null ? null : json["spec2"] as int,
        profile: json["profile"] == null ? null : json["profile"] as String,
        career: json["career"] == null ? null : json["career"] as String,
        photo: json["photo"] == null ? "" : json["photo"] as String,
        firebase_key: json["firebase_key"] == null ? null : json["firebase_key"] as String,
        job_name: json["job_name"] == null ? null : json["job_name"] as String,
        spec0_name: json["spec0_name"] == null ? null : json["spec0_name"] as String,
        spec1_name: json["spec1_name"] == null ? null : json["spec1_name"] as String,
        spec2_name: json["spec2_name"] == null ? null : json["spec2_name"] as String,
        name: json["name"] == null ? null : json["name"] as String,
        email: json["email"] == null ? null : json["email"] as String,
        role: json["role"] == null ? null : json["role"] as String,
        likes_count: json["likes_count"] == null ? null : json["likes_count"] as int,
        is_like: json["is_like"] == null ? null : json["is_like"] as bool,
        favorites_count: json["favorites_count"] == null ? null : json["favorites_count"] as int,
        is_favorite: json["is_favorite"] == null ? null : json["is_favorite"] as bool,
        views_count: json["views_count"] == null ? null : json["views_count"] as int,
    );
  }
}

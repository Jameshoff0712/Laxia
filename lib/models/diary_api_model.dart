class Diary {
  int? id;
  int? patient_id;
  int? clinic_id;
  String? treat_date;
  int? doctor_id;
  int? price;
  int? cost_anesthetic;
  int? cost_drug;
  int? cost_other;
  int? comments_count;
  int? views_count;
  int? likes_count;
  bool? is_like;
  String? before_image;
  String? after_image;
  String? patient_nickname;
  String? patient_gender;
  String? patient_photo;
  int? patient_age;
  String? clinic_name;
  String? doctor_name;
  String? last_content;
  bool? is_favorite;

  Diary({
    this.id,
    this.patient_id,
    this.clinic_id,
    this.treat_date,
    this.doctor_id,
    this.price,
    this.cost_anesthetic,
    this.cost_drug,
    this.cost_other,
    this.comments_count,
    this.views_count,
    this.likes_count,
    this.is_like,
    this.before_image,
    this.after_image,
    this.patient_nickname,
    this.patient_gender,
    this.patient_photo,
    this.patient_age,
    this.clinic_name,
    this.doctor_name,
    this.last_content,
    this.is_favorite,
  });
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json["id"] == null ? null : json["id"] as int,
      patient_id: json["patient_id"] == null ? null : json["patient_id"] as int,
      clinic_id: json["clinic_id"] == null ? null : json["clinic_id"] as int,
      treat_date: json["treat_date"] == null ? null : json["treat_date"] as String,
      doctor_id: json["doctor_id"] == null ? null : json["doctor_id"] as int,
      price: json["price"] == null ? null : json["price"] as int,
      cost_anesthetic: json["cost_anesthetic"] == null ? null : json["cost_anesthetic"] as int,
      cost_drug: json["cost_drug"] == null ? null : json["cost_drug"] as int,
      cost_other: json["cost_other"] == null ? null : json["cost_other"] as int,
      comments_count: json["comments_count"] == null ? null : json["comments_count"] as int,
      views_count: json["views_count"] == null ? null : json["views_count"] as int,
      likes_count: json["likes_count"] == null ? null : json["likes_count"] as int,
      is_like: json["is_like"] == null ? null : json["is_like"] as bool,
      before_image: json["before_image"] == null ? "" : json["before_image"] as String,
      after_image: json["after_image"] == null ? "" : json["after_image"] as String,
      patient_nickname: json["patient_nickname"] == null ? "" : json["patient_nickname"] as String,
      patient_gender: json["patient_gender"] == null ? "" : json["patient_gender"] as String,
      patient_photo: json["patient_photo"] == null ? "" : json["patient_photo"] as String,
      patient_age: json["patient_age"] == null ? null : json["patient_age"] as int,
      clinic_name: json["clinic_name"] == null ? "" : json["clinic_name"] as String,
      doctor_name: json["doctor_name"] == null ? "" : json["doctor_name"] as String,
      last_content: json["last_content"] == null ? "" : json["last_content"] as String,
      is_favorite: json["is_favorite"] == null ? null : json["is_favorite"] as bool,
    );
  }
}

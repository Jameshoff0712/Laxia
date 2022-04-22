class Counseling {
  int? id;
  int? patient_id;
  int? clinic_id;
  int? doctor_id;
  String? counseling_date;
  String? content;
  String? reason;
  String? before_counseling;
  String? after_counseling;
  int? rate;
  int? comments_count;
  int? views_count;
  int? likes_count;
  bool? is_like;
  String? clinic_name;
  String? patient_nickname;
  String? patient_photo;
  String? doctor_name;
  bool? is_favorite;

  Counseling({
    this.id,
    this.patient_id,
    this.clinic_id,
    this.doctor_id,
    this.counseling_date,
    this.content,
    this.reason,
    this.before_counseling,
    this.after_counseling,
    this.rate,
    this.comments_count,
    this.views_count,
    this.likes_count,
    this.is_like,
    this.clinic_name,
    this.patient_nickname,
    this.patient_photo,
    this.doctor_name,
    this.is_favorite,
  });
  factory Counseling.fromJson(Map<String, dynamic> json) {
    return Counseling(
      id: json["id"] == null ? null : json["id"] as int,
      patient_id: json["patient_id"] == null ? null : json["patient_id"] as int,
      clinic_id: json["clinic_id"] == null ? null : json["clinic_id"] as int,
      doctor_id: json["doctor_id"] == null ? null : json["doctor_id"] as int,
      counseling_date: json["counseling_date"] == null ? null : json["counseling_date"] as String,
      content: json["content"] == null ? null : json["content"] as String,
      reason: json["reason"] == null ? null : json["reason"] as String,
      before_counseling: json["before_counseling"] == null ? null : json["before_counseling"] as String,
      after_counseling: json["after_counseling"] == null ? null : json["after_counseling"] as String,
      rate: json["rate"] == null ? null : json["rate"] as int,
      comments_count: json["comments_count"] == null ? null : json["comments_count"] as int,
      views_count: json["views_count"] == null ? null : json["views_count"] as int,
      likes_count: json["likes_count"] == null ? null : json["likes_count"] as int,
      is_like: json["is_like"] == null ? null : json["is_like"] as bool,
      clinic_name: json["clinic_name"] == null ? "" : json["clinic_name"] as String,
      patient_nickname: json["patient_nickname"] == null ? "" : json["patient_nickname"] as String,
      patient_photo: json["patient_photo"] == null ? "" : json["patient_photo"] as String,
      doctor_name: json["doctor_name"] == null ? "" : json["doctor_name"] as String,
      is_favorite: json["is_favorite"] == null ? null : json["is_favorite"] as bool,
    );
  }
}

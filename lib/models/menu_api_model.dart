class Menu {
  int? id;
  int? clinic_id;
  String? name;
  int? price;
  String? description;
  String? risk;
  String? guarantee;
  int? treat_time;
  String? basshi;
  String? hospital_visit;
  int? hare;
  int? pain;
  int? bleeding;
  int? hospital_need;
  int? masui;
  int? makeup;
  int? shower;
  int? message;
  int? sport_impossible;
  String? photo;
  int? status;
  bool? is_favorite;

  Menu({
    this.id,
    this.clinic_id,
    this.name,
    this.price,
    this.description,
    this.risk,
    this.guarantee,
    this.treat_time,
    this.basshi,
    this.hospital_visit,
    this.hare,
    this.pain,
    this.bleeding,
    this.hospital_need,
    this.masui,
    this.makeup,
    this.shower,
    this.message,
    this.sport_impossible,
    this.photo,
    this.status,
    this.is_favorite,
  });

  factory Menu.fromJson(Map<String, dynamic> json){
    return Menu(
      id: json["id"] == null ? null : json["id"] as int,
      clinic_id: json["clinic_id"] == null ? null : json["clinic_id"] as int,
      name: json["name"] == null ? null : json["name"] as String,
      price: json["price"] == null ? null : json["price"] as int,
      description: json["description"] == null ? "" : json["description"] as String,
      risk: json["risk"] == null ? "" : json["risk"] as String,
      guarantee: json["guarantee"] == null ? null : json["guarantee"] as String,
      treat_time: json["treat_time"] == null ? null : json["treat_time"] as int,
      basshi: json["basshi"] == null ? null : json["basshi"] as String,
      hospital_visit: json["hospital_visit"] == null ? null : json["hospital_visit"] as String,
      hare: json["hare"] == null ? null : json["hare"] as int,
      pain: json["pain"] == null ? null : json["pain"] as int,
      bleeding: json["bleeding"] == null ? null : json["bleeding"] as int,
      hospital_need: json["hospital_need"] == null ? null : json["hospital_need"] as int,
      masui: json["masui"] == null ? null : json["masui"] as int,
      makeup: json["masui"] == null ? null : json["masui"] as int,
      shower: json["shower"] == null ? null : json["shower"] as int,
      message: json["message"] == null ? null : json["message"] as int,
      sport_impossible: json["sport_impossible"] == null ? null : json["sport_impossible"] as int,
      photo: json["photo"] == null ? "" : json["photo"] as String,
      status: json["status"] == null ? null : json["status"] as int,
      is_favorite: json["is_favorite"] == null ? null : json["is_favorite"] as bool,
    );
  }
}

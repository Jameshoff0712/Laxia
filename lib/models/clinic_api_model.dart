class Clinic {
  int? id;
  int? user_id;
  String? name;
  int? pref_id;
  int? city_id;
  int? town_id;
  String? addr02;
  String? nearest_station;
  String? site;
  String? access;
  String? phone_number;
  String? credit_card;
  String? parking;
  String? photo;
  String? firebase_key;
  int? diaries_count;
  int? counselings_count;
  int? menus_count;
  int? stuffs_count;
  int? favoriters_count;
  bool? is_favorite;
  String? address;
  String? addr01;
  String? user_name;
  String? email;
  String? role;

  Clinic({
    this.id,
    this.user_id,
    this.name,
    this.pref_id,
    this.city_id,
    this.town_id,
    this.addr02,
    this.nearest_station,
    this.site,
    this.access,
    this.phone_number,
    this.credit_card,
    this.parking,
    this.photo,
    this.firebase_key,
    this.diaries_count,
    this.counselings_count,
    this.menus_count,
    this.stuffs_count,
    this.favoriters_count,
    this.is_favorite,
    this.address,
    this.addr01,
    this.user_name,
    this.email,
    this.role,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
        id: json["id"] == null ? null : json["id"] as int,
        user_id: json["user_id"] == null ? null : json["user_id"] as int,
        name: json["name"] == null ? "" : json["name"] as String,
        pref_id: json["pref_id"] == null ? null : json["pref_id"] as int,
        city_id: json["city_id"] == null ? null : json["city_id"] as int,
        town_id: json["town_id"] == null ? null : json["town_id"] as int,
        addr02: json["addr02"] == null ? null : json["addr02"] as String,
        nearest_station: json["nearest_station"] == null ? null : json["nearest_station"] as String,
        site: json["site"] == null ? null : json["site"] as String,
        access: json["access"] == null ? null : json["access"] as String,
        phone_number: json["phone_number"] == null ? null : json["phone_number"] as String,
        credit_card: json["credit_card"] == null ? null : json["credit_card"] as String,
        parking: json["parking"] == null ? null : json["parking"] as String,
        photo: json["photo"] == null ? "" : json["photo"] as String,
        firebase_key: json["firebase_key"] == null ? null : json["firebase_key"] as String,
        diaries_count: json["diaries_count"] == null ? null : json["diaries_count"] as int,
        counselings_count: json["counselings_count"] == null ? null : json["counselings_count"] as int,
        menus_count: json["menus_count"] == null ? null : json["menus_count"] as int,
        stuffs_count: json["stuffs_count"] == null ? null : json["stuffs_count"] as int,
        favoriters_count: json["favoriters_count"] == null ? null : json["favoriters_count"] as int,
        is_favorite: json["is_favorite"] == null ? null : json["is_favorite"] as bool,
        address: json["address"] == null ? null : json["address"] as String,
        addr01: json["addr01"] == null ? null : json["addr01"] as String,
        user_name: json["user_name"] == null ? "" : json["user_name"] as String,
        email: json["email"] == null ? null : json["email"] as String,
        role: json["role"] == null ? null : json["role"] as String,
    );
  }
}

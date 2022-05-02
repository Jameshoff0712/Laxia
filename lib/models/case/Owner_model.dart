import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final int id;
  final int? user_id;
  final int name;
  final int kana;
  final String? gender;
  final String? phone_number;
  final String? birthday;
  final int? created_at;
  final int? updated_at;
  final int? unique_id;
  final String? nickname;
  final String? intro;
  final String? photo;
  final int? point;
  final int? area_id;
  final String? firebase_key;
  final int? age;
  final String? area;
  final int? follows_count;
  final int? followers_count;
  final bool? is_follow;
  final String? phone_only_number;

  const Owner(
      {required this.id,
      this.user_id,
      required this.name,
      required this.kana,
      this.gender,
      this.phone_number,
      this.birthday,
      this.created_at,
      this.updated_at,
      this.unique_id,
      this.nickname,
      this.intro,
      this.photo,
      this.point,
      this.area_id,
      this.firebase_key,
      this.age,
      this.area,
      this.follows_count,
      this.followers_count,
      this.is_follow,
      this.phone_only_number});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json["id"],
      user_id: json["user_id"],
      name: json["name"],
      kana: json["kana"],
      gender: json["gender"],
      phone_number: json["phone_number"],
      birthday: json["birthday"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      unique_id: json["unique_id"],
      nickname: json["nickname"],
      intro: json["intro"],
      photo: json["photo"],
      point: json["point"],
      area_id: json["area_id"],
      firebase_key: json["firebase_key"],
      age: json["age"],
      area: json["area"],
      follows_count: json["follows_count"],
      followers_count: json["followers_count"],
      is_follow: json["is_follow"],
      phone_only_number: json["phone_only_number"]
    );
  }
  @override
  List<Object?> get props => [
        id,
        user_id,
        name,
        kana,
        gender,
        phone_number,
        birthday,
        created_at,
        updated_at,
        unique_id,
        nickname,
        intro,
        photo,
        point,
        area_id,
        firebase_key,
        age,
        area,
        follows_count,
        followers_count,
        is_follow,
        phone_only_number
      ];
}

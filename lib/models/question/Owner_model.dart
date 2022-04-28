import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final int id;
  final int? user_id;
  final String? name;
  final String? kana;
  final String? gender;
  final String? phone_number;
  final String? birthday;
  final String? created_at;
  final String? updated_at;
  final String? unique_id;
  final String? nickname;
  final String? intro;
  final String? photo;
  final int? point;
  final int? area_id;
  final String? firebase_key;
  final int? age;
  final int? follows_count;
  final int? followers_counts;
  final bool? is_follow;
  final String? phone_only_number;

  const Owner(
      {required this.id,
      this.user_id,
      this.name,
      this.kana,
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
      this.follows_count,
      this.firebase_key,
      this.age,
      this.is_follow,
      this.followers_counts,
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
      follows_count: json["follows_count"],
      followers_counts: json["followers_counts"],
      phone_only_number: json["phone_only_number"],
      firebase_key: json["firebase_key"],
      age: json["age"],
      is_follow: json["is_follow"],
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
        follows_count,
        followers_counts,
        phone_only_number,
      ];
}

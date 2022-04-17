import 'package:equatable/equatable.dart';

class Me extends Equatable {
  final int id;
  final int userId;
  final String? name;
  final String? kana;
  final String? gender;
  final String? phoneNumber;
  final String? birthday;
  final dynamic createdAt;
  final dynamic updatedAt;
  final String? uniqueId;
  final String? nickname;
  final String? intro;
  final String? photo;
  final int? point;
  final int? areaId;
  final String? firebaseKey;
  final int? age;
  final String? area;
  final int? followsCount;
  final int? followersCount;
  final bool? isFollow;
  final String? phoneOnlyNumber;

  const Me(
      {required this.id,
      required this.userId,
      this.name,
      this.kana,
      this.gender,
      this.phoneNumber,
      this.birthday,
      this.createdAt,
      this.updatedAt,
      this.uniqueId,
      this.nickname,
      this.intro,
      this.photo,
      this.point,
      this.areaId,
      this.firebaseKey,
      this.age,
      this.area,
      this.followsCount,
      this.followersCount,
      this.isFollow,
      this.phoneOnlyNumber});

  factory Me.fromJson(Map<String, dynamic> json) {
    return Me(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        kana: json["kana"],
        gender: json["gender"],
        phoneNumber: json["phone_number"],
        birthday: json["birthday"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        uniqueId: json["unique_id"],
        nickname: json["nickname"],
        intro: json["intro"],
        photo: json["photo"],
        point: json["point"],
        areaId: json["area_id"],
        firebaseKey: json["firebase_key"],
        age: json["age"],
        area: json["area"],
        followsCount: json["follows_count"],
        followersCount: json["followers_count"],
        isFollow: json["is_follow"],
        phoneOnlyNumber: json["phone_only_number"]);
  }
  @override
  List<Object?> get props => [
        id,
        name,
        kana,
        gender,
        phoneNumber,
        birthday,
        createdAt,
        updatedAt,
        uniqueId,
        nickname,
        intro,
        photo,
        point,
        areaId,
        firebaseKey,
        age,
        area,
        followsCount,
        followersCount,
        isFollow,
        phoneOnlyNumber,
      ];
}

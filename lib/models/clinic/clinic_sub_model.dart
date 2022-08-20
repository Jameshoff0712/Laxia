
import 'package:equatable/equatable.dart';
import 'package:laxia/models/clinic/worktime_model.dart';

import '../doctor/doctor_sub_model.dart';

class Clinic_Sub_Model extends Equatable {
  final int id;
  final int? user_id;
  final String? name;
  final int? pref_id;
  final int? city_id;
  final int? town_id;
  final String? addr02;
  final String? nearest_station;
  final String? site;
  final String? access;
  final String? phone_number;
  final String? credit_card;
  final String? parking;
  final String? photo;
  final String? created_at;
  final String? updated_at;
  final String? firebase_key;
  final double? avg_rate;
  final int? diaries_count;
  final int? counselings_count;
  final int? menus_count;
  final int? stuffs_count;
  final int? favoriters_count;
  final bool? is_favorite;
  final String? address;
  final String? addr01;
  final String? user_name;
  final String? email;
  final String? role;
  final List<Work_Time>? work_times;
  // final List<Doctor_Sub_Model>? doctors;

  const Clinic_Sub_Model(
      { required this.id,
       this.user_id,
       required this.name,
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
       this.created_at,
       this.updated_at,
       this.firebase_key,
       this.avg_rate,
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
       this.work_times,
      //  this.doctors
       });

  factory Clinic_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Clinic_Sub_Model(
          id:json["id"],
          user_id:json["user_id"],
          name:json["name"] == null ? '' : json["name"],
          pref_id:json["pref_id"],
          city_id:json["city_id"],
          town_id:json["town_id"],
          addr02:json["addr02"],
          nearest_station:json["nearest_station"],
          site:json["site"],
          access:json["access"],
          phone_number:json["phone_number"],
          credit_card:json["credit_card"],
          parking:json["parking"],
          photo:json["photo"],
          created_at:json["created_at"],
          updated_at:json["updated_at"],
          firebase_key:json["firebase_key"],
          avg_rate:json["ave_rate"]==null?0.0: (json["ave_rate"] as num).toDouble(),
          diaries_count:json["diaries_count"],
          counselings_count:json["counselings_count"],
          menus_count:json["menus_count"],
          stuffs_count:json["stuffs_count"],
          favoriters_count:json["favoriters_count"],
          is_favorite:json["is_favorite"],
          address:json["address"],
          addr01:json["addr01"],
          user_name:json["user_name"],
          email:json["email"],
          role:json["role"],
          work_times:List<Work_Time>.from(json["work_times"].map((x) => Work_Time.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>),
          // doctors: List<Doctor_Sub_Model>.from(json["data"].map((x) => Doctor_Sub_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>) ,
        );
  }
  @override
  List<Object?> get props => [
      id,
      user_id,
      name,
      pref_id,
      city_id,
      town_id,
      addr02,
      nearest_station,
      site,
      access,
      phone_number,
      credit_card,
      parking,
      photo,
      created_at,
      updated_at,
      firebase_key,
      avg_rate,
      diaries_count,
      counselings_count,
      menus_count,
      stuffs_count,
      favoriters_count,
      is_favorite,
      address,
      addr01,
      user_name,
      email,
      role,
      work_times,
      // doctors
      ];
}

import 'package:equatable/equatable.dart';

class Menu_Sub_Model extends Equatable {
  final int id;
  final int? clinic_id;
  final String name;
  final int? price;
  final String? description;
  final String? risk;
  final String? guarantee;
  final int? treat_time;
  final int? basshi;
  final String? hospital_visit;
  final int? hare;
  final String? pain;
  final String? bleeding;
  final String? hospital_need;
  final String? masui;
  final String? makeup;
  final String? shower;
  final String? massage;
  final String? sport_impossible;
  final String? photo;
  final int? status;
  final String? created_at;
  final String? updated_at;
  final bool? is_favorite;
  final Pivot? pivot;

  const Menu_Sub_Model(
      { required this.id,
       this.clinic_id,
       required this.name,
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
       this.massage,
       this.sport_impossible,
       this.photo,
       this.status,
       this.created_at,
       this.updated_at,
       this.is_favorite,
       this.pivot});

  factory Menu_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Menu_Sub_Model(
          id:json["id"],
          clinic_id:json["clinic_id"],
          name:json["name"],
          price:json["price"]==null?0:json["price"],
          description:json["description"],
          risk:json["risk"],
          guarantee:json["guarantee"],
          treat_time:json["treat_time"],
          basshi:json["basshi"],
          hospital_visit:json["hospital_visit"],
          hare:json["hare"],
          pain:json["pain"],
          bleeding:json["bleeding"],
          hospital_need:json["hospital_need"],
          masui:json["masui"],
          makeup:json["makeup"],
          shower:json["shower"],
          massage:json["massage"],
          sport_impossible:json["sport_impossible"],
          photo:json["photo"],
          status:json["status"],
          created_at:json["created_at"],
          updated_at:json["updated_at"],
          is_favorite:json["is_favorite"],
          pivot:Pivot.fromJson(json["pivot"])
        );
  }
  @override
  List<Object?> get props => [
      id,
      clinic_id,
      name,
      price,
      description,
      risk,
      guarantee,
      treat_time,
      basshi,
      hospital_visit,
      hare,
      pain,
      bleeding,
      hospital_need,
      masui,
      makeup,
      shower,
      massage,
      sport_impossible,
      photo,
      status,
      created_at,
      updated_at,
      is_favorite,
      pivot
      ];
}
class Pivot extends Equatable {
  final int case_id;
  final int menu_id;
  const Pivot({required this.case_id, required this.menu_id});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
        case_id: json["case_id"],
        menu_id: json["menu_id"]);
  }
  @override
  List<Object?> get props => [
         case_id,
        menu_id
      ];
}
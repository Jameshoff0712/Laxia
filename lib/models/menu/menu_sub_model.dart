import 'package:equatable/equatable.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/menu/category_model.dart';
import 'package:laxia/models/menu/image_model.dart';

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
  final int? hospital_visit;
  final int? hare;
  final int? pain;
  final int? bleeding;
  final int? hospital_need;
  final int? masui;
  final int? makeup;
  final int? shower;
  final int? massage;
  final int? sport_impossible;
  final String? photo;
  final int? status;
  final String? created_at;
  final String? updated_at;
  final bool? is_favorite;
  final List<Category>? categories;
  final Clinic_Sub_Model? clinic;
  final List<Image_model>? images;

  const Menu_Sub_Model(
      {required this.id,
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
      this.categories,
      this.clinic,
      this.images});

  factory Menu_Sub_Model.fromJson(Map<String, dynamic> json) {
    return Menu_Sub_Model(
      id: json["id"],
      clinic_id: json["clinic_id"],
      name: json["name"],
      price: json["price"] == null ? 0 : json["price"],
      description: json["description"],
      risk: json["risk"],
      guarantee: json["guarantee"],
      treat_time: json["treat_time"],
      basshi: json["basshi"],
      hospital_visit: json["hospital_visit"],
      hare: json["hare"],
      pain: json["pain"],
      bleeding: json["bleeding"],
      hospital_need: json["hospital_need"],
      masui: json["masui"],
      makeup: json["makeup"],
      shower: json["shower"],
      massage: json["massage"],
      sport_impossible: json["sport_impossible"],
      photo: json["photo"] == null ? "" : json["photo"],
      status: json["status"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      is_favorite: json["is_favorite"],
      categories: json["categories"] == null
          ? null
          : List<Category>.from(json["categories"]
                  .map((x) => Category.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>),
      clinic: json["clinic"] == null
          ? null
          : Clinic_Sub_Model.fromJson(json["clinic"]),
      images:json["images"]==null?[]: List<Image_model>.from(json["images"]
              .map((x) => Image_model.fromJson(x as Map<String, dynamic>))
          as Iterable<dynamic>),
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
        categories,
        clinic,
        images
      ];
}

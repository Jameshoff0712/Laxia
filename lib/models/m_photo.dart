import 'dart:convert';

Offer offerFromJson(String str) => Offer.fromJSON(json.decode(str) as Map<String, dynamic>);

String offerToJson(Offer data) => json.encode(data.toJson());

class Offer {
  Offer({
    this.id,
    this.name,
    this.provider,
    this.providerUrl,
    this.imageUrl,
    this.description,
    this.category,
    this.currency,
    this.originalPrice,
    this.offerPrice,
    this.offerEndDay,
    this.viewsCount,
    this.ratings,
    this.cityId,
    this.clinicAddress,
  });

  int? id;
  String? name;
  String? provider;
  String? providerUrl;
  String? imageUrl;
  String? description;
  String? category;
  String? currency;
  int? originalPrice;
  int? offerPrice;
  DateTime? offerEndDay;
  int? viewsCount;
  double? ratings;
  String? cityId;
  String? clinicAddress;

  factory Offer.fromJSON(Map<String, dynamic> json) => Offer(
        id: json["id"] == null ? null : json["id"] as int,
        name: json["name"] == null ? null : json["name"] as String,
        provider: json["provider"] == null ? null : json["provider"] as String,
        providerUrl: json["provider_url"] == null ? null : json["provider_url"] as String,
        imageUrl: json["image_url"] == null ? null : json["image_url"] as String,
        description: json["description"] == null ? null : json["description"] as String,
        category: json["category"] == null ? null : json["category"] as String,
        currency: json["currency"] == null ? null : json["currency"] as String,
        originalPrice: json["original_price"] == null ? null : json["original_price"] as int,
        offerPrice: json["offer_price"] == null ? null : json["offer_price"] as int,
        offerEndDay: json["offer_end_day"] == null ? null : DateTime.parse(json["offer_end_day"] as String),
        viewsCount: json["views_count"] == null ? null : json["views_count"] as int,
        ratings: json["ratings"] == null ? null : json["ratings"] as double,
        cityId: json["city_id"] == null ? null : json["city_id"] as String,
        clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "provider": provider == null ? null : provider,
        "provider_url": providerUrl == null ? null : providerUrl,
        "image_url": imageUrl == null ? null : imageUrl,
        "description": description == null ? null : description,
        "category": category == null ? null : category,
        "currency": currency == null ? null : currency,
        "original_price": originalPrice == null ? null : originalPrice,
        "offer_price": offerPrice == null ? null : offerPrice,
        "offer_end_day": offerEndDay == null ? null : offerEndDay!.toIso8601String(),
        "views_count": viewsCount == null ? null : viewsCount,
        "ratings": ratings == null ? null : ratings,
        "city_id": cityId == null ? null : cityId,
        "clinic_address": clinicAddress == null ? null : clinicAddress,
      };
}

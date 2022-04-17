import 'package:laxia/models/categories.dart';
import 'package:laxia/models/m_clinic.dart';
import 'package:laxia/models/m_doctor.dart';
import 'package:laxia/models/m_user.dart';
import 'package:laxia/models/parts.dart';

class Diary {
  final int id;
  final int patientId;
  final int clinicId;
  final String treatDate;
  final int doctorId;
  final int price;
  final dynamic createdAt;
  final dynamic updatedAt;
  final int rate01;
  const Diary(this.id, this.patientId, this.clinicId, this.treatDate,
      this.doctorId, this.price, this.createdAt, this.updatedAt, this.rate01);
}

class DiaryProgress {
  int? id;
  User? user;
  List<Surgeries>? tags;
  Doctor? doctor;
  Clinic? clinic;
  Parts? part;
  int? elapsedDay;
  List<String>? postImages;
  Map<String, dynamic>? evaluations;
  String? abstract;
}

List diary_list = [
  {
    "avator":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
    "image1":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-6.jpg",
    "image2":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
    "sentence": "2日目、起床直後の様子です。腫れは昨日とくくら...",
    "type": "二重切開",
    "clinic": "ラシア美容クリニック　DEF院",
    "name": "君島 剛",
    "check": "田中圭 医師",
    "price": "2万8000円",
    "eyes": "11",
    "hearts": "88",
    "chats": "4",
    "status": "未公開",
  },
  {
    "avator":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-2.jpg",
    "image1":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-6.jpg",
    "image2":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
    "sentence": "2日目、起床直後の様子です。腫れは昨日とくくら...",
    "type": "二重切開",
    "clinic": "ラシア美容クリニック　DEF院",
    "name": "君島 剛",
    "check": "田中圭 医師",
    "price": "2万8000円",
    "eyes": "11",
    "hearts": "88",
    "chats": "4",
    "status": "公開済",
  },
  {
    "avator":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
    "image1":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-6.jpg",
    "image2":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
    "sentence": "2日目、起床直後の様子です。腫れは昨日とくくら...",
    "type": "二重切開",
    "clinic": "ラシア美容クリニック　DEF院",
    "name": "君島 剛",
    "check": "田中圭 医師",
    "price": "2万8000円",
    "eyes": "11",
    "hearts": "88",
    "chats": "4",
    "status": "未公開",
  },
  {
    "avator":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
    "image1":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-6.jpg",
    "image2":
        "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
    "sentence": "2日目、起床直後の様子です。腫れは昨日とくくら...",
    "type": "二重切開",
    "clinic": "ラシア美容クリニック　DEF院",
    "name": "君島 剛",
    "check": "田中圭 医師",
    "price": "2万8000円",
    "eyes": "11",
    "hearts": "88",
    "chats": "4",
    "status": "公開済",
  }
];

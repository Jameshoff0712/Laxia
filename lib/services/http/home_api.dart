import 'package:laxia/models/case/case_model.dart';
import 'package:laxia/models/clinic/clinic_model.dart';
import 'package:laxia/models/counseling/counceling_model.dart';
import 'package:laxia/models/diary/diary_model.dart';
import 'package:laxia/models/doctor/doctor_model.dart';
import 'package:laxia/models/home/home_model.dart';
import 'package:laxia/models/menu/menu_model.dart';
import 'package:laxia/models/question/question_model.dart';
import 'package:laxia/models/token_model.dart';
import 'package:laxia/services/http/api.dart';

class HomeApi extends Api {
  HomeApi();

  Future<Home> homeData(String id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/tops?category_id="+id, token);
    return Home.fromJson(res.data["contents"]);
  }
  Future<Clinic> getclinicData(String per_page, String page, String q, String favorite, String pref_id, String city_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/clinics?per_page="+per_page+"&page="+page+"&q="+q+"&favorite="+favorite+"&pref_id="+pref_id +"&city_id="+city_id, token);
    return Clinic.fromJson(res.data["clinics"]);
  }
  Future<Menu> getMenuData(String per_page, String page, String category_id, String clinic_id, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/menus?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&clinic_id="+clinic_id+"&q="+q, token);
    return Menu.fromJson(res.data["menus"]);
  }
  Future<Diary> getDiaryData(String per_page, String page, String category_id, String patient_id, String favorote, String orderby, String menu_id, String price_min, String price_max, String rate, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/diaries?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&patient_id="+patient_id+"&favorote="+favorote+"&orderby="+orderby+"&menu_id="+menu_id+"&price_min="+price_min+"&price_max="+price_max+"&rate="+rate, token);
      //  print(res.data["data"]["diaries"]);
    return Diary.fromJson(res.data["data"]["diaries"]);
  }
  Future<Doctor> getDoctorData(String per_page, String page, String favorite, String clinic_id, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/doctors?per_page="+per_page+"&page="+page+"&favorite="+favorite+"&clinic_id="+clinic_id+"&q="+q, token);
    return Doctor.fromJson(res.data["doctors"]);
  }
  Future<Case> getCaseData(String per_page, String page, String clinic_id, String doctor_id, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/cases?per_page="+per_page+"&page="+page+"&clinic_id="+clinic_id+"&doctor_id="+doctor_id+"&q="+q, token);
    // print(res.data["cases"]);
    return Case.fromJson(res.data["cases"]);
  }
   Future<Counceling> getCouncelingData(String per_page, String page, String category_id, String patient_id, String favorote, String pref_id, String city, String orderby) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/counselings?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&patient_id="+patient_id+"&favorote="+favorote+"&pref_id="+pref_id+"&city="+city+"&orderby="+orderby, token);
    // print(res.data["data"]["counselings"]);
    return Counceling.fromJson(res.data["data"]["counselings"]);
  }
  Future<Question> getQuestionData(String per_page, String page, String category_id, String patient_id, String favorote, String pref_id, String city, String orderby) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/questions?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&patient_id="+patient_id+"&pref_id="+pref_id+"&city="+city+"&orderby="+orderby, token);
    //  print(res.data["data"]["questions"]);
    return Question.fromJson(res.data["data"]["questions"]);
  }
}

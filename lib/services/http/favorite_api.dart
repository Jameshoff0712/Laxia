import 'package:laxia/models/clinic_api_model.dart';
import 'package:laxia/models/counseling_api_model.dart';
import 'package:laxia/models/diary_api_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/models/doctor_api_model.dart';
import 'package:laxia/models/menu_api_model.dart';
import 'package:laxia/services/http/api.dart';

class FavoriteApi extends Api {
  FavoriteApi();

  Future<List<Menu>> getFavMenu() async {
    final List<Menu> listsFavMenu = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/menus?per_page=10&page=1&category_id=&clinic_id=&favorite=true&q=メニュー", token);
    for(int i=0; i < res.data["menus"]["data"].length; i++)
      listsFavMenu.add(Menu.fromJson(res.data["menus"]["data"][i]));
    return listsFavMenu;
  }
  Future<List<Clinic>> getFavClinic() async {
    final List<Clinic> listsFavClinic = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/clinics?per_page=10&page=1&q=&favorite=&city_id=&pref_id=", token);
    for(int i=0; i < res.data["clinics"]["data"].length; i++)
      listsFavClinic.add(Clinic.fromJson(res.data["clinics"]["data"][i]));
    return listsFavClinic;
  }
  Future<List<Doctor>> getFavDoctor() async {
    final List<Doctor> listsFavDoctor = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/doctors?per_page=100&page=1&clinic_id=1&favorite=true&q=", token);
    for(int i=0; i < res.data["doctors"]["data"].length; i++)
      listsFavDoctor.add(Doctor.fromJson(res.data["doctors"]["data"][i]));
    return listsFavDoctor;
  }
  Future<List<Diary>> getFavDiary() async {
    final List<Diary> listsFavDiary = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/diaries?per_page=10&page=1&category_id=&patient_id=&favorite=&orderby=comments_count&menu_id=&price_min=&price_max=306001&rate=3", token);
    for(int i=0; i < res.data["data"]["diaries"]["data"].length; i++)
      listsFavDiary.add(Diary.fromJson(res.data["data"]["diaries"]["data"][i]));
    return listsFavDiary;
  }
  Future<List<Counseling>> getFavCounseling() async {
    final List<Counseling> listsFavCounseling = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/counselings?per_page=10&page=1&category_id=&patient_id=&favorite=&pref_id=&city&orderby=comments_count", token);
    for(int i=0; i < res.data["data"]["counselings"]["data"].length; i++)
      listsFavCounseling.add(Counseling.fromJson(res.data["data"]["counselings"]["data"][i]));
    return listsFavCounseling;
  }
}

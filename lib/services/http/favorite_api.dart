import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';
import 'package:laxia/services/http/api.dart';

class FavoriteApi extends Api {
  FavoriteApi();

  Future<List<Menu_Sub_Model>> getFavMenu() async {
    final List<Menu_Sub_Model> listsFavMenu = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/menus?per_page=10&page=1&category_id=&clinic_id=&favorite=true&q=メニュー", token);
    for(int i=0; i < res.data["menus"]["data"].length; i++)
      listsFavMenu.add(Menu_Sub_Model.fromJson(res.data["menus"]["data"][i]));
    return listsFavMenu;
  }
  Future<List<Clinic_Sub_Model>> getFavClinic() async {
    final List<Clinic_Sub_Model> listsFavClinic = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/clinics?per_page=10&page=1&q=&favorite=&city_id=&pref_id=", token);
    for(int i=0; i < res.data["clinics"]["data"].length; i++)
      listsFavClinic.add(Clinic_Sub_Model.fromJson(res.data["clinics"]["data"][i]));
    return listsFavClinic;
  }
  Future<List<Doctor_Sub_Model>> getFavDoctor() async {
    final List<Doctor_Sub_Model> listsFavDoctor = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/doctors?per_page=100&page=1&clinic_id=1&favorite=true&q=", token);
    for(int i=0; i < res.data["doctors"]["data"].length; i++)
      listsFavDoctor.add(Doctor_Sub_Model.fromJson(res.data["doctors"]["data"][i]));
    return listsFavDoctor;
  }
  Future<List<Diary_Sub_Model>> getFavDiary() async {
    final List<Diary_Sub_Model> listsFavDiary = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/diaries?per_page=10&page=1&category_id=&patient_id=&favorite=&orderby=comments_count&menu_id=&price_min=&price_max=306001&rate=3", token);
    for(int i=0; i < res.data["data"]["diaries"]["data"].length; i++)
      listsFavDiary.add(Diary_Sub_Model.fromJson(res.data["data"]["diaries"]["data"][i]));
    return listsFavDiary;
  }
  Future<List<Counceling_Sub_Model>> getFavCounseling() async {
    final List<Counceling_Sub_Model> listsFavCounseling = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/counselings?per_page=10&page=1&category_id=&patient_id=&favorite=&pref_id=&city&orderby=comments_count", token);
    for(int i=0; i < res.data["data"]["counselings"]["data"].length; i++)
      listsFavCounseling.add(Counceling_Sub_Model.fromJson(res.data["data"]["counselings"]["data"][i]));
    return listsFavCounseling;
  }
}

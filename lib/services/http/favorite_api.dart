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
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_menus"].length; i++)
      listsFavMenu.add(Menu.fromJson(res.data["favorite_menus"][i]));
    return listsFavMenu;
  }
  Future<List<Clinic>> getFavClinic() async {
    final List<Clinic> listsFavClinic = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_clinics"].length; i++)
      listsFavClinic.add(Clinic.fromJson(res.data["favorite_clinics"][i]));
    return listsFavClinic;
  }
  Future<List<Doctor>> getFavDoctor() async {
    final List<Doctor> listsFavDoctor = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_doctors"].length; i++)
      listsFavDoctor.add(Doctor.fromJson(res.data["favorite_doctors"][i]));
    return listsFavDoctor;
  }
  Future<List<Diary>> getFavDiary() async {
    final List<Diary> listsFavDiary = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_diaries"].length; i++)
      listsFavDiary.add(Diary.fromJson(res.data["favorite_diaries"][i]));
    return listsFavDiary;
  }
  Future<List<Counseling>> getFavCounseling() async {
    final List<Counseling> listsFavCounseling = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_counseling_reports"].length; i++)
      listsFavCounseling.add(Counseling.fromJson(res.data["favorite_counseling_reports"][i]));
    return listsFavCounseling;
  }
}

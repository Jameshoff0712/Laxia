import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/services/http/api.dart';

class FavoriteApi extends Api {
  FavoriteApi();

  Future<List<Menu_Sub_Model>> getFavMenu() async {
    final List<Menu_Sub_Model> listsFavMenu = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_menus"].length; i++)
      listsFavMenu.add(Menu_Sub_Model.fromJson(res.data["favorite_menus"][i]));
    return listsFavMenu;
  }
  Future<List<Clinic_Sub_Model>> getFavClinic() async {
    final List<Clinic_Sub_Model> listsFavClinic = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_clinics"].length; i++)
      listsFavClinic.add(Clinic_Sub_Model.fromJson(res.data["favorite_clinics"][i]));
    return listsFavClinic;
  }
  Future<List<Doctor_Sub_Model>> getFavDoctor() async {
    final List<Doctor_Sub_Model> listsFavDoctor = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_doctors"].length; i++)
      listsFavDoctor.add(Doctor_Sub_Model.fromJson(res.data["favorite_doctors"][i]));
    return listsFavDoctor;
  }
  Future<List<Diary_Sub_Model>> getFavDiary() async {
    final List<Diary_Sub_Model> listsFavDiary = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_diaries"].length; i++)
      listsFavDiary.add(Diary_Sub_Model.fromJson(res.data["favorite_diaries"][i]));
    return listsFavDiary;
  }
  // Future<List<Case_Sub_Model>> getFavCase() async {
  //   final List<Case_Sub_Model> listsFavDiary = [];
  //   String? token = await preferenceUtil.getToken();
  //   final res = await Api.get(
  //       "$apiUrl/me", token);
  //   for(int i=0; i < res.data["favorite_diaries"].length; i++)
  //     listsFavDiary.add(Case_Sub_Model.fromJson(res.data["favorite_diaries"][i]));
  //   return listsFavDiary;
  // }
  Future<List<Counceling_Sub_Model>> getFavCounseling() async {
    final List<Counceling_Sub_Model> listsFavCounseling = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_counseling_reports"].length; i++)
      listsFavCounseling.add(Counceling_Sub_Model.fromJson(res.data["favorite_counseling_reports"][i]));
    return listsFavCounseling;
  }
  Future<List<Question_Sub_Model>> getFavQuestion() async {
    final List<Question_Sub_Model> listsFavQuestion = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/me", token);
    for(int i=0; i < res.data["favorite_questions"].length; i++)
      listsFavQuestion.add(Question_Sub_Model.fromJson(res.data["favorite_questions"][i]));
    return listsFavQuestion;
  }
}

import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/case/case_model.dart';
import 'package:laxia/models/clinic/clinic_model.dart';
import 'package:laxia/models/counseling/counceling_model.dart';
import 'package:laxia/models/diary/diary_model.dart';
import 'package:laxia/models/doctor/doctor_model.dart';
import 'package:laxia/models/home/home_model.dart';
import 'package:laxia/models/menu/menu_model.dart';
import 'package:laxia/models/question/question_model.dart';
import 'package:laxia/services/http/home_api.dart';

class HomeController extends BaseController {
  HomeApi api = HomeApi();

  HomeController();
  Future<Home> getHomeDate(String id) async {
    return await api.homeData(id);
  }
  Future<Clinic> getclinicData({String? per_page="10", required String page, String? q="", String? favorite="", String? pref_id="", String? city_id="" }) async {
    return await api.getclinicData( per_page!,  page,  q!,  favorite!,  pref_id!,  city_id!);
  }
  Future<Menu> getMenuData({String per_page="10", required String page, String? category_id="", String? clinic_id="", String? q=""}) async {
    return await api.getMenuData( per_page,  page,  category_id!,  clinic_id!,  q!);
  }
   Future<Diary> getDiaryData({String per_page="10", required String page, String? category_id="", String? clinic_id="", String? patient_id="", String? favorote="", String? orderby="", String? menu_id="", String? price_min="", String? price_max="", String? rate="", String? q=""}) async {
    return await api.getDiaryData( per_page,  page,  category_id!,  patient_id!,  favorote!,  orderby!,  menu_id!,  price_min!,  price_max!,  rate!,  q!);
  }
  Future<Doctor> getDoctorData({String per_page="10", required String page, String? clinic_id="", String? favorite="", String? q=""}) async {
    return await api.getDoctorData( per_page,  page, favorite!,  clinic_id!,  q!);
  }
  Future<Case> getCaseData({String per_page="10", required String page, String? clinic_id="", String? doctor_id="", String? q=""}) async {
    return await api.getCaseData( per_page,  page, doctor_id!,  clinic_id!,  q!);
  }
   Future<Counceling> getCouncelingData({String per_page="10", required String page, String? category_id="", String? patient_id="", String? favorote="", String? pref_id="", String? city="", String? orderby=""}) async {
    return await api.getCouncelingData( per_page,  page,  category_id!,  patient_id!,  favorote!,  pref_id!,  city!,  orderby!);
  }
   Future<Question> getQuestionData({String per_page="10", required String page, String? category_id="", String? patient_id="", String? favorote="", String? pref_id="", String? city="", String? orderby=""}) async {
    return await api.getQuestionData( per_page,  page,  category_id!,  patient_id!,  favorote!,  pref_id!,  city!,  orderby!);
  }
}

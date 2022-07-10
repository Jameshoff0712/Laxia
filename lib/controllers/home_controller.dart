import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/case/case_model.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/clinic/clinic_model.dart';
import 'package:laxia/models/clinic/clinicdetail_model.dart';
import 'package:laxia/models/counseling/counceling_model.dart';
import 'package:laxia/models/counseling/councelingdetail_model.dart';
import 'package:laxia/models/diary/diary/diarydetail_model.dart';
import 'package:laxia/models/diary/diary_model.dart';
import 'package:laxia/models/doctor/doctor_model.dart';
import 'package:laxia/models/doctor/doctordetail_model.dart';
import 'package:laxia/models/home/home_model.dart';
import 'package:laxia/models/home/home_search_model.dart';
import 'package:laxia/models/menu/menu_model.dart';
import 'package:laxia/models/question/comment_model.dart';
import 'package:laxia/models/question/question_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/services/http/home_api.dart';

class HomeController extends BaseController {
  HomeApi api = HomeApi();

  HomeController();
  Future<Home> getHomeDate(String id) async {
    return await api.homeData(id);
  }
  Future<Home_Search_Model> getHomeSearch({required String q, required String perpage}) async {
    return await api.homeSearchData(q,perpage);
  }
  Future<Clinic> getclinicData({String? per_page="10", required String page, String? q="", String? favorite="", String? pref_id="", String? city_id="",required String filter}) async {
    return await api.getclinicData( per_page!,  page,  q!,  favorite!,  pref_id!,  city_id!,filter);
  }
   Future<ClinicDetail_Model> getClinicDetail({required int index}) async {
    return await api.getClinicDetail(index);
  }
  Future<Menu> getMenuData({String per_page="10",required String city_id,required String filter, required String page, String? category_id="", String? clinic_id="", String? q=""}) async {
    return await api.getMenuData( per_page,  page,  category_id!,  clinic_id!,  q!,filter,city_id);
  }
   Future<Diary> getDiaryData({String per_page="10", required String page, String? category_id="", String? clinic_id="", String? patient_id="", String? favorote="", String? orderby="", String? menu_id="", String? price_min="", String? price_max="", String? rate="", String? q="",required String filter}) async {
    return await api.getDiaryData( per_page,  page,  category_id!,  patient_id!,  favorote!,  orderby!,  menu_id!,  price_min!,  price_max!,  rate!,  q!,filter);
  }
  Future<DiaryDetail_Model> getDiaryDetail({required int index}) async {
    return await api.getDiaryDetail(index);
  }
  Future<Doctor> getDoctorData({String per_page="10", required String page, String? clinic_id="", String? favorite="", String? q="",required String filter}) async {
    return await api.getDoctorData( per_page,  page, favorite!,  clinic_id!,  q!,filter);
  }
  Future<DoctorDetail_Model> getDoctorDetail({required int index}) async {
    return await api.getDoctorDetail(index);
  }
  Future<bool> postToogleFavorite({required int index, required String domain}) async{
     return api.postToogleFavorite(index,domain);
  }
  Future<bool> postToogleLike({required int index, required String domain}) async{
     return api.postToogleLike(index,domain);
  }
  Future<Case> getCaseData({String per_page="10", required String page, String? clinic_id="", String? doctor_id="", String? q="",required String filter}) async {
    return await api.getCaseData( per_page,  page, doctor_id!,  clinic_id!,  q!, filter);
  }
  Future<Case_Sub_Model> getCaseDetail({required int index}) async {
    return await api.getCaseDetail(index);
  }
   Future<Counceling> getCouncelingData({String per_page="10", required String page, String? category_id="", String? patient_id="", String? favorote="", String? pref_id="", String? city="", String? orderby="",String? q="",required String filter}) async {
    return await api.getCouncelingData( per_page,  page,  category_id!,  patient_id!,  favorote!,  pref_id!,  city!,  orderby!,filter);
  }
  Future<CouncelingDetail_Model> getCouncelingDetail({required int index}) async {
    return await api.getCouncelingDetail(index);
  }
   Future<Question> getQuestionData({String per_page="10", required String page, String? category_id="", String? patient_id="", String? favorote="", String? pref_id="", String? city="", String? orderby="",String ? q="",required String filter}) async {
    return await api.getQuestionData( per_page,  page,  category_id!,  patient_id!,  favorote!,  pref_id!,  city!,  orderby!,filter);
  }
  Future<Question_Sub_Model> getQuestionDetail({required int index}) async {
    return await api.getQuestionDetail(index);
  }
  Future<Comment> getCommentList({required int index, required String domain,String per_page="50", required String page}) async {
    return await api.getCommentList(index,domain,page,per_page);
  }
  Future<Comment_Sub_Model> postComment({required int index, required String domain,required String comment, String? parent_id}) async {
    return await api.postComment(index,domain,comment,parent_id);
  }
}

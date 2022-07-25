import 'dart:async';

import 'package:laxia/models/case/case_model.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/clinic/clinic_model.dart';
import 'package:laxia/models/clinic/clinicdetail_model.dart';
import 'package:laxia/models/counseling/counceling_model.dart';
import 'package:laxia/models/counseling/councelingdetail_model.dart';
import 'package:laxia/models/diary/diary/diarydetail_model.dart';
import 'package:laxia/models/diary/diary/progress_detail_model.dart';
import 'package:laxia/models/diary/diary_model.dart';
import 'package:laxia/models/doctor/doctor_model.dart';
import 'package:laxia/models/doctor/doctordetail_model.dart';
import 'package:laxia/models/home/home_model.dart';
import 'package:laxia/models/home/home_search_model.dart';
import 'package:laxia/models/menu/menu_model.dart';
import 'package:laxia/models/question/comment_model.dart';
import 'package:laxia/models/question/question_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/models/token_model.dart';
import 'package:laxia/services/http/api.dart';

class HomeApi extends Api {
  HomeApi();

  Future<Home> homeData(String id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/tops?category_id="+id, token);
    return Home.fromJson(res.data["contents"]);
  }
  Future<Home_Search_Model> homeSearchData(String q, String perpage) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/search?q="+q+"?perpage="+perpage, token);
    return Home_Search_Model.fromJson(res.data);
  }
  Future<Clinic> getclinicData(String per_page, String page, String q, String favorite, String category_id, String city_id,String filter) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/clinics?per_page="+per_page+"&page="+page+"&q="+q+"&favorite="+favorite+"&category_id="+category_id +"&city_id="+city_id+"&filter="+filter, token);
    return Clinic.fromJson(res.data["clinics"]);
  }
  Future<ClinicDetail_Model> getClinicDetail(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/clinics/"+index.toString(), token);
    return ClinicDetail_Model.fromJson(res.data["clinic"]);
  }
  Future<ProgressDetail_Model> getProgressDetail(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/progresses/"+index.toString(), token);
    return ProgressDetail_Model.fromJson(res.data["progress"]);
  }
  Future<Menu> getMenuData(String per_page, String page, String category_id, String clinic_id, String q,String filter,String city_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/menus?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&clinic_id="+clinic_id+"&q="+q+"&filter="+filter+"&city_id="+city_id, token);
    return Menu.fromJson(res.data["menus"]);
  }
  Future<Diary> getDiaryData(String per_page, String page, String category_id, String patient_id, String favorote, String orderby, String menu_id, String price_min, String price_max, String rate, String q,String filter,String city_id,String year) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/diaries?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&patient_id="+patient_id+"&favorote="+favorote+"&orderby="+orderby+"&menu_id="+menu_id+"&price_min="+price_min+"&price_max="+price_max+"&rate="+rate+"&filter="+filter+"&city_id="+city_id+"&year="+year, token);
      //  print(res.data["data"]["diaries"]);
    return Diary.fromJson(res.data["data"]["diaries"]);
  }
  Future<DiaryDetail_Model> getDiaryDetail(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/diaries/"+index.toString(), token);
    return DiaryDetail_Model.fromJson(res.data["data"]["diary"]);
  }
  Future<Doctor> getDoctorData(String per_page, String page, String favorite, String clinic_id, String q,String filter, String category_id, String city_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/doctors?per_page="+per_page+"&page="+page+"&favorite="+favorite+"&clinic_id="+clinic_id+"&city_id="+city_id+"&category_id="+category_id+"&q="+q+"&filter="+filter, token);
    return Doctor.fromJson(res.data["doctors"]);
  }
  Future<DoctorDetail_Model> getDoctorDetail(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/doctors/"+index.toString(), token);
    return DoctorDetail_Model.fromJson(res.data["doctor"]);
  }
  Future<bool> postToogleFavorite(int index,String domain) async {
    String? token = await preferenceUtil.getToken();
    final res=await Api.post("$apiUrl/$domain/"+index.toString()+"/toggleFavorite",<String, String>{},token);
    if(res!.data["status"]==1){
      return true;
    }
    return false;
  }
  Future<bool> postToogleFollow(int index) async {
    String? token = await preferenceUtil.getToken();
    final res=await Api.post("$apiUrl/patients/$index/toggleFollow",<String, String>{},token);
    if(res!.data["status"]==1){
      return true;
    }
    return false;
  }
  Future<bool> postToogleLike(int index,String domain) async {
    String? token = await preferenceUtil.getToken();
    final res=await Api.post("$apiUrl/$domain/"+index.toString()+"/toggleLike",<String, String>{},token);
    if(res!.data["status"]==1){
      return true;
    }
    return false;
  }
  Future<Case> getCaseData(String per_page, String page, String clinic_id, String doctor_id, String q,String filter, String price_min, String price_max, String year) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/cases?per_page="+per_page+"&page="+page+"&clinic_id="+clinic_id+"&doctor_id="+doctor_id+"&q="+q+"&filter="+filter+"&price_min="+price_min+"&price_max="+price_max+"&year="+year.toString(), token);
    // print(res.data["cases"]);
    return Case.fromJson(res.data["cases"]);
  }
  Future<Case_Sub_Model> getCaseDetail(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/cases/"+index.toString(), token);
    return Case_Sub_Model.fromJson(res.data["case"]);
  }
   Future<Counceling> getCouncelingData(String per_page, String page, String category_id, String patient_id, String favorote, String pref_id, String city, String orderby, String filter) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/counselings?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&patient_id="+patient_id+"&favorote="+favorote+"&pref_id="+pref_id+"&city="+city+"&orderby="+orderby+"&filter="+filter, token);
    // print(res.data["data"]["counselings"]);
    return Counceling.fromJson(res.data["data"]["counselings"]);
  }
  Future<CouncelingDetail_Model> getCouncelingDetail(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/counselings/"+index.toString(), token);
    return CouncelingDetail_Model.fromJson(res.data["data"]["counseling"]);
  }
  Future<Question> getQuestionData(String per_page, String page, String category_id, String patient_id, String favorote, String pref_id, String city, String orderby,String filter,String isanswer) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/questions?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&patient_id="+patient_id+"&pref_id="+pref_id+"&city="+city+"&orderby="+orderby+"&isanswer="+isanswer, token);
    //  print(res.data["data"]["questions"]);
    return Question.fromJson(res.data["data"]["questions"]);
  }
  Future<Question_Sub_Model> getQuestionDetail(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/questions/"+index.toString(), token);
    return Question_Sub_Model.fromJson(res.data["data"]["question"]);
  }
  Future<Comment> getCommentList(int index,String domain,String page, String per_page) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/$domain/"+index.toString()+"/comments?per_page="+per_page+"&page="+page,token);
    return Comment.fromJson(res.data["data"]);
  }
  Future<Comment_Sub_Model> postComment(int index,String domain,String comment, String? parent_id) async {
    String? token = await preferenceUtil.getToken();
    final res;
    if(parent_id==null){
       res = await Api.post("$apiUrl/$domain/"+index.toString()+"/comments",<String, String>{"comments[comment]":comment},token);
    }else{
       res = await Api.post("$apiUrl/$domain/"+index.toString()+"/comments",<String, String>{"comments[comment]":comment,"comments[parent_id]":parent_id},token);
    }
    return Comment_Sub_Model.fromJson(res!.data["data"]["comment"]);
  }
}

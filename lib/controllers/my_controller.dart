import 'dart:io';

import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/counseling/councelingdetail_model.dart';
import 'package:laxia/models/diary/diary/diarydetail_model.dart';
import 'package:laxia/models/diary_post_model.dart';
import 'package:laxia/models/follow/follow_model.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/point/point_model.dart';
import 'package:laxia/models/profile_model.dart';
import 'package:laxia/models/question_post_model.dart';
import 'package:laxia/services/http/my_api.dart';

import '../models/counsel_post_model.dart';
import '../models/question/media_model.dart';

class MyController extends BaseController {
  MyApi api = MyApi();
  MyController();

  Future<Follow> getFollows({String? per_page="10", required String page, String? q=""}) async{
    return await api.getFollows(per_page!, page, q!);
  }
  Future<Follow> getFollowers({String? per_page="10", required String page}) async{
    return await api.getFollowers(per_page!, page);
  }
  Future<Point> getPointInfo() async {
    return await api.getPointInfo();
  }
  Future<dynamic> editProfile(ProfileModel profile) async {
    return await api.editProfile(profile);
  }
  Future<Me> getPatientInfo(int index) async {
    return await api.getPatientInfo(index);
  }
  Future<bool> postTooglefollow({required int index}) async {
    return await api.postTooglefollow(index);
  }
  Future<dynamic> postQuestion(QuestionPostModel newQuestion) async {
    return await api.postQuestion(newQuestion);
  }
  Future<dynamic> postCounsel(CounselPostModel newCounsel) async {
    return await api.postCounsel(newCounsel);
  }
  Future<dynamic> editCounsel(CounselPostModel newCounsel, String counsel_id) async {
    return await api.editCounsel(newCounsel, counsel_id);
  }
  Future<dynamic> postDiary(DiaryPostModel newDiary) async {
    return await api.postDiary(newDiary);
  }
  Future<dynamic> editDiary(DiaryPostModel newDiary, String diary_id) async {
    return await api.editDiary(newDiary, diary_id);
  }
  Future<Media_model> imageUpload(String imagePicked) {
    return api.imageUpload(imagePicked);
  }

  
  Future<CouncelingDetail_Model> getCounselDetail(String counsel_id) async {
    return await api.getCounselDetail(counsel_id);
  }
  Future<DiaryDetail_Model> getDiaryDetail(String diary_id) async {
    return await api.getDiaryDetail(diary_id);
  }
}

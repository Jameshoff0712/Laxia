import 'package:laxia/models/follow/follow_model.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/point/point_model.dart';
import 'package:laxia/services/http/api.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class MyApi extends Api {
  MyApi();

  Future<Follow> getFollows(String per_page, String page, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/follows?per_page=" + per_page + "&page=" + page + "&q=" + q,
        token);
    return Follow.fromJson(res.data["data"]["follows"]);
  }

  Future<Follow> getFollowers(String per_page, String page) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/followers?per_page=" + per_page + "&page=" + page, token);
    return Follow.fromJson(res.data["data"]["followers"]);
  }
  Future<Me> getPatientInfo(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/patients/$index", token);
    return Me.fromJson(res.data['data']['patient']);
  }
  Future<Point> getPointInfo() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/points/history", token);
    return Point.fromJson(res.data);
  }
  Future<bool> postTooglefollow(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post("$apiUrl/patients/$index/toggleFollow",<String, String>{}, token);
    if(res!.data["status"]==1){
      return true;
    }
    return false;
  }
  Future<void> postDiary(
      int clinic_id,
      String date,
      int doctor_id,
      List<int> operationTypes,
      List<String> questions,
      List<int> rates,
      int cost_anesthetic,
      int cost_drug,
      int cost_other,
      List images) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
        "$apiUrl/diaries",
        <String, String>{
          "diaries[clinic_id]": clinic_id.toString(),
          "diaries[treat_date]": date,
          "diaries[doctor_id]": doctor_id.toString(),
          for (int i = 0; i < operationTypes.length; i++)
            "categories[" + i.toString() + "]": operationTypes[i].toString(),
          for (int j = 0; j < questions.length; j++)
            "diary_tqs[" + (j + 1).toString() + "]": questions[j],
          for (int k = 0; k < rates.length; k++)
            "diaries[rate_0" + (k + 1).toString() + "]": rates[k].toString(),
          "diaries[cost_anesthetic]": cost_anesthetic.toString(),
          "diaries[cost_drug]": cost_drug.toString(),
          "diaries[cost_other]": cost_other.toString(),
          for (int i = 0; i < images.length; i++)
            "medias[" + i.toString() + "]": images[i].toString(),
        },
        token);
    
  }
}

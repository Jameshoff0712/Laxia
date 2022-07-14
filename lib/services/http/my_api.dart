import 'package:laxia/models/follow/follow_model.dart';
import 'package:laxia/models/point/point_model.dart';
import 'package:laxia/models/profile_model.dart';
import 'package:laxia/services/http/api.dart';
import 'package:http/http.dart' as http;

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

  Future<Point> getPointInfo() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/points/history", token);
    return Point.fromJson(res.data);
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

  Future<dynamic> editProfile(ProfileModel profile) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
      "$apiUrl/register/detail",
        profile.list(),
        token
    );
    return res;
  }

  Future<void> editImageUpload() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.put(
      "$apiUrl/",
      <String, String> {
        "image": "ryu"
      },
      token
    );
  }
}

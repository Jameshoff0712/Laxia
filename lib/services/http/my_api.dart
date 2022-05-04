import 'package:laxia/models/follow/follow_model.dart';
import 'package:laxia/models/point/point_model.dart';
import 'package:laxia/services/http/api.dart';

class MyApi extends Api {
  MyApi();

  Future<Follow> getFollows(String per_page, String page, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/follows?per_page="+per_page+"&page="+page+"&q="+q, token);
    return Follow.fromJson(res.data["data"]["follows"]);
  }
  Future<Follow> getFollowers(String per_page, String page) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/followers?per_page="+per_page+"&page="+page, token);
    return Follow.fromJson(res.data["data"]["followers"]);
  }
  Future<Point> getPointInfo() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/points/history", token);
    return Point.fromJson(res.data);
  }
}
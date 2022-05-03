import 'package:laxia/models/static/areas_model.dart';
import 'package:laxia/models/static/master_model.dart';
import 'package:laxia/services/http/api.dart';

class HomeApi extends Api {
  HomeApi();

  Future<List<Master_Model>> getTreatCategories() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/load/master", token);
    return List<Master_Model>.from(res.data["data"]["treatCategories"].map((x) => Master_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
  Future<List<Area_Model>> getAreas() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/load/areas", token);
    return List<Area_Model>.from(res.data["data"].map((x) => Area_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
}

import 'package:laxia/models/home_modell.dart';
import 'package:laxia/models/token_model.dart';
import 'package:laxia/services/http/api.dart';

class HomeApi extends Api {
  HomeApi();

  Future<Home> homeData(String id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/tops?category_id="+id, token);
    return Home.fromJson(res.data["contents"]);
  }
  Future<Home> getclinicData(String per_page, String page, String q, String favorite, String pref_id, String city_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/clinics?per_page="+per_page+"&page="+page+"&q="+q+"&favorite="+favorite+"&pref_id="+pref_id +"&city_id="+city_id, token);
    return Home.fromJson(res.data["clinics"]);
  }
  Future<Home> getMenuData(String per_page, String page, String category_id, String clinic_id, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/menus?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&clinic_id="+clinic_id+"&q="+q, token);
    return Home.fromJson(res.data["menus"]);
  }
  Future<Home> getDiaryData(String per_page, String page, String category_id, String patient_id, String favorote, String orderby, String menu_id, String price, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/menus?per_page="+per_page+"&page="+page+"&category_id="+category_id+"&patient_id="+patient_id+"&q="+q+"&favorote="+favorote+"&orderby="+orderby+"&menu_id="+menu_id+"&price="+price+"&q="+q, token);
    return Home.fromJson(res.data["menus"]);
  }
}

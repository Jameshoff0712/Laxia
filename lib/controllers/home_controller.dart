import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/home_modell.dart';
import 'package:laxia/services/http/home_api.dart';

class HomeController extends BaseController {
  HomeApi api = HomeApi();

  HomeController();
  Future<Home> getHomeDate(String id) async {
    return await api.homeData(id);
  }
  Future<Home> getclinicData({String? per_page="10", required String page, String? q="", String? favorite="", String? pref_id="", String? city_id="" }) async {
    return await api.getclinicData( per_page!,  page,  q!,  favorite!,  pref_id!,  city_id!);
  }
  Future<Home> getMenuData({String per_page="10", required String page, String? category_id="", String? clinic_id="", String? q=""}) async {
    return await api.getMenuData( per_page,  page,  category_id!,  clinic_id!,  q!);
  }
   Future<Home> getDiaryData({String per_page="10", required String page, String? category_id="", String? clinic_id="", String? patient_id="", String? favorote="", String? orderby="", String? menu_id="", String? price="", String? q=""}) async {
    return await api.getDiaryData( per_page,  page,  category_id!,  patient_id!,  favorote!,  orderby!,  menu_id!,  price!,  q!);
  }
}

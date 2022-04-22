import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/models/doctor_api_model.dart';
import 'package:laxia/models/menu_api_model.dart';
import 'package:laxia/services/http/api.dart';

class FavoriteApi extends Api {
  FavoriteApi();

  Future<List<Menu>> getFavMenu() async {
    final List<Menu> listsFavMenu = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/menus?per_page=10&page=1&category_id=&clinic_id=&favorite=true&q=メニュー", token);
    for(int i=0; i < res.data["menus"]["data"].length; i++)
      listsFavMenu.add(Menu.fromJson(res.data["menus"]["data"][i]));
    return listsFavMenu;
  }
  Future<List<Doctor>> getFavDoctor() async {
    final List<Doctor> listsFavDoctor = [];
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/doctors?per_page=100&page=1&clinic_id=1&favorite=true&q=", token);
    for(int i=0; i < res.data["doctors"]["data"].length; i++)
      listsFavDoctor.add(Doctor.fromJson(res.data["doctors"]["data"][i]));
    return listsFavDoctor;
  }
}

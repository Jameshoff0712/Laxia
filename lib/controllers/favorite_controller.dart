import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/clinic_api_model.dart';
import 'package:laxia/models/counseling_api_model.dart';
import 'package:laxia/models/diary_api_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/models/menu_api_model.dart';
import 'package:laxia/services/http/favorite_api.dart';

import '../models/doctor_api_model.dart';

class FavoriteController extends BaseController {
  FavoriteApi api = FavoriteApi();

  FavoriteController();

  Future<List<Menu>> getFavMenu() async {
    return await api.getFavMenu();
  }
  Future<List<Clinic>> getFavClinic() async {
    return await api.getFavClinic();
  }
  Future<List<Doctor>> getFavDoctor() async {
    return await api.getFavDoctor();
  }
  Future<List<Diary>> getFavDiary() async {
    return await api.getFavDiary();
  }
  Future<List<Counseling>> getFavCounseling() async {
    return await api.getFavCounseling();
  }
}
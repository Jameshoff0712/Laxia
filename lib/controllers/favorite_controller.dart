import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/clinic/clinic_sub_model.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/services/http/favorite_api.dart';


class FavoriteController extends BaseController {
  FavoriteApi api = FavoriteApi();

  FavoriteController();

  Future<List<Menu_Sub_Model>> getFavMenu() async {
    return await api.getFavMenu();
  }
  Future<List<Clinic_Sub_Model>> getFavClinic() async {
    return await api.getFavClinic();
  }
  Future<List<Doctor_Sub_Model>> getFavDoctor() async {
    return await api.getFavDoctor();
  }
  Future<List<Diary_Sub_Model>> getFavDiary() async {
    return await api.getFavDiary();
  }
  Future<List<Counceling_Sub_Model>> getFavCounseling() async {
    return await api.getFavCounseling();
  }
  Future<List<Question_Sub_Model>> getFavQuestion() async {
    return await api.getFavQuestion();
  }
}
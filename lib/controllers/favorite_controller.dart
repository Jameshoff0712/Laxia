import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/services/http/favorite_api.dart';

import '../models/doctor_api_model.dart';

class FavoriteController extends BaseController {
  FavoriteApi api = FavoriteApi();

  FavoriteController();

  Future<List<Doctor>> getFavDoctor() async {
    return await api.getFavDoctor();
  }
}
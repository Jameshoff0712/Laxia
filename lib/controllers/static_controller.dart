import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/static/master_model.dart';
import 'package:laxia/services/http/static_api.dart';

class StaticController extends BaseController {
  HomeApi api = HomeApi();

  StaticController();
  Future<List<Master_Model>> getTreatCategories() async {
    return await api.getTreatCategories();
  }
}

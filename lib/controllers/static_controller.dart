import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/static/Search_Model.dart';
import 'package:laxia/models/static/areas_model.dart';
import 'package:laxia/models/static/master_model.dart';
import 'package:laxia/models/static/message_model.dart';
import 'package:laxia/models/static/midsearch_model.dart';
import 'package:laxia/services/http/static_api.dart';

class StaticController extends BaseController {
  HomeApi api = HomeApi();

  StaticController();
  Future<List<Master_Model>> getTreatCategories() async {
    return await api.getTreatCategories();
  }
  Future<List<Message_Model>> getMessages(String mailbox) async {
    return await api.getMessages(mailbox);
  }
  Future<Message_Model> postMessage(String value, int isfile,String id) async {
    return await api.postMessage(value,isfile,id);
  }
  Future<MidSearch_Model> midSearch(String q) async {
    return await api.midSearch(q);
  }
  Future<Search_Model> getSearch() async {
    return await api.getSearch();
  }
  Future<List<Master_Model>> getIndexTreatCategories(int index) async {
    return await api.getIndexTreatCategories(index);
  }
  Future<List<Area_Model>> getAreas() async {
    return await api.getAreas();
  }
}

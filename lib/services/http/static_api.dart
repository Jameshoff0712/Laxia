import 'package:laxia/models/static/Search_Model.dart';
import 'package:laxia/models/static/areas_model.dart';
import 'package:laxia/models/static/master_model.dart';
import 'package:laxia/models/static/menulist_model.dart';
import 'package:laxia/models/static/message_model.dart';
import 'package:laxia/models/static/midsearch_model.dart';
import 'package:laxia/services/http/api.dart';

class HomeApi extends Api {
  HomeApi();

  Future<List<Master_Model>> getTreatCategories() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/load/master", token);
    return List<Master_Model>.from(res.data["data"]["treatCategories"].map((x) => Master_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
  Future<List<Menulist_Model>> getMenuList() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/load/master/partmenu", token);
    print(res.data);
    return List<Menulist_Model>.from(res.data["data"].map((x) => Menulist_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
  Future<List<Message_Model>> getMessages(String mailbox) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/mailboxs/$mailbox/messages", token);
    return List<Message_Model>.from(res.data["messages"].map((x) => Message_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
  Future<Message_Model> postMessage(String value,int isfile, String id) async {
    String? token = await preferenceUtil.getToken();
    final res=await Api.post("$apiUrl/mailboxs/$id/messages",
      <String, String> {
        'messages[message]': value.toString(),
        'messages[is_file]': isfile.toString(),
      },token);
     return Message_Model.fromJson(res!.data['message']);
  }
  Future<MidSearch_Model> midSearch(String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/midsearch?q=$q", token);
    return MidSearch_Model.fromJson(res.data);
  }
  Future<Search_Model> getSearch() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/globalsearch", token);
    return Search_Model.fromJson(res.data);
  }
  Future<List<Master_Model>> getIndexTreatCategories(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/load/master/$index", token);
    return List<Master_Model>.from(res.data["data"]["treatCategories"].map((x) => Master_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
  Future<Master_Model> getIndexPartCategories(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/load/master/part/$index", token);
    return Master_Model.fromJson(res.data["data"]["treatCategories"]);
  }
  Future<List<Area_Model>> getAreas() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/load/areas", token);
    return List<Area_Model>.from(res.data["data"].map((x) => Area_Model.fromJson(x as Map<String, dynamic>)) as Iterable<dynamic>);
  }
}

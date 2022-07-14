import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/follow/follow_model.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/point/point_model.dart';
import 'package:laxia/services/http/my_api.dart';

class MyController extends BaseController {
  MyApi api = MyApi();
  MyController();

  Future<Follow> getFollows({String? per_page="10", required String page, String? q=""}) async{
    return await api.getFollows(per_page!, page, q!);
  }
  Future<Follow> getFollowers({String? per_page="10", required String page}) async{
    return await api.getFollowers(per_page!, page);
  }
  Future<Point> getPointInfo() async {
    return await api.getPointInfo();
  }
  Future<Me> getPatientInfo(int index) async {
    return await api.getPatientInfo(index);
  }
  Future<bool> postTooglefollow({required int index}){
    return api.postTooglefollow(index);
  }
}
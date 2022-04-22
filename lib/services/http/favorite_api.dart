import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/models/doctor_api_model.dart';
import 'package:laxia/services/http/api.dart';

class FavoriteApi extends Api {
  FavoriteApi();

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

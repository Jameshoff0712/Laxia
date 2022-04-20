import 'package:laxia/models/status_model.dart';
import 'package:laxia/services/http/api.dart';

class ReservationApi extends Api {
  ReservationApi();

  Future<StatusInfo> allStatus() async {
    String? token = await preferenceUtil.getToken();
    print(token);
    final res = await Api.get("$apiUrl/reservations?status=", token);
    print(StatusInfo.fromJson(res.data));
    return StatusInfo.fromJson(res.data);
  } 
}
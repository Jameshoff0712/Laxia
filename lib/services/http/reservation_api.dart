import 'package:laxia/models/status_model.dart';
import 'package:laxia/models/token_model.dart';
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

  Future<void> reserve(
      int clinic_id,
      String doctor_id,
      int type,
      String note,
      int hope_treat,
      String kana1,
      String kana2,
      String gender,
      String phone_number,
      String birthday,
      int use_point,
      String time) async {
    String? token = await preferenceUtil.getToken();
    final res =
        await Api.post("$apiUrl/reservations", <String, String>{
          "rsv[clinic_id]" : clinic_id.toString(),
          "rsv[doctor_id]" : doctor_id,
          "rsv[type]" : type.toString(),
          "rsv[note]" : note,
          "rsv[hope_treat]" : hope_treat.toString(),
          "info[kana01]" : kana1,
          "info[kana02]" : kana2,
          "info[gender]" : gender,
          "info[phone_number]" : phone_number,
          "info[birthday]" : birthday,
          "time[0][date]" : time
        }, token);
    if (res != null) {
      // print(res.data['status']);
      
      if (res.data['status'] != 0) {

      } else {
        print(res.code);
        if (res.code == 401) {
          throw Exception("Unauthorized");
        }
        throw Exception("Unknown error");
      }
    } else {
      throw Exception("Unknown error");
    }
  }
}

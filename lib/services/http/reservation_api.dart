import 'package:laxia/models/reserve_post_model.dart';
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

  Future<void> reserve(ReservePost rsv) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
        "$apiUrl/reservations",
        <String, String>{
          "rsv[clinic_id]": rsv.clinic_id.toString(),
          // rsv.opertion_type
          "rsv[type]": rsv.opertion_type.toString(),
          "rsv[doctor_id]": rsv.doctor_id.toString(),
          "rsv[note]": rsv.question_content,
          "rsv[hope_treat]": rsv.decision_type_today.toString(),
          for (int i = 0; i < rsv.list_visitDates.length; i++)
            "time[" + i.toString() + "][date]":
                rsv.list_visitDates[i]["year"].toString() +
                    "/" +
                    rsv.list_visitDates[i]["month"].toString() +
                    "/" +
                    rsv.list_visitDates[i]["day"].toString(),
          for (int i = 0; i < rsv.list_visitDates.length; i++)
            "time[" + i.toString() + "][start_time]":
                rsv.list_visitDates[i]["time"].toString(),
          "info[kana01]": rsv.firstName,
          "info[kana02]": rsv.secondName,
          "info[birthday]": rsv.birthday,
          "info[gender]": rsv.gender_id == 0 ? "female" : "male",
          "info[phone_number]": rsv.mobileNumber,
          "rsv[use_point]": rsv.usedPoint.toString(),

        },
        token);
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

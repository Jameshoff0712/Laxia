import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/status_model.dart';
import 'package:laxia/services/http/reservation_api.dart';

class ReserveController extends BaseController {
  ReserveController();

  ReservationApi api = ReservationApi();

  Future<StatusInfo> getAllStatus() async {
    // print(await api.allStatus());
    return await api.allStatus();
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
    await api.reserve(clinic_id, doctor_id, type, note, hope_treat, kana1, kana2,
        gender, phone_number, birthday, use_point, time);
  }
}

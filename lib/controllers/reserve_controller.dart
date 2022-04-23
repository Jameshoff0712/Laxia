import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/reserve_post_model.dart';
import 'package:laxia/models/status_model.dart';
import 'package:laxia/services/http/reservation_api.dart';

class ReserveController extends BaseController {
  ReserveController();

  ReservationApi api = ReservationApi();

  Future<StatusInfo> getAllStatus() async {
    // print(await api.allStatus());
    return await api.allStatus();
  }

  Future<void> reserve(ReservePost rsv) async {
    await api.reserve(rsv);
  }
}

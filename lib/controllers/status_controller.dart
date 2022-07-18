import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/status_model.dart';
import 'package:laxia/services/http/reservation_api.dart';

class StatusController extends BaseController {
  StatusController();

  ReservationApi api = ReservationApi();

  Future<List<StatusInfo>> getAllStatus() async {
    // print(await api.allStatus());
    return await api.allStatus();
  }
}
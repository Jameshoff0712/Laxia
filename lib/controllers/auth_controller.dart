import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/res_model.dart';
import 'package:laxia/services/http/auth_api.dart';

class AuthController extends BaseController {
  AuthApi api = AuthApi();

  AuthController();

  bool hidePassword = true;
  bool loading = false;

  Future<String> authorize(String email, String password) async {
    return await api.authorize(email, password);
  }

  Future<Me> getMe() async {
    return await api.me();
  }

  Future<bool> isLoggedIn() async {
    return await api.preferenceUtil.getToken() != null;
  }

  Future<void> logout() async {
    await api.preferenceUtil.removeToken();
  }

  Future<void> registerEmail(String email, String password) async {
    return await api.registerEmail(email, password);
  }

  Future<void> sendEmail(String email) async{
    return await api.sendEmail(email);
  }
  Future<void> resetPassword(String password, String code) async{
    return await api.resetPassword(password, code);
  }

  void facebookLogin() async {}

  void googleLogin() async {}

  void twitterLogin() async {}
}

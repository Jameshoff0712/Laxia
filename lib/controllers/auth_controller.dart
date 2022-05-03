import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/me_model.dart';
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

  void register() async {}

  void resetPassword() {}

  void facebookLogin() async {}

  void googleLogin() async {}

  void twitterLogin() async {}
}

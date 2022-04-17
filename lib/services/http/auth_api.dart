import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/token_model.dart';
import 'package:laxia/services/http/api.dart';

class AuthApi extends Api {
  AuthApi();

  Future<String> authorize(String email, String password) async {
    final res = await Api.post("$apiUrl/login",
        <String, String>{"email": email, "password": password}, "");
    if (res != null) {
      if (res.status != null) {
        String newToken = Token.fromJson(res.data).token;
        await preferenceUtil.setToken("Bearer $newToken");
        return newToken;
      } else {
        if (res.code == 401) {
          throw Exception("Unauthorized");
        }

        throw Exception("Unknown error");
      }
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<Me> me() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/me", token);
    return Me.fromJson(res.data);
  }
}

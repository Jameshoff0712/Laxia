import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/res_model.dart';
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

  Future<void> registerEmail(String email, String password) async {
    final res = await Api.post(
        "$apiUrl/register/email",
        <String, String>{
          "email": email,
          "password": password,
          "password_confirmation": password
        },
        "");
    if (res != null) {
      if (res.data["status"] == 0) {
        throw Exception("incorrect value");
      }
      // if (res.status != null) {
      //   String newToken = Token.fromJson(res.data).token;
      //   await preferenceUtil.setToken("Bearer $newToken");
      //   return newToken;
      // } else {
      //   if (res.code == 401) {
      //     throw Exception("Unauthorized");
      //   }

      //   throw Exception("Unknown error");
      // }
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<String> sendEmail(String email) async {
    final res = await Api.post(
        "$apiUrl/password/email", <String, String>{"email": email}, "");
    if (res != null) {
      return res.data['send_flag'];
      // throw Exception("email error");
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<bool> resetPassword(String password, String email, token) async {
    final res = await Api.post(
        "$apiUrl/password/reset",
        <String, String>{"password": password, "email": email, "token": token},
        "");
    if (res != null) {
      print(res.data);
      return res.data['success'];
    } else {
      throw Exception("Unknown error");
    }
  }
}

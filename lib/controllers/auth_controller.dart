import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<void> registerEmail(String email, String password) async {
    return await api.registerEmail(email, password);
  }

  Future<void> sendEmail(String email) async{
    return await api.sendEmail(email);
  }
  Future<void> resetPassword(String password, String code) async{
    return await api.resetPassword(password, code);
  }

  Future<UserCredential?> facebookLogin() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: [
        'email', 'public_profile'
      ]
    );
    
    if (loginResult.status == LoginStatus.success) {
      
      final AccessToken? accessToken = loginResult.accessToken;

      final useData = await FacebookAuth.instance.getUserData();

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final providerId = facebookAuthCredential.providerId;

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      try {
        this._login("facebook", useData['email'], providerId);
      } catch(e) {

      }
    } else if(loginResult.status == LoginStatus.cancelled) {
      print("FB cancelled");
      return null;
    } else if(loginResult.status == LoginStatus.failed) {
      print("FB error: ${loginResult.message}");
      return null;
    }

  }

  void appleLogin() async {

  }

  void twitterLogin() async {
    
  }

  Future<String> _login(String provider, String email, String providerId) async {
    return await api.socialAuthorize(provider, email, providerId);
  }

  Future<UserCredential?> googleLogin() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    var email = googleUser?.email;
    var providerId = googleAuth?.idToken;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    print(googleAuth?.accessToken);
    print(googleAuth?.idToken);
    
    await FirebaseAuth.instance.signInWithCredential(credential);

    try {
        print("login start");
        this._login("facebook", email!, providerId!);
      } catch(e) {

    }

  }
}

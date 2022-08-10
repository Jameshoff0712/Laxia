import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laxia/controllers/base_controller.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/services/http/auth_api.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

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
      // final providerId = facebookAuthCredential.providerId;

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      final email = FirebaseAuth.instance.currentUser!.email!;
      final providerId = FirebaseAuth.instance.currentUser!.uid;

      try {
        this._login("facebook", email, providerId);
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

  String generateNoce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
  }

  String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
  }

  Future<UserCredential?> appleLogin() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    
    await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    final email = FirebaseAuth.instance.currentUser!.email!;
    final providerId = FirebaseAuth.instance.currentUser!.uid;

    try {
        this._login("apple", email, providerId);
      } catch(e) {

      }
  }

  Future<UserCredential?> twitterLogin() async {
    var twitterApiKey = "VhIcmCFIMAta3ltaDTrVyJQub";
    var twitterApiSecret = "zo2OIjgrno1jEP0l0t7haaWaNzMNRkGpPCrY9srA3YvgJYT2oQ";
    var redirectURI = "https://laxia-app.firebaseapp.com/__/auth/handler";

    final twitterLogin = new TwitterLogin(
      apiKey: twitterApiKey,
      apiSecretKey: twitterApiSecret,
      redirectURI: redirectURI,
    );

    final authResult = await twitterLogin.login();

    if(authResult.status == TwitterLoginStatus.loggedIn) {
      final twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: authResult.authToken!, 
      secret: authResult.authTokenSecret!
      );
      
      final userCredential = FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);

      //final email = authResult.user!.email;
      
      final email = FirebaseAuth.instance.currentUser!.email!;
      final providerId = FirebaseAuth.instance.currentUser!.uid;

      try {
        this._login("twitter", email, providerId);
      } catch(e) {

      }
    } else if(authResult.status == TwitterLoginStatus.cancelledByUser) {
      print("Twitter cancelled");
      return null;
    } else if(authResult.status == TwitterLoginStatus.error) {
      print("Twitter cancelled");
      return null;
    }
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

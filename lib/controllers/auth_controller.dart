// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import '../../generated/l10n.dart';
import '../common/helper.dart';
import '../models/m_user.dart';
// import '../services/user_service.dart' as repository;
// import '../services/settings_service.dart' as settingRepo;

class AuthController extends ControllerMVC {
  User user = User();
  bool hidePassword = true;
  bool loading = false;
  GlobalKey<FormState>? loginFormKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  BuildContext? context;
  // FirebaseMessaging _firebaseMessaging;
  OverlayEntry? loader;

  AuthController() {
    // context = this.state.context;
    loader = Helper.overlayLoader(context);
    loginFormKey = GlobalKey<FormState>();
    this.scaffoldKey = GlobalKey<ScaffoldState>();
    // _firebaseMessaging = FirebaseMessaging();
    // _firebaseMessaging.getToken().then((String _deviceToken) {
    //   user.deviceToken = _deviceToken;
    // }).catchError((e) {
    //   print('Notification not configured');
    // });
  }

  bool keyboardIsVisible() {
    return !(MediaQuery.of(context!).viewInsets.bottom == 0.0);
  }

  void login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('isLoggedIn', 'true');
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Helper.mainColor,
    ));
    Navigator.of(context).pushReplacementNamed('/splash');
    // FocusScope.of(context).unfocus();
    // if (loginFormKey.currentState.validate()) {
    //   loginFormKey.currentState.save();
    //   Overlay.of(context).insert(loader);
    //   repository.login(user).then((value) async {
    //     if (value != null && value.apiToken != null) {
    //       SharedPreferences prefs = await SharedPreferences.getInstance();
    //       prefs.setString('delivery_address', json.encode(value.userDefaultAddress));
    //       Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
    //     } else {
    //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //         content: Text(Trans.of(context).wrong_email_or_password),
    //       ));
    //     }
    //   }).catchError((e) {
    //     loader.remove();
    //     scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //       content: Text('$e'),
    //     ));
    //   }).whenComplete(() {
    //     Helper.hideLoader(loader);
    //   });
    // }
  }

  void register() async {
    // FocusScope.of(context).unfocus();
    // if (loginFormKey.currentState.validate()) {
    //   loginFormKey.currentState.save();
    //   Overlay.of(context).insert(loader);
    //   repository.register(user).then((value) {
    //     if (value != null && value.apiToken != null) {
    //       Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
    //     } else {
    //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //         content: Text(Trans.of(context).wrong_email_or_password),
    //       ));
    //     }
    //   }).catchError((e) {
    //     loader?.remove();
    //     scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //       content: Text('$e'),
    //     ));
    //   }).whenComplete(() {
    //     Helper.hideLoader(loader);
    //   });
    // }
  }

  void resetPassword() {
    // FocusScope.of(context).unfocus();
    // if (loginFormKey.currentState.validate()) {
    //   loginFormKey.currentState.save();
    //   Overlay.of(context).insert(loader);
    //   repository.resetPassword(user).then((value) {
    //     if (value != null && value == true) {
    //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //         content: Text(Trans.of(context).your_reset_link_has_been_sent_to_your_email),
    //         action: SnackBarAction(
    //           label: Trans.of(context).login,
    //           onPressed: () {
    //             Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Login');
    //           },
    //         ),
    //         duration: Duration(seconds: 10),
    //       ));
    //     } else {
    //       loader.remove();
    //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //         content: Text(Trans.of(context).error_verify_email_settings),
    //       ));
    //     }
    //   }).whenComplete(() {
    //     Helper.hideLoader(loader);
    //   });
    // }
  }

  void facebookLogin() async {
    // final facebookLogin = FacebookLogin();
    // // facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // final facebookLoginResult = await facebookLogin.logIn(['email', 'public_profile']);
    // print(facebookLoginResult.status);
    // print(facebookLoginResult.accessToken);
    // print(facebookLoginResult.accessToken.token);
    // print(facebookLoginResult.accessToken.expires);
    // print(facebookLoginResult.accessToken.permissions);
    // print(facebookLoginResult.accessToken.userId);
    // print(facebookLoginResult.accessToken.isValid());

    // print(facebookLoginResult.errorMessage);
    // print(facebookLoginResult.status);

    // final token = facebookLoginResult.accessToken.token;

    // /// for profile details also use the below code
    // final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
    // final profile = json.decode(graphResponse.body);
    // user.email = profile["email"];
    // user.name = profile["name"];
    // user.socialToken = token;
    // user.password = "123456";
    // user.type = 1;
    // if (facebookLoginResult.accessToken.isValid()) {
    //   Overlay.of(context).insert(loader);
    //   repository.socialSignup(user).then((value) {
    //     if (value != null && value.apiToken != null) {
    //       Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
    //     } else {
    //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //         content: Text(Trans.of(context).wrong_email_or_password),
    //       ));
    //     }
    //   }).catchError((e) {
    //     loader?.remove();
    //     scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //       content: Text('$e'),
    //     ));
    //   }).whenComplete(() {
    //     Helper.hideLoader(loader);
    //   });
    // }
  }

  void googleLogin() async {
    // GoogleSignIn _googleSignIn = GoogleSignIn(
    //   scopes: [
    //     'email',
    //     // you can add extras if you require
    //   ],
    // );

    // _googleSignIn.signIn().then((GoogleSignInAccount acc) async {
    //   GoogleSignInAuthentication auth = await acc.authentication;
    //   print(auth);
    //   print(acc.id);
    //   print(acc.email);
    //   print(acc.displayName);
    //   print(acc.photoUrl);

    //   acc.authentication.then((GoogleSignInAuthentication auth) async {
    //     print(auth.idToken);
    //     print(auth.accessToken);
    //     user.email = acc.email;
    //     user.name = acc.displayName;
    //     user.socialToken = auth.idToken;
    //     user.type = 2;
    //     Overlay.of(context).insert(loader);
    //     repository.socialSignup(user).then((value) {
    //       if (value != null && value.apiToken != null) {
    //         Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
    //       } else {
    //         scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //           content: Text(Trans.of(context).wrong_email_or_password),
    //         ));
    //       }
    //     }).catchError((e) {
    //       loader?.remove();
    //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
    //         content: Text('$e'),
    //       ));
    //     }).whenComplete(() {
    //       Helper.hideLoader(loader);
    //     });
    //   });
    // });
  }

  void twitterLogin() async {
    // final TwitterLogin twitterLogin = new TwitterLogin(
    //   consumerKey: 'W2WZUOU07nm7gY5fOs6XfdqIR',
    //   consumerSecret: 'IOujnkW76oqXDGQOjvfrr0QfExEUqRx9hGnjcgOiDmulXI5mhZ',
    // );

    // final TwitterLoginResult result = await twitterLogin.authorize();
    // String newMessage;

    // switch (result.status) {
    //   case TwitterLoginStatus.loggedIn:
    //     newMessage = 'Logged in! username: ${result.session.username}';
    //     break;
    //   case TwitterLoginStatus.cancelledByUser:
    //     newMessage = 'Login cancelled by user.';
    //     break;
    //   case TwitterLoginStatus.error:
    //     newMessage = 'Login error: ${result.errorMessage}';
    //     break;
    // }
    // print(result.session.username);
    // print(result.session.userId);
    // print(result.session.token);
    // print(result.session.secret);

    // setState(() {
    //   _message = newMessage;
    // });
  }
}

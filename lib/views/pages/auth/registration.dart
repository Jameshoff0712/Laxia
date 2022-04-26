import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/generated/l10n.dart';
import 'package:laxia/models/res_model.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_one.dart';
// import '../common/app_config.dart' as config;

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isBtnColor = true;
  final _con = AuthController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMsg = "";
  Future<void> registerEmail() async {
    try {
      var email = _emailController.text.trim();
      var password = _passwordController.text;
      await _con.registerEmail(email, password);
    } catch (e) {
      setState(() {
        _errorMsg = "メールアカウントの値は既に存在しています。";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.only(top: 57.0, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              padding: EdgeInsets.only(left: 7),
                              icon: const Icon(Icons.clear,
                                  color: Helper.blackColor),
                              iconSize: 16,
                            ))),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: Text(Trans.of(context).member_regirtration,
                                style: defaultTextStyle(
                                    Helper.blackColor, FontWeight.w500,
                                    size: 20)))),
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: double.infinity,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                TextFormField(
                  controller: _emailController,
                  onTap: () {
                    setState(() {
                      isBtnColor = false;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  // onSaved: (input) => _con.user.email = input,
                  validator: (email) {
                    if(email!.isEmpty) {
                      return "メールを入力してください";
                    }
                    final regex = RegExp('[^@]+@[^\.]+\..+');
                    if(!regex.hasMatch(email)) {
                      return "メールアドレスに誤りがあります。";
                    }
                    
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: Trans.of(context).input_email,
                    hintStyle:
                        TextStyle(color: Helper.authHintColor, fontSize: 14),
                    // filled: true,
                    // fillColor: Helper.whiteColor.withOpacity(0.2),
                    contentPadding:
                        EdgeInsets.only(left: 16, top: 16, bottom: 16),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Helper.mainColor.withOpacity(0.5))),
                    // hintText: 'john@doe.com',
                    // errorStyle: TextStyle(color: Helper.whiteColor.withOpacity(0.7)),
                    // errorBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                    // hintStyle: TextStyle(color: Helper.whiteColor.withOpacity(0.7)),
                    // // prefixIcon: Icon(Icons.alternate_email, color: Helper.whiteColor),
                    // border: OutlineInputBorder(
                    //   // borderRadius: BorderRadius.all(Radius.circular(100)),
                    //   borderSide: BorderSide(color: Color.fromARGB(1,210, 210, 212)),
                    // ),
                    // focusedBorder: UnderlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Color.fromARGB(1,210, 210, 212))),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Helper.authHintColor),
                    ),
                  ),
                ),
                _errorMsg != ""
                  ? SizedBox(
                      height: 40,
                      child: Text(
                        _errorMsg,
                        style: const TextStyle(color: Colors.red),
                      ))
                  : Container(),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  // onSaved: (input) => _con.user.password = input,
                  validator: (pwd) {
                    if(pwd!.isEmpty) {
                      return "パスワードを入力してください";
                    }
                    if(pwd.length < 8) {
                      return "パスワードは、英数字/記号で8文字以上必要です";
                    }
                    return null;
                  },
                  // validator: (input) => input!.length < 8 ? "パスワードは、英数字/記号で8文字以上必要です" : null,
                  obscureText: _con.hidePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Helper.whiteColor.withOpacity(0.2),
                    hintText: Trans.of(context).password,
                    hintStyle:
                        TextStyle(color: Helper.authHintColor, fontSize: 14),
                    contentPadding:
                        EdgeInsets.only(left: 16, top: 16, bottom: 16),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Helper.mainColor.withOpacity(0.5))),
                    // hintText: '••••••••••••',
                    // errorStyle: TextStyle(color: Helper.whiteColor.withOpacity(0.7)),
                    // errorBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                    // hintStyle: TextStyle(color: Helper.whiteColor.withOpacity(0.7)),
                    // prefixIcon: Icon(Icons.lock_outline, color: Helper.whiteColor),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _con.hidePassword = !_con.hidePassword;
                        });
                      },
                      color: Helper.authHintColor,
                      icon: Icon(_con.hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Helper.authHintColor),
                    ),
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                    // focusedBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.rall(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.5))),
                    // enabledBorder: OutlineInputBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/passwordResetone");
                      },
                      child: Text(
                        Trans.of(context).required_password,
                        style: TextStyle(
                            color: Helper.titleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 61, right: 61),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Helper.txtColor, width: 1),
                      elevation: 0,
                      primary: isBtnColor ? Helper.whiteColor : Helper.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 14),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              Trans.of(context).next,
                              style: TextStyle(
                                  color: isBtnColor
                                      ? Helper.txtColor
                                      : Helper.whiteColor,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (!isBtnColor){
                        _validate();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "すでにアカウントを持っている方はこちら",
                            style: TextStyle(
                                color: Helper.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          )),
                      SizedBox(
                        height: 12,
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _validate() async{
    setState(() {
      _errorMsg = "";
    });
    final form = _formKey.currentState;
    if(!form!.validate()){
        return;
    }
    await registerEmail();
    if(_errorMsg != "") return;
    Navigator.of(context).pushNamed("/SignupTwo");
  }
}

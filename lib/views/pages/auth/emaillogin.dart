import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_one.dart';
import 'package:laxia/views/dashboard.dart';
import 'package:laxia/generated/l10n.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/common/helper.dart';
import 'package:provider/provider.dart';

class EMLoginScreen extends StatefulWidget {
  const EMLoginScreen({Key? key}) : super(key: key);

  @override
  State<EMLoginScreen> createState() => _EMLoginScreenState();
}

class _EMLoginScreenState extends State<EMLoginScreen> {
  final _con = AuthController();
  final _emailController = TextEditingController(text:"patient_1@test.com");//text:"patient_1@test.com"
  final _passwordController = TextEditingController(text:"123123123");//text:"123123123"

  String _errorMsg = "";
  bool _isLoading = false;

  late UserProvider provider;

  Future<void> login(BuildContext context) async {
    try {
      var email = _emailController.text.trim();
      var password = _passwordController.text;
      await _con.authorize(email, password);
      final me = await _con.getMe();
      if (me.id != 0) {
        provider.setMe(me);
        provider.setIsAuthorized(true);
        Navigator.pushNamedAndRemoveUntil(context, "/Pages", (route) => false);
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _errorMsg = "メールアドレスもしくはパスワードが間違っています。";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: Padding(
          padding:
              const EdgeInsets.only(top: 44.0, left: 16, right: 16),
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
                          child: Text(Trans.of(context).login,
                              style: TextStyle(
                                  color:Helper.blackColor, 
                                  fontFamily: "Hiragino Kaku Gothic Pro W6",
                                  fontWeight:FontWeight.w400,
                                  height: 22/20,
                                  fontSize: 20)))),
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
                keyboardType: TextInputType.emailAddress,
                // onSaved: (input) => _con.user.email = input,
                validator: (input) {
                  if (input!.contains(new RegExp(r'^[0-9]+$'))) {
                    if (input.length < 10) {
                      return null;
                    }
                    return null;
                  }
                  if (!input.contains(RegExp(
                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
                    return null;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: Trans.of(context).input_email,
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 210, 212), 
                      fontSize: 14
                      
                      ),
                  // filled: true,
                  // fillColor: Helper.whiteColor.withOpacity(0.2),
                  contentPadding:
                      EdgeInsets.only(left: 16, top: 16, bottom: 16),
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
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Helper.mainColor.withOpacity(0.5))),
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 210, 210, 212), ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                // onSaved: (input) => _con.user.password = input,
                validator: (input) => input!.length < 3 ? null : null,
                obscureText: _con.hidePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Helper.whiteColor.withOpacity(0.2),
                  hintText: Trans.of(context).password,
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 210, 212), fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(left: 16, top: 16, bottom: 16),
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
                    color: Color.fromARGB(255, 210, 210, 212),
                    icon: Icon(_con.hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide( color: Color.fromARGB(255, 210, 210, 212), ),
                  ),
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Helper.mainColor.withOpacity(0.5))),
                  // enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _errorMsg != ""
                  ? SizedBox(
                      height: 40,
                      child: Text(
                        _errorMsg,
                        style: const TextStyle(color: Colors.red),
                      ))
                  : Container(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerRight
                  ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/passwordResetone");
                    },
                    child: Text(
                      Trans.of(context).i_forgot_password,
                      style: TextStyle(
                          color: Helper.maintxtColor,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.1,
                          fontSize: 12),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 61, right: 61),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Helper.mainColor,
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
                            Trans.of(context).go_login,
                            style: TextStyle(
                                color: Helper.whiteColor, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    login(context);
                  },
                ),
              ),
            ],
          )),
    );
  }
}

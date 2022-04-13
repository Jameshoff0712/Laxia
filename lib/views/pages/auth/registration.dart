import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/generated/l10n.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_one.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// import '../common/app_config.dart' as config;

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends StateMVC<Registration> {
  bool isBtnColor=true;
  late AuthController _con;
  _RegistrationState() : super(AuthController()) {
    _con = controller as AuthController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: Padding(
          padding:
              const EdgeInsets.only(top: 57.0, left: 16, right: 16),
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
                            icon: const Icon(Icons.clear, color: Helper.blackColor),
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
                onTap:(){
                  setState(() {
                    isBtnColor=false;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                onSaved: (input) => _con.user.email = input,
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
                      color: Helper.authHintColor, fontSize: 14),
                  // filled: true,
                  // fillColor: Helper.whiteColor.withOpacity(0.2),
                  contentPadding:
                      EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Helper.mainColor.withOpacity(0.5))),
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
                    borderSide:
                        BorderSide(color: Helper.authHintColor),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                onSaved: (input) => _con.user.password = input,
                validator: (input) => input!.length < 3 ? null : null,
                obscureText: _con.hidePassword,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Helper.whiteColor.withOpacity(0.2),
                  hintText: Trans.of(context).password,
                  hintStyle: TextStyle(
                      color: Helper.authHintColor, fontSize: 14),
                  contentPadding:
                      EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  focusedBorder: UnderlineInputBorder(
                     borderSide: BorderSide(color: Helper.mainColor.withOpacity(0.5))),
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
                    borderSide:
                        BorderSide(color: Helper.authHintColor),
                  ),
                  // border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                  // focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.5))),
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
                    elevation:0,
                    primary:isBtnColor? Helper.whiteColor: Helper.mainColor,
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
                            style: TextStyle(color:isBtnColor?Helper.txtColor: Helper.whiteColor, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if(!isBtnColor)
                      Navigator.of(context).pushNamed("/SignupTwo");
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
                      )
                    ),
                     SizedBox(height: 12,)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

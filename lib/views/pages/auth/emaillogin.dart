import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
import '../../../controllers/auth_controller.dart';
import '../../../common/helper.dart';
// import '../common/app_config.dart' as config;

class EMLoginScreen extends StatefulWidget {
  const EMLoginScreen({Key? key}) : super(key: key);

  @override
  _EMLoginScreenState createState() => _EMLoginScreenState();
}

class _EMLoginScreenState extends StateMVC<EMLoginScreen> {
  late AuthController _con;
  _EMLoginScreenState() : super(AuthController()) {
    _con = controller as AuthController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: Padding(
          padding:
              const EdgeInsets.only(top: 57.0, left: 16, right: 16, bottom: 65),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () => SystemNavigator.pop(),
                            padding: EdgeInsets.only(left: 7),
                            icon: const Icon(Icons.clear, color: Helper.blackColor),
                            iconSize: 16,
                          ))),
                  Expanded(
                      flex: 6,
                      child: Center(
                          child: Text(Trans.of(context).login,
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
                  labelText: Trans.of(context).input_email,
                  labelStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 210, 212), fontSize: 14),
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
                  // focusedBorder: UnderlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Color.fromARGB(1,210, 210, 212))),
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(1, 210, 210, 212)),
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
                  labelText: Trans.of(context).password,
                  labelStyle: TextStyle(
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
                        BorderSide(color: Color.fromARGB(1, 210, 210, 212)),
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
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/passwordResetone");
                    },
                    child: Text(
                      Trans.of(context).i_forgot_password,
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
                    primary: Helper.loginButtonColor,
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
                            style: TextStyle(color: Helper.whiteColor, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/Pages");
                  },
                ),
              ),
            ],
          )),
    );
  }
}

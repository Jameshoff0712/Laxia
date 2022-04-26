import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/generated/l10n.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_two.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// import '../common/app_config.dart' as config;
import './passrest_three.dart';

class PassRest_One extends StatefulWidget {
  const PassRest_One({Key? key}) : super(key: key);

  @override
  _PassRest_OneState createState() => _PassRest_OneState();
}

class _PassRest_OneState extends State<PassRest_One> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _con = AuthController();
  String _errorMsg = "";
  Future<void> sendEmail() async {
    try {
      var email = _emailController.text.trim();
      await _con.sendEmail(email);
    } catch (e) {
      setState(() {
        _errorMsg = "メールアドレスに一致するユーザーは存在していません。";
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
            padding: const EdgeInsets.only(
                top: 57.0, left: 16, right: 16, bottom: 65),
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
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Helper.blackColor),
                              iconSize: 16,
                            ))),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: Text(Trans.of(context).reset_password,
                                style: defaultTextStyle(
                                    Helper.blackColor, FontWeight.w700,
                                    size: 20)))),
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: double.infinity,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 27,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: Trans.of(context).input_email_then_help,
                        style: TextStyle(
                            color: Helper.maintxtColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14)),
                  ]),
                ),
                const SizedBox(
                  height: 27,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  // onSaved: (input) => _con.user.email = input,
                  // validator: (input) {
                  //   if (input!.contains(new RegExp(r'^[0-9]+$'))) {
                  //     if (input.length < 10) {
                  //       return null;
                  //     }
                  //     return null;
                  //   }
                  //   if (!input.contains(RegExp(
                  //       r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
                  //     return null;
                  //   }
                  //   return null;
                  // },
                  validator: (email) {
                    if (email!.isEmpty) {
                      return "メールを入力してください";
                    }
                    final regex = RegExp('[^@]+@[^\.]+\..+');
                    if (!regex.hasMatch(email)) {
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
                        borderSide: BorderSide(
                            color: Helper.mainColor.withOpacity(0.5))),
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
                          BorderSide(color: Color.fromARGB(255, 210, 210, 212)),
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
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 61, right: 61),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Helper.btnBgMainColor,
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
                              Trans.of(context).send_url_for_reset,
                              style: TextStyle(
                                  color: Helper.whiteColor, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _validate();
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _validate() async {
    setState(() {
      _errorMsg = "";
    });
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }
    await sendEmail();
    if (_errorMsg != "") return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PassRest_Two()),
    );
  }
}

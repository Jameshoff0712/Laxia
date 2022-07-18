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
  bool isPassNotEmpty = false;
  bool isEmailNotEmpty = false;
  bool isPassError = false;
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
                              iconSize: 25,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ))),
                    Expanded(
                        flex: 6,
                        child: Center(
                            child: Text('会員登録',
                                style: TextStyle(
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    height: 1.5)))),
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
                Stack(children: [
                  TextFormField(
                    controller: _emailController,
                    // onTap: () {
                    //   setState(() {
                    //     isBtnColor = false;
                    //   });
                    // },
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Helper.mainColor,
                    // onSaved: (input) => _con.user.email = input,
                    validator: (email) {
                      // if (email!.isEmpty) {
                      //   return "メールを入力してください";
                      // }
                      final regex = RegExp('[^@]+@[^\.]+\..+');
                      if (!regex.hasMatch(email!) || email.isEmpty) {
                        return "メールアドレスに誤りがあります。";
                      }

                      return null;
                    },
                    onChanged: (email) {
                        if (email.isEmpty)
                          setState(() {
                            isEmailNotEmpty = false;
                          });
                        else
                          setState(() {
                            isEmailNotEmpty = true;
                          });

                        if( _emailController.text != '' && _passwordController.text != '')
                          setState(() {
                            isBtnColor = false;
                          });
                        else
                          setState(() {
                            isBtnColor = true;
                          });
                      },
                    decoration: InputDecoration(
                      hintText: Trans.of(context).input_email,
                      hintStyle: TextStyle(
                        color: Helper.authHintColor,
                        fontSize: 14,
                      ),
                      // filled: true,
                      // fillColor: Helper.whiteColor.withOpacity(0.2),
                      contentPadding:
                          EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      // errorBorder: UnderlineInputBorder(
                      //   borderSide:
                      //       BorderSide(color: Colors.orange, width: 1),
                      // ),
                      // errorStyle: _focusNode.hasFocus ? TextStyle(fontSize: 0, height: 0) : null,
                      focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 235, 87, 87)),
                        ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Helper.mainColor, width: 1)),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Helper.authHintColor, width: 1),
                      ),
                      
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Helper.authHintColor, width: 1)),
                    ),
                  ),

                  isEmailNotEmpty
                        ? Positioned(
                            top: 20,
                            right: 15,
                            child: GestureDetector(
                              onTap: () {
                                _emailController.text = '';
                                setState(() {
                                  isEmailNotEmpty = false;
                                });
                                if( _emailController.text != '' && _passwordController.text != '')
                                  setState(() {
                                    isBtnColor = false;
                                  });
                                else
                                  setState(() {
                                    isBtnColor = true;
                                  });
                              },
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 210, 210, 212),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(Icons.close,
                                    color: Colors.white, size: 15),
                              ),
                            ),
                          )
                        : Container(),
                ]),
                _errorMsg != ""
                    ? SizedBox(
                        height: 40,
                        child: Text(
                          _errorMsg,
                          // style: const TextStyle(color: Colors.blue),
                          style: const TextStyle(color: Color.fromARGB(255, 235, 87, 87)),
                        ))
                    : Container(),
                // SizedBox(height: 20),
                Stack(
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: Helper.mainColor,
                      // onSaved: (input) => _con.user.password = input,
                      validator: (pwd) {
                        // if (pwd!.isEmpty) {
                        //   return "パスワードを入力してください";
                        // }
                        if (pwd!.length < 8 || pwd.isEmpty) {
                          setState(() {
                            isPassError = true;
                          });
                          return 'パスワードは、英数字/記号で8文字以上必要です';
                        }
                        return null;
                      },
                      onChanged: (pwd) {
                        if (pwd.isEmpty)
                          setState(() {
                            isPassNotEmpty = false;
                          });
                        else
                          setState(() {
                            isPassNotEmpty = true;
                          });

                        if( _emailController.text != '' && _passwordController.text != '')
                          setState(() {
                            isBtnColor = false;
                          });
                        else
                          setState(() {
                            isBtnColor = true;
                          });
                      },
                      // validator: (input) => input!.length < 8 ? "パスワードは、英数字/記号で8文字以上必要です" : null,
                      obscureText: _con.hidePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Helper.whiteColor.withOpacity(0.2),
                        hintText: Trans.of(context).password,
                        hintStyle: TextStyle(
                            color: Helper.authHintColor, fontSize: 14),
                        contentPadding:
                            EdgeInsets.only(left: 16, top: 16, bottom: 16),
                        errorBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 235, 87, 87), width: 1),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 235, 87, 87)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Helper.mainColor, width: 1)),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Helper.authHintColor, width: 1),
                        ),
                        
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Helper.authHintColor, width: 1)),
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
                          color: _con.hidePassword
                              ? Helper.titleColor
                              : Helper.authHintColor,
                          icon: Icon(_con.hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                        // focusedBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.rall(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.5))),
                        // enabledBorder: OutlineInputBorder(
                        //     borderRadius: BorderRadius.all(Radius.circular(100)), borderSide: BorderSide(color: Helper.whiteColor.withOpacity(0.2))),
                      ),
                    ),
                    isPassNotEmpty
                        ? Positioned(
                            top: 20,
                            right: 45,
                            child: GestureDetector(
                              onTap: () {
                                _passwordController.text = '';
                                setState(() {
                                  isPassNotEmpty = false;
                                });
                                if( _emailController.text != '' && _passwordController.text != '')
                                  setState(() {
                                    isBtnColor = false;
                                  });
                                else
                                  setState(() {
                                    isBtnColor = true;
                                  });
                              },
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 210, 210, 212),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(Icons.close,
                                    color: Colors.white, size: 15),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                !isPassError ?Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                          Trans.of(context).required_password,
                          style: TextStyle(
                              color: Helper.titleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                  )
                  // child: TextButton(
                  //     onPressed: () {
                  //       Navigator.of(context).pushNamed("/passwordResetone");
                  //     },
                  //     style: ButtonStyle(
                  //       splashFactory: NoSplash.splashFactory,
                  //     ),
                  //     child: Text(
                  //       Trans.of(context).required_password,
                  //       style: TextStyle(
                  //           color: Helper.titleColor,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 12),
                  //     )),
                ) : SizedBox(width: 0,),
                SizedBox(
                  height: 22,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, left: 61, right: 61),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero, // Set this
                      padding: EdgeInsets.zero, // and this
                      side: BorderSide(
                          color:
                              isBtnColor ? Helper.txtColor : Helper.mainColor,
                          width: 1),
                      elevation: 0,
                      primary:
                          isBtnColor ? Helper.whiteColor : Helper.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      splashFactory: NoSplash.splashFactory,
                      shadowColor: Colors.transparent,
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (!isBtnColor) {
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
                          style: ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Text(
                            "すでにアカウントを持っている方はこちら",
                            style: TextStyle(
                                color: Helper.mainColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                height: 1.5),
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

  void _validate() async {
    setState(() {
      _errorMsg = "";
    });
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }
    await registerEmail();
    if (_errorMsg != "") return;
    Navigator.of(context).pushNamed("/SignupTwo");
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Helper.whiteColor,
        leading: IconButton(
          onPressed: () => SystemNavigator.pop(),
          padding: EdgeInsets.only(left: 7),
          icon: const Icon(Icons.clear, color: Helper.titleColor),
          iconSize: 28,
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
        ),
        shadowColor: Helper.whiteColor,
      ),
      backgroundColor: Helper.whiteColor,
      body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 53,
              ),
              Text(
                Trans.of(context).login_content,
                style: TextStyle(
                    fontFamily: 'Hiragino Kaku Gothic Pro W6',
                    color: Helper.titleColor,
                    fontWeight: FontWeight.w400,
                    height: 18 / 20,
                    letterSpacing: -0.34,
                    fontSize: 20),
              ),
              SizedBox(
                height: 19,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  Trans.of(context).lets_start_with_login,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Helper.blackColor,
                      fontWeight: FontWeight.w400,
                      height: 25 / 16,
                      letterSpacing: -1.2,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  children: [
                    LoginButton(
                      name: Trans.of(context).email,
                      icon: Icons.email_outlined,
                      event: 'email',
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    LoginButton(
                      event: 'apple',
                      name: "Apple" + Trans.of(context).continues,
                      icon: Icons.apple,
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TwitterButton(
                        name: "Twitter" + Trans.of(context).continues,
                        icon: Icons.man),
                    const SizedBox(
                      height: 11,
                    ),
                    LoginButton(
                        name: "Facebook" + Trans.of(context).continues,
                        icon: Icons.facebook,
                        color: Colors.blue)
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Color.fromARGB(
                      255,
                      239, 242, 245
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50, top: 33),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "まだアカウントをお持ちでないですか？",
                            style: TextStyle(
                                color: Helper.blackColor,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -1.2,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed("/Signup");
                            },
                            child: Text(
                              Trans.of(context).register,
                              style: TextStyle(
                                  color: Helper.mainColor,
                                  fontFamily: Helper.headFontFamily,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.34,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class LoginButton extends StatelessWidget {
  String event;
  String name;
  IconData icon;
  MaterialColor? color;
  LoginButton(
      {Key? key,
      required this.name,
      required this.icon,
      this.color,
      this.event = "default"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (event == "email") Navigator.of(context).pushNamed("/EmailLogin");
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Helper.txtColor, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Helper.blackColor,
                size: 26,
              ),
              Text(
                "   " + name,
                style: defaultTextStyle(Helper.blackColor, FontWeight.w400,
                    size: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TwitterButton extends StatelessWidget {
  String name;
  IconData icon;
  MaterialColor? color;
  TwitterButton({Key? key, required this.name, required this.icon, this.color})
      : super(key: key);


@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Helper.txtColor, width: 1),
            borderRadius: BorderRadius.circular(5.0),
          ),
        child: Padding(
          padding: EdgeInsets.only(top: 12, bottom: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/twitter.svg",
                width: 24,
                height: 19,
              ),
              Text(
                "   " + name,
                style: defaultTextStyle(Helper.blackColor, FontWeight.w400,
                    size: 14),
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}

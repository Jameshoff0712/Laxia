import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          iconSize: 16,
        ),
        shadowColor: Helper.whiteColor,
      ),
      backgroundColor: Helper.whiteColor,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 53,
                ),
                Text(
                  Trans.of(context).login_content,
                  style: TextStyle(
                      color: Helper.titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 19,
                ),
                Text(
                  Trans.of(context).lets_start_with_login,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Helper.titleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 64,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: [
                      LoginButton(
                        name: Trans.of(context).email,
                        icon: Icons.email_outlined,
                        event: 'email',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      LoginButton(
                        event: 'apple',
                        name: "Apple" + Trans.of(context).continues,
                        icon: Icons.apple,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TwitterButton(
                          name: "Twitter" + Trans.of(context).continues,
                          icon: Icons.man),
                      const SizedBox(
                        height: 15,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Trans.of(context).i_forgot_password),
                        SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/Signup");
                            },
                            child: Text(
                              Trans.of(context).register,
                              style: defaultTextStyle(
                                  Colors.blue, FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Helper.txtColor, width: 1),
        elevation: 0,
        primary: Helper.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12, bottom: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color ?? Helper.blackColor,
              size: 30,
            ),
            Text(
              "   " + name,
              style: defaultTextStyle(Helper.blackColor, FontWeight.w700,
                  size: 14),
            ),
          ],
        ),
      ),
      onPressed: () {
        if (event == "email") Navigator.of(context).pushNamed("/EmailLogin");
      },
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Helper.txtColor, width: 1),
        elevation: 0,
        primary: Helper.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
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
              style: defaultTextStyle(Helper.blackColor, FontWeight.w700,
                  size: 14),
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}

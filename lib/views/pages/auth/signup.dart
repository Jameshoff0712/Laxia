import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/pages/auth/login.dart';
import 'package:laxia/views/pages/auth/registration.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../generated/l10n.dart';
// import '../controllers/auth_controller.dart';
import '../../../common/helper.dart';
// import '../common/app_config.dart' as config;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AddCounselStep2Page() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("下書きに保存しますか？"),
          content: Text("まだ投稿が完了しておりません。\n戻ると入力内容が消えてしまいます。",
              style: TextStyle(fontSize: 14)),
          buttonPadding: EdgeInsets.all(0),
          actions: <Widget>[
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Helper.txtColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1,
                      height: 40,
                      color: Helper.whiteColor,
                    ),
                    new FlatButton(
                      textColor: Color.fromARGB(255, 110, 198, 210),
                      child: new Text('保存しない'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Helper.txtColor,
                    ),
                    new FlatButton(
                      textColor: Color.fromARGB(255, 110, 198, 210),
                      child: new Text('保存する'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Helper.whiteColor,
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Helper.whiteColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
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
                  height: 23,
                ),
                Text(
                  Trans.of(context).signup_contents,
                  style: TextStyle(
                      color: Helper.titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 19,
                ),
                Text(
                  Trans.of(context).lets_start_with_signup,
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
                      LoginButton(Trans.of(context).email, Icons.email_outlined,
                          'email'),
                      const SizedBox(
                        height: 15,
                      ),
                      LoginButton(
                        "Apple" + Trans.of(context).continues,
                        Icons.apple,
                        "apple",
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
                        "Facebook" + Trans.of(context).continues,
                        Icons.facebook,
                        "facebook",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text: Trans.of(context).by_continue,
                            style: TextStyle(
                                color: Helper.blackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          TextSpan(
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .pushNamed("/TermsOfService");
                                },
                              text: Trans.of(context).service_term,
                              style: TextStyle(
                                  color: Helper.mainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                          TextSpan(
                              text: Trans.of(context).agree_to,
                              style: TextStyle(
                                  color: Helper.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                          TextSpan(
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .pushNamed("/TermsOfService");
                                },
                              text: Trans.of(context).privacy + "\n",
                              style: TextStyle(
                                  color: Helper.mainColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                          TextSpan(
                              text: Trans.of(context).agree_policy,
                              style: TextStyle(
                                  color: Helper.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12)),
                        ]),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Trans.of(context).do_have_account,
                              style: TextStyle(
                                  color: Helper.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  Trans.of(context).login,
                                  style: TextStyle(
                                      color: Helper.mainColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget LoginButton(String name, IconData icon, String event) {
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
              color: event == "facebook" ? Colors.blue : Helper.blackColor,
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
        if (event == "email")
          Navigator.of(context).pushNamed("/Registration");
        else if (event == "apple") {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 4 / 9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "サインイン",
                                style: defaultTextStyle(
                                    Helper.blackColor, FontWeight.w700,
                                    size: 14),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "キャンセル",
                                style: defaultTextStyle(
                                    Helper.blackColor, FontWeight.w700,
                                    size: 14),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            )),
                        SizedBox(
                          height: 31,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Apple ID “sample@gmail.com”を使用して”LAXIA”のアカウントを作成してください",
                            style: defaultTextStyle(
                                Helper.titleColor, FontWeight.w400,
                                size: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        } else {
          AddCounselStep2Page();
        }
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

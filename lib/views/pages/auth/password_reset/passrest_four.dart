import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/generated/L10n.dart';
// import '../common/app_config.dart' as config;

class PassRest_Four extends StatefulWidget {
  const PassRest_Four({Key? key}) : super(key: key);

  @override
  _PassRest_FourState createState() => _PassRest_FourState();
}

class _PassRest_FourState extends State<PassRest_Four> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.only(top: 124.42),
          child: Column(
            children: <Widget>[
              Center(
                  child: SvgPicture.asset(
                "images/check_mail.svg",
                width: 54.17,
                height: 54.17,
              )),
              SizedBox(
                height: 30.83,
              ),
              Center(
                  child: Text(Trans.of(context).complete_reset,
                      style: defaultTextStyle(
                          Color.fromARGB(255, 110, 198, 210), FontWeight.w700,
                          size: 18))),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(Trans.of(context).reset_password_end,
                      style: defaultTextStyle(
                          Color.fromARGB(255, 156, 161, 161), FontWeight.w700,
                          size: 14))),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 61, right: 61),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 110, 198, 210),
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
                            Trans.of(context).login,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/EmailLogin");
                  },
                ),
              ),
            ],
          )),
    );
  }
}

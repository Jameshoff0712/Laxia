import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uni_links/uni_links.dart';
import '../../../../generated/l10n.dart';
import '../../../../common/helper.dart';
// import '../common/app_config.dart' as config;

class PassRest_Two extends StatefulWidget {
  const PassRest_Two({Key? key}) : super(key: key);

  @override
  _PassRest_TwoState createState() => _PassRest_TwoState();
}

class _PassRest_TwoState extends State<PassRest_Two> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: Padding(
          padding: const EdgeInsets.only(top: 129.83, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Center(
                  child: SvgPicture.asset(
                "assets/images/send_mail.svg",
                width: 54.17,
                height: 43.33,
              )),
              SizedBox(
                height: 30.83,
              ),
              Center(
                  child: Text(Trans.of(context).send_email_success,
                      style: defaultTextStyle(
                          Helper.btnBgMainColor, FontWeight.w700,
                          size: 18))),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeepLink()),
                  );
                },
                child: Text(Trans.of(context).verify_email,
                    style: defaultTextStyle(
                        Helper.maintxtColor, FontWeight.w700,
                        size: 14)),
              )),
            ],
          )),
    );
  }
}

class DeepLink extends StatefulWidget {
  DeepLink({Key? key}) : super(key: key);

  @override
  _DeepLinkState createState() => _DeepLinkState();
}

class _DeepLinkState extends State<DeepLink> {
  String link = "";

  @override
  void initState() {
    initUniLinks().then((value) => this.setState(() {
          link = value!;
        }));
    super.initState();
  }

  Future<String?> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      return initialLink;
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
      //log(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deep Linking"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(link == null ? "" : link),
          ],
        ),
      ),
    );
  }
}

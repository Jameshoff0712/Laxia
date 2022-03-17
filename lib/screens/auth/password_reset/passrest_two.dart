import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../generated/l10n.dart';
import '../../../common/helper.dart';
// import '../common/app_config.dart' as config;

class PassRest_Two extends StatefulWidget {
  const PassRest_Two({ Key? key }) : super(key: key);

  @override
  _PassRest_TwoState createState() => _PassRest_TwoState();
}

class _PassRest_TwoState extends State<PassRest_Two> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 129.83,left: 10,right: 10),
        child:Column(
          children: <Widget>[
             Center(child: SvgPicture.asset("images/send_mail.svg",width: 54.17,height: 43.33,)),
             SizedBox(height: 30.83,),
             Center(child: Text(Trans.of(context).send_email_success,style: defaultTextStyle(Color.fromARGB(255,110, 198, 210), FontWeight.w700,size:18))),
             SizedBox(height: 20,),
             Center(child: Text(Trans.of(context).verify_email,style: defaultTextStyle(Color.fromARGB(255,156, 161, 161), FontWeight.w700,size:14))),
          ],
        )
      ),
    );
  }
}

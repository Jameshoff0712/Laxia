import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/screens/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../generated/l10n.dart';
import '../controllers/auth_controller.dart';
import '../common/helper.dart';
// import '../common/app_config.dart' as config;

class EMLoginScreen extends StatefulWidget {
  const EMLoginScreen({ Key? key }) : super(key: key);

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 57.0,left: 16,right: 16,bottom: 65),
        child:Column(
          children: <Widget>[
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(onPressed: ()=>SystemNavigator.pop(),padding: EdgeInsets.only(left: 7), icon: const Icon(Icons.clear,color: Colors.black),iconSize: 16,),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(text: Trans.of(context).login,style: defaultTextStyle(Colors.black, FontWeight.w500,size:20)),
                  ]),
                ),
              ],
            ),    
            const SizedBox(height: 98,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(text: Trans.of(context).login_content,style: defaultTextStyle(Colors.black, FontWeight.w500,size:20)),
                TextSpan(text: "\n",style: defaultTextStyle(Colors.white, FontWeight.bold,size:20)),
                TextSpan(text: Trans.of(context).lets_start_with_login,style: defaultTextStyle(Colors.black, FontWeight.w500,size:16)),
              ]),
            ),
            const SizedBox(height: 64,),
            Container(
              padding: EdgeInsets.only(left: 16,right: 16),
              child: Column(
                children: [
                  LoginButton(name: Trans.of(context).email, icon: Icons.email_outlined,event: 'email',),
                  const SizedBox(height: 15,),
                  LoginButton(name: "Apple"+ Trans.of(context).continues ,icon: Icons.apple,),
                  const SizedBox(height: 15,),
                  TwitterButton(name: "Twitter"+Trans.of(context).continues,icon: Icons.man),
                  const SizedBox(height: 15,),
                  LoginButton(name: "Facebook"+Trans.of(context).continues,icon: Icons.facebook,color:Colors.blue)
                ],
              ),
            ),
            Expanded(
              child:
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Trans.of(context).i_forgot_password),
                      SizedBox(width: 8,),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                      }, child:Text(Trans.of(context).register,style:defaultTextStyle(Colors.blue, FontWeight.bold),)
                      )
                    ],
                  ),
                ),
            )
          ],
        )
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  String  event;
  String name;
  IconData icon;
  MaterialColor ? color;
  LoginButton({
    Key? key,required this.name,required this.icon, this.color, this.event="default"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12,bottom: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color ?? Colors.black,
              size: 30,
            ),
            Text(
              "   "+name,
              style: defaultTextStyle(Colors.black, FontWeight.w700,size: 14),
            ),                  
          ],
        ),),
        onPressed: () {
          if(event=="email")
          ;
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            
        },
      
    );
  }
}

class TwitterButton extends StatelessWidget {
  String name;
  IconData icon;
  MaterialColor ? color;
  TwitterButton({
    Key? key,required this.name,required this.icon, this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12,bottom: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/twitter.svg",width: 24,height: 19,),
            Text(
              "   "+name,
              style: defaultTextStyle(Colors.black, FontWeight.w700,size: 14),
            ),                  
          ],
        ),),
        onPressed: () {},
      
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:laxia/screens/signup.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
import '../generated/l10n.dart';
// import '../controllers/auth_controller.dart';
import '../common/helper.dart';
// import '../common/app_config.dart' as config;

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0,right: 10,bottom: 35,left: 10),
        child:Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(onPressed: ()=>SystemNavigator.pop(), icon: const Icon(Icons.clear,color: Colors.black,),label: Text(""),),
              ),
              const SizedBox(height: 100,),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(text: Trans.of(context).login_content,style: defaultTextStyle(Colors.black, FontWeight.w500,size:30)),
                  TextSpan(text: Trans.of(context).lets_start_with_login,style: defaultTextStyle(Colors.black, FontWeight.w500,size:18)),
                ]),
              ),
              const SizedBox(height: 80,),
              LoginButton(name: Trans.of(context).email, icon: Icons.email_outlined,),
              const SizedBox(height: 20,),
              LoginButton(name: "Apple"+ Trans.of(context).continues ,icon: Icons.apple,),
              const SizedBox(height: 20,),
              LoginButton(name: "Twitter"+Trans.of(context).continues,icon: Icons.man),
              const SizedBox(height: 20,),
              LoginButton(name: "Facebook"+Trans.of(context).continues,icon: Icons.facebook,color:Colors.blue),
              Expanded(
                child:
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(Trans.of(context).i_forgot_password),
                        SizedBox(width: 10,),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                        }, child:Text(Trans.of(context).register,style:defaultTextStyle(Colors.blue, FontWeight.bold),)
                        )
                      ],
                    ),
                  ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  String name;
  IconData icon;
  MaterialColor ? color;
  LoginButton({
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
        padding: EdgeInsets.all(10),
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
              style: defaultTextStyle(Colors.black, FontWeight.w700,size: 15),
            ),                  
          ],
        ),),
        onPressed: () {},
      
    );
  }
}
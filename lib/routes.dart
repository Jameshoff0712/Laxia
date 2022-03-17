
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laxia/screens/emaillogin.dart';
import 'package:laxia/screens/login.dart';
import 'package:laxia/screens/onboarding.dart';
import 'package:laxia/screens/signup.dart';
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args=settings.arguments;
    switch(settings.name){
      case '/Login':
        return MaterialPageRoute(builder: (_)=>LoginScreen());
      case '/Splash':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/Signup':
        return  MaterialPageRoute(builder: (_)=>SignUpScreen());
      default:
        return MaterialPageRoute(builder: (_)=>EMLoginScreen());
    }
  }
}
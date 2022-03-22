import 'package:flutter/material.dart';
import 'package:laxia/views/pages/main/favorite/favorite.dart';
import 'package:laxia/views/pages/main/mypage/mypage.dart';
import 'package:laxia/views/pages/auth/emaillogin.dart';
import 'package:laxia/views/pages/auth/login.dart';
import 'package:laxia/views/dashboard.dart';
import 'package:laxia/views/pages/main/appointment/appointment.dart';
import 'package:laxia/views/pages/main/home/home.dart';
import 'package:laxia/views/onboarding.dart';
import 'package:laxia/views/pages/auth/signup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/Splash':
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case '/Signup':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/Appointment':
        return MaterialPageRoute(builder: (_) => Appointment());
      case '/Favorite':
        return MaterialPageRoute(builder: (_) => Favorite());
      case '/Mypage':
        return MaterialPageRoute(builder: (_) => Mypage());
      default:
        return MaterialPageRoute(builder: (_) => EMLoginScreen());
    }
  }
}

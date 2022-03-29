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
import 'package:laxia/views/pages/main/contribution/diary_list.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step1.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step2.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step3.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step4.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step5.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_progress.dart';
import 'package:laxia/views/pages/main/contribution/counsel_list.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step1.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step2.dart';

import 'package:laxia/views/pages/main/contribution/question.dart';

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
      case '/AddDiaryList':
        return MaterialPageRoute(builder: (_) => DiaryPage());
      case '/AddDiaryStep1':
        return MaterialPageRoute(builder: (_) => AddDiaryStep1Page());
      case '/AddDiaryStep2':
        return MaterialPageRoute(builder: (_) => AddDiaryStep2Page());
      case '/AddDiaryStep3':
        return MaterialPageRoute(builder: (_) => AddDiaryStep3Page());
      case '/AddDiaryStep4':
        return MaterialPageRoute(builder: (_) => AddDiaryStep4Page());
      case '/AddDiaryStep5':
        return MaterialPageRoute(builder: (_) => AddDiaryStep5Page());
      case '/AddDiaryProgress':
        return MaterialPageRoute(builder: (_) => AddDiaryProgressPage());
      case '/AddCounselList':
        return MaterialPageRoute(builder: (_) => AddCounselPage());
      case '/AddCounselStep1':
        return MaterialPageRoute(builder: (_) => AddCounselStep1Page());
      case '/AddCounselStep2':
        return MaterialPageRoute(builder: (_) => AddCounselStep2Page());
      case '/AddQuestion':
        return MaterialPageRoute(builder: (_) => AddQuestion());
      default:
        return MaterialPageRoute(builder: (_) => EMLoginScreen());
    }
  }
}

import 'package:laxia/bloc.dart';
import 'package:flutter/material.dart';
import 'package:laxia/poc.dart';
import 'package:laxia/views/onboarding.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';

void main() => runApp(PocApp());

class PocApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = DeepLinkBloc();
    return MaterialApp(
        title: 'Flutter and Deep Linsk PoC',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              subtitle1: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.blue,
                fontSize: 25.0,
              ),
            )),
        home: Scaffold(
            body: Provider<DeepLinkBloc>(
                create: (context) => _bloc,
                dispose: (context, bloc) => bloc.dispose(),
                child: PocWidget(MidScreen: OnBoardingScreen(),))));
  }
}

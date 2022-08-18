import 'package:flutter/material.dart';
import 'package:laxia/views/onboarding.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_three.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';

class PocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeepLinkBloc _bloc = Provider.of<DeepLinkBloc>(context);
    return StreamBuilder<String>(
      stream: _bloc.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return OnBoardingScreen();
        } else {
          return PassRest_Three(val: snapshot.data!.split('?')[1]);
        }
      },
    );
  }
}

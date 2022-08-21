import 'package:flutter/material.dart';
import 'package:laxia/views/onboarding.dart';
import 'package:laxia/views/pages/auth/password_reset/passrest_three.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';
class PocWidget extends StatefulWidget {
  final StatefulWidget MidScreen;
  const PocWidget({ Key? key, required this.MidScreen }) : super(key: key);

  @override
  State<PocWidget> createState() => _PocWidgetState();
}

class _PocWidgetState extends State<PocWidget> {
  late DeepLinkBloc _bloc;
  @override
  void dispose(){
    _bloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     _bloc= Provider.of<DeepLinkBloc>(context);
    return StreamBuilder<String>(
      stream: _bloc.state,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return widget.MidScreen;
        } else {
          return PassRest_Three(val: snapshot.data!.split('?')[1]);
        }
      },
    );
  }
}
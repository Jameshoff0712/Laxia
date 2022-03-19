import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/widgets/SearchBarWidget.dart';

import '../common/helper.dart';
import '../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  const HomeScreen({ Key? key, this.parentScaffoldKey }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Helper.mainColor,
    ));
    return Scaffold(
      body: homeSearchBar(context),
    );
  }

  Widget homeSearchBar(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 44,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: Colors.white,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: SearchBarWidget(
                      onClickFilter: (event) {
                        widget.parentScaffoldKey!.currentState!.openEndDrawer();
                      },
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/widgets/SearchBarWidget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../common/helper.dart';
import '../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  const HomeScreen({ Key? key, this.parentScaffoldKey }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabMenus = [
    'ホーム',
    'メニュー',
    'クリニック',
    'ドクター',
    '日記',
    '症例',
    'カウセレポ',
    '質問',
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Helper.mainColor,
    ));
    // return Scaffold(
    //   body: homeSearchBar(context),
    // );
    return homeTabBar(context);
  }

  Widget homeSearchBar(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: Colors.red,
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

  Widget homeTabBar(BuildContext context) {
    return DefaultTabController(
      length: tabMenus.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          flexibleSpace: homeSearchBar(context),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(78),
            child: TabBar(
              padding: EdgeInsets.only(left: 9, top: 0, right: 16, bottom: 3),
              labelPadding: EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 8),
              labelColor: Color.fromARGB(255, 18, 18, 18),
              unselectedLabelColor: Color.fromARGB(255, 156, 161, 161),
              indicatorColor: Color.fromARGB(255, 110, 198, 210),
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.only(bottom: -1, left: 4, right: 4),
              
              isScrollable: true,
              tabs: [
                for (final tabMenu in tabMenus) 
                  _buildTab(tabMenu),
              ],
            ),
          ),
        ),
        
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (final tabMenu in tabMenus)
              Center(
                child: Text(tabMenu),
              ),
          ],
        ),
      ),
    );
  }

  Tab _buildTab(String tabMenu) {
    return Tab(
      height: 18,
      child: Text(
        tabMenu,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
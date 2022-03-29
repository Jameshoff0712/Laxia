import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/home/search/searchresult.dart';
import 'package:laxia/views/pages/main/home/sub/home_case.dart';
import 'package:laxia/views/pages/main/home/sub/home_clinic.dart';
import 'package:laxia/views/pages/main/home/sub/home_counseling.dart';
import 'package:laxia/views/pages/main/home/sub/home_diary.dart';
import 'package:laxia/views/pages/main/home/sub/home_doctor.dart';
import 'package:laxia/views/pages/main/home/sub/home_menu.dart';
import 'package:laxia/views/pages/main/home/sub/home_question.dart';
import 'package:laxia/views/pages/main/home/sub/home_sub.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  const HomeScreen({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> tabMenus = [
    'ホーム',
    'メニュー',
    'クリニック',
    'ドクター',
    '日記',
    '症例',
    'カウセレポ',
    '質問',
  ];
  late TabController _tabController;
  List searchResult = [];
  Future<void> initSettings() async {
    String countyText =
        await rootBundle.loadString("assets/cfg/searchresult.json");
    setState(() {
      searchResult = json.decode(countyText);
    });
  }

  @override
  void initState() {
    _tabController = new TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    tabMenus[0]="ホーム";
    if (userProperties.searchtext != "") {
      tabMenus[0]="総合";
      initSettings();
    }
    TextEditingController filter = new TextEditingController(text: userProperties.searchtext);
    return Container(
        child: Column(
      children: [
        SizedBox(height: 44),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SearchbarWidget(
            state: true,
            filter: filter,
          ),
        ),
        TabBarWidget(
          tabMenus: tabMenus,
          tabController: _tabController,
        ),
        searchResult.isEmpty
            ? Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Home_Sub(),
                    Home_Menu(issearch: false,),
                    Home_Clinic(issearch: false,),
                    Home_Doctor(issearch: false,),
                    Home_Diary(issearch: false,),
                    Home_Case(issearch: false,),
                    Home_Counseling(issearch: false,),
                    Home_Question(issearch: false,),
                  ],
                  controller: _tabController,
                ),
              )
            : Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                   SearchResultAll(model:searchResult),
                    Home_Menu(issearch: true,model: searchResult[0],),
                    Home_Clinic(issearch: true,model: searchResult[1],),
                    Home_Doctor(issearch: true,model: searchResult[2],),
                    Home_Diary(issearch: true,model: searchResult[3],),
                    Home_Case(issearch: true,model: searchResult[4],),
                    Home_Counseling(issearch: true,model: searchResult[5],),
                    Home_Question(issearch: true,model: searchResult[6],),
                  ],
                  controller: _tabController,
                ),
              ),
      ],
    ));
  }
}

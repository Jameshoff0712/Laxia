import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/favorite/favorite_case.dart';
import 'package:laxia/views/pages/main/favorite/favorite_clinic.dart';
import 'package:laxia/views/pages/main/favorite/favorite_counseling.dart';
import 'package:laxia/views/pages/main/favorite/favorite_diary.dart';
import 'package:laxia/views/pages/main/favorite/favorite_doctor.dart';
import 'package:laxia/views/pages/main/favorite/favorite_menu.dart';
import 'package:laxia/views/pages/main/favorite/favorite_question.dart';
import 'package:laxia/views/pages/main/home/sub/home_case.dart';
import 'package:laxia/views/pages/main/home/sub/home_clinic.dart';
import 'package:laxia/views/pages/main/home/sub/home_counseling.dart';
import 'package:laxia/views/pages/main/home/sub/home_diary.dart';
import 'package:laxia/views/pages/main/home/sub/home_doctor.dart';
import 'package:laxia/views/pages/main/home/sub/home_menu.dart';
import 'package:laxia/views/pages/main/home/sub/home_question.dart';
import 'package:laxia/views/widgets/tabbar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  List<String> tabMenus = [
    'メニュー',
    'クリニック',
    'ドクター',
    '日記',
    '症例',
    'カウセレポ',
    '質問',
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: tabMenus.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'お気に入り',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.5,
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(color: Colors.white)),
            child: TabBarWidget(
              tabMenus: tabMenus,
              tabController: _tabController,
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Favorite_Menu(),
                Favorite_Clinic(),
                Favorite_Doctor(),
                Favorite_Diary(),
                Favorite_Case(),
                Favorite_Counseling(),
                Favorite_Question(),
              ],
              controller: _tabController,
            ),
          )
        ],
      ),
    );
  }
}

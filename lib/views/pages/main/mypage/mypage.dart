import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/generated/L10n.dart';
import 'package:laxia/models/m_user.dart';
import 'package:laxia/views/pages/main/mypage/diary_card_widget.dart';
import 'package:laxia/views/pages/main/mypage/fix_profile_page.dart';
import 'package:laxia/views/pages/main/mypage/follower_list_page.dart';
import 'package:laxia/views/pages/main/mypage/following_list_page.dart';
import 'package:laxia/views/pages/main/mypage/invite_page.dart';
import 'package:laxia/views/pages/main/mypage/point_page.dart';
import 'package:laxia/views/pages/main/mypage/setting_page.dart';

class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'Ayaka11',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.5,
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Helper.titleColor,
              size: 30,
            )),
            elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: NestedScrollView(
          headerSliverBuilder: _silverBuilder,
          body: ListView(
            children: <Widget>[
              // _buildTabBar(),
              _buildTabView()
            ],
          ),
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
        controller: _tabController,
        indicatorColor: Helper.mainColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3.8,
        labelColor: Helper.titleColor,
        unselectedLabelColor: Helper.unSelectTabColor,
        tabs: [
          Tab(
            child: Text(
              "日記",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 1.5,
                color: Helper.titleColor,
              ),
            ),
          ),
          Tab(
            child: Text(
              "カウセレポ",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
          Tab(
            child: Text(
              "質問",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          )
        ]);
  }

  Widget _buildTabView() {
    return Container(
      height: 1000,
      child: TabBarView(
        controller: _tabController,
        children: [
          buildDiaryPage(),
          buildCounselingPage(),
          buildQuestionPage()
        ],
      ),
    );
  }

  Widget buildDiaryPage() {
    return Container(
      color: Helper.bodyBgColor,
      height: 640,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DiaryCardWidget(),
            SizedBox(
              height: 8,
            ),
            DiaryCardWidget()
          ],
        ),
      ),
    );
  }

  Widget buildCounselingPage() {
    return Container(
      height: 640,
      color: Helper.bodyBgColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DiaryCardWidget(),
            SizedBox(
              height: 8,
            ),
            DiaryCardWidget()
          ],
        ),
      ),
    );
  }

  Widget buildQuestionPage() {
    return Container(
      height: 640,
      color: Helper.bodyBgColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DiaryCardWidget(),
            SizedBox(
              height: 8,
            ),
            DiaryCardWidget()
          ],
        ),
      ),
    );
  }

  List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        elevation: 0,
        expandedHeight: 350,
        floating: true,
        pinned: false,
        automaticallyImplyLeading: false,
        backgroundColor: Helper.whiteColor,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: Helper.whiteColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 16.0, right: 16.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            "${currentUser.imageUrl}",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  "あやか",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    height: 1.5,
                                    color: Helper.titleColor,
                                  ),
                                )),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FixProfilePage()));
                              },
                              style: OutlinedButton.styleFrom(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  shape: StadiumBorder(),
                                  side: BorderSide(
                                      width: 1, color: Helper.mainColor)),
                              child: Text(
                                "変更",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  height: 1.5,
                                  color: Helper.mainColor,
                                ),
                              )),
                        ],
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowingListPage()));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: Text(
                                  "26",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Helper.titleColor,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                child: Text(
                              "フォロー",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5,
                                color: Color.fromARGB(255, 194, 194, 194),
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowerListPage()));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: Text(
                                  "26",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Helper.titleColor,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                child: Text(
                              "フォロワー",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5,
                                color: Color.fromARGB(255, 194, 194, 194),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "こちらに紹介文が入ります。こちらに紹介文が入ります。こちらに紹介文が入ります。こちらに紹介文が入ります。こちらに紹介文が入ります。",
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.justify,
                            maxLines: 4,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.3,
                              color: Helper.titleColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "保有ポイント",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            height: 1.5,
                            color: Color.fromARGB(255, 18, 18, 18),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "1000 p",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                height: 1.5,
                                color: Color.fromARGB(255, 18, 18, 18),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right_sharp),
                              color: Helper.titleColor,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PointPage()));
                              },
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 2.0, left: 5.0, right: 5.0, bottom: 2.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return InvitePage();
                                  },
                                  isScrollControlled: true,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.supervisor_account,
                                    color: Helper.titleColor,
                                  ),
                                  Text(
                                    "友達招待",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Helper.titleColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            width: 20,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingPage()));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.settings,
                                    color: Helper.titleColor,
                                  ),
                                  Text(
                                    "設定",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Helper.titleColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
          pinned: true, delegate: _SliverAppBarDelegate(_buildTabBar()))
    ];
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      color: Helper.whiteColor,
      child: _tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}

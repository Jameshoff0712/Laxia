import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/generated/L10n.dart';
import 'package:laxia/models/m_user.dart';
import 'package:laxia/views/pages/main/contribution/counsel_detail.dart';
import 'package:laxia/views/pages/main/contribution/question.dart';
import 'package:laxia/views/pages/main/contribution/question_detail.dart';
import 'package:laxia/views/pages/main/mypage/counseling_fix_page.dart';
import 'package:laxia/views/pages/main/mypage/diary_card_widget.dart';
import 'package:laxia/views/pages/main/mypage/fix_profile_page.dart';
import 'package:laxia/views/pages/main/mypage/follower_list_page.dart';
import 'package:laxia/views/pages/main/mypage/following_list_page.dart';
import 'package:laxia/views/pages/main/mypage/invite_page.dart';
import 'package:laxia/views/pages/main/mypage/point_page.dart';
import 'package:laxia/views/pages/main/mypage/setting_page.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/question_card.dart';

import '../../../../models/counseling_model.dart';
import '../../../../models/question_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List mid = [];
  List nid = [];
  bool isFollowing = true;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    for (int i = 0; i < counseling_list.length; i++)
      setState(() {
        mid.add(counseling_list[i]);
      });
    for (int i = 0; i < question_list.length; i++)
      setState(() {
        nid.add(question_list[i]);
      });
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
            DiaryCardWidget(isMe: false),
            SizedBox(
              height: 8,
            ),
            DiaryCardWidget(isMe: false)
          ],
        ),
      ),
    );
  }

  Widget buildCounselingPage() {
    return Container(
      height: 640,
      color: Helper.bodyBgColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  itemCount: mid.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Counseling_Card(
                      hearts: mid[index]["hearts"],
                      chats: mid[index]["chats"],
                      avator: mid[index]["avator"],
                      check: mid[index]["check"],
                      image2: mid[index]["image2"],
                      image1: mid[index]["image1"],
                      image3: mid[index]["image3"],
                      image4: mid[index]["image4"],
                      eyes: mid[index]["eyes"],
                      name: mid[index]["name"],
                      onpress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CounselDetail(
                                      isMyDiary: true,
                                    )));
                      },
                      sentence: mid[index]["sentence"],
                      type: mid[index]["type"],
                      clinic: mid[index]["clinic"],
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionPage() {
    return Container(
      height: 640,
      color: Helper.bodyBgColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, BoxConstraints viewportConstraints) {
                return ListView.builder(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    itemCount: mid.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Question_Card(
                        buttoncolor: Helper.allowStateButtonColor,
                        buttontext: "回答あり",
                        hearts: mid[index]["hearts"],
                        chats: mid[index]["chats"],
                        avator: mid[index]["avator"],
                        image2: mid[index]["image2"],
                        image1: mid[index]["image1"],
                        eyes: mid[index]["eyes"],
                        name: mid[index]["name"],
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionDetail(
                                        isMyDiary: true,
                                      )));
                        },
                        sentence: mid[index]["sentence"],
                        type: mid[index]["type"],
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        elevation: 0,
        expandedHeight: 210,
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
                                setState(() {
                                  isFollowing = !isFollowing;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  shape: StadiumBorder(),
                                  side: BorderSide(
                                      width: 1, color: Helper.mainColor),
                                      backgroundColor: isFollowing ? Helper.whiteColor : Helper.mainColor),
                              child: isFollowing
                                  ? Text(
                                      "フォロー中",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5,
                                        color: Helper.mainColor,
                                      ),
                                    )
                                  : Text(
                                      "フォローする",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.5,
                                        color: Helper.whiteColor,
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/generated/L10n.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/m_user.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/contribution/counsel_detail.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
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
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/question_card.dart';
import 'package:provider/provider.dart';

import '../../../../models/counseling_model.dart';
import '../../../../models/question_model.dart';

class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List mid = [];
  List nid = [];

  late UserProvider userProperties;

  @override
  initState() {
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  //   for (int i = 0; i < counseling_list.length; i++)
  //     setState(() {
  //       mid.add(counseling_list[i]);
  //     });
  //   for (int i = 0; i < question_list.length; i++)
  //     setState(() {
  //       nid.add(question_list[i]);
  //     });
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userProperties = Provider.of<UserProvider>(context, listen: true);
    // print(userProperties.getMe.diaries);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          userProperties.getMe.nickname!,
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
              userProperties.setCurrentPageIndex(0);
              Navigator.of(context).pushNamed('/Pages');
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
        indicatorWeight: 2.0,
        labelColor: Helper.titleColor,
        unselectedLabelColor: Helper.unSelectTabColor,
        labelPadding: EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
        tabs: [
          Tab(
            child: Text(
              "日記",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 1.5,
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
          buildDiaryPage(userProperties.getMe.diaries),
          buildCounselingPage(userProperties.getMe.counselings),
          buildQuestionPage(userProperties.getMe.favorite_questions)
        ],
      ),
    );
  }

  Widget buildDiaryPage(List<Diary_Sub_Model> mid) {
    // print(mid);
    return Container(
      color: Helper.bodyBgColor,
      height: 640,
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
                    return Diary_Card(
                      avator: mid[index].patient_photo!,
                      name: mid[index].patient_nickname!,
                      image1: mid[index].before_image!,
                      image2: mid[index].after_image!,
                      sentence: mid[index].last_content!.toString(),
                      type: mid[index].patient_gender!,
                      clinic: mid[index].clinic_name,
                      check: mid[index].doctor_name!,
                      price: mid[index].price.toString(),
                      eyes: mid[index].views_count.toString(),
                      hearts: mid[index].likes_count.toString(),
                      chats: mid[index].comments_count.toString(),
                      onpress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Diary_Detail(
                                      isMyDiary: true, index: 1,
                                    ))
                        );
                      },
                      isPublic: true,
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }

  Widget buildCounselingPage(List<Counceling_Sub_Model> mid) {
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
                      avator: mid[index].patient_photo!,
                      name: mid[index].patient_nickname!,
                      sentence: mid[index].content!,
                      image1: mid[index].patient_photo!,
                      image2: mid[index].patient_photo!,
                      image3: mid[index].patient_photo!,
                      image4: mid[index].patient_photo!,
                      type: mid[index].counseling_date!,
                      clinic: mid[index].clinic_name!,
                      check: mid[index].doctor_name!,
                      eyes: mid[index].views_count.toString(),
                      hearts: mid[index].likes_count.toString(),
                      chats: mid[index].comments_count.toString(),
                      onpress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CounselDetail(
                                      isMyDiary: true, index: mid[index].id,
                                    )));
                      },
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }

  Widget buildQuestionPage(List<Question_Sub_Model> mid) {
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
                        avator: "",
                        name: "",
                        sentence: mid[index].content!,
                        image1: "",
                        image2: "",
                        type: "",
                        eyes: mid[index].views_count.toString(),
                        hearts: mid[index].likes_count.toString(),
                        chats: mid[index].comments_count.toString(),
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionDetail(
                                        isMyDiary: true, index: mid[index].id,
                                      )));
                        },
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
        expandedHeight: 290,
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
                          backgroundImage: NetworkImage(
                            userProperties.getMe.photo!,
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
                                  userProperties.getMe.name,
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
                                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
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
                                  userProperties.getMe.followsCount.toString(),
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
                                  userProperties.getMe.followersCount
                                      .toString(),
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
                            userProperties.getMe.intro,
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
                    height: 44,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Color.fromARGB(255, 210, 210, 212))),
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
                              "${userProperties.getMe.point} p",
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
                    height: 44,
                    padding: const EdgeInsets.only(
                        top: 3.0, left: 5.0, right: 5.0, bottom: 3.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Color.fromARGB(255, 210, 210, 212))),
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
                                    size: 15
                                  ),
                                  SizedBox(height: 0),
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
                                    size: 15,
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

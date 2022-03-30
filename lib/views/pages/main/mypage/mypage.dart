import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/generated/L10n.dart';
import 'package:laxia/models/m_user.dart';
import 'package:laxia/views/pages/main/mypage/diary_card_widget.dart';
import 'package:laxia/views/pages/main/mypage/fix_profile_page.dart';

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
        title: Center(
          child: Text(
            'Ayaka11',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
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
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3.8,
        tabs: [
          Tab(
            child: Text(
              "日記",
              style: defaultTextStyle(Helper.blackColor, FontWeight.bold, size: 16),
            ),
          ),
          Tab(
            child: Text(
              "カウセレポ",
              style: defaultTextStyle(Helper.blackColor, FontWeight.bold, size: 16),
            ),
          ),
          Tab(
            child: Text(
              "質問",
              style: defaultTextStyle(Helper.blackColor, FontWeight.bold, size: 16),
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
        expandedHeight: 400,
        floating: true,
        pinned: false,
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
                        width: 9,
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
                                  style: defaultTextStyle(
                                      Helper.appTxtColor, FontWeight.w700,
                                      size: 20),
                                )),
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
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
                                style: defaultTextStyle(
                                    Helper.mainColor, FontWeight.w100,
                                    size: 16),
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
                      SizedBox(
                          height: 24,
                          width: 24,
                          child: Text(
                            "26",
                            style: TextStyle(
                              color: Helper.appTxtColor,
                            ),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          child: Text(
                        "フォロー",
                        style: TextStyle(color: Helper.extraGrey, fontSize: 14),
                      )),
                      SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                          height: 24,
                          width: 24,
                          child: Text(
                            "26",
                            style: TextStyle(
                              color: Helper.appTxtColor,
                            ),
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          child: Text(
                        "フォロワー",
                        style: TextStyle(color: Helper.extraGrey, fontSize: 14),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                              maxLines: 4),
                        ],
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(0.0),
                    padding: const EdgeInsets.only(
                        top: 2.0, left: 5.0, right: 5.0, bottom: 2.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "保有ポイント",
                          style:
                              TextStyle(color: Helper.extraGrey, fontSize: 18),
                        ),
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("1000p"),
                            IconButton(
                              icon: const Icon(Icons.chevron_right_sharp),
                              color: Helper.appTxtColor,
                              onPressed: () {},
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(0.0),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.supervisor_account),
                                Text(
                                  "友達招待",
                                  style: TextStyle(
                                      color: Helper.appTxtColor, fontSize: 14),
                                )
                              ],
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.settings),
                                Text(
                                  "設定",
                                  style: TextStyle(
                                      color: Helper.appTxtColor, fontSize: 14),
                                )
                              ],
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

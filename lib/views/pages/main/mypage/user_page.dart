import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/views/pages/main/contribution/counsel_detail.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/contribution/question_detail.dart';
import 'package:laxia/views/pages/main/mypage/follower_list_page.dart';
import 'package:laxia/views/pages/main/mypage/following_list_page.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/indicator.dart';
import 'package:laxia/views/widgets/question_card.dart';
class UserPage extends StatefulWidget {
  final int id;
  const UserPage({Key? key, required this.id}) : super(key: key);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFollowing = false,isloading=true;
  final _con = MyController();
  late Me patient_info;
  Future<void> getData() async {
    try {
      final mid = await _con.getPatientInfo(widget.id);
      setState(() {
        patient_info = mid;
        isFollowing=patient_info.isfollow!;
         isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  void initState() {
    super.initState();
    getData();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Future<void> postTooglefollow() async {
    try {
      final res=await _con.postTooglefollow(index:widget.id);
      if(res==true){
        setState(() {
          isFollowing=!isFollowing;
        });
      }
    } catch (e) {
    }
  }
  @override
  Widget build(BuildContext context) {
    return isloading
    ? Container(
        child: Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      ))
    :Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          patient_info.name!,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent, 
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
        // margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
        labelPadding: EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 0),
        indicatorPadding: EdgeInsets.only(bottom: 0, right: -3, left: -3),
        indicator: CircleTabIndicator(color: Helper.mainColor, radius: 20),
        tabs: [
          Tab(
            child: Text(
              "日記",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                
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
                
              ),
            ),
          ),
          Tab(
            child: Text(
              "質問",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                
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
      height: 640,
      color: Helper.bodyBgColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  itemCount: patient_info.diaries!.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Diary_Card(
                              avator:
                                  patient_info.diaries![index].patient_photo == null
                                      ? "http://error.png"
                                      : patient_info.diaries![index].patient_photo!,
                              check: patient_info.diaries![index].doctor_name == null
                                  ? ""
                                  : patient_info.diaries![index].doctor_name!,
                              image2: patient_info.diaries![index].after_image == null
                                  ? "http://error.png"
                                  : patient_info.diaries![index].after_image!,
                              image1:
                                  patient_info.diaries![index].before_image == null
                                      ? "http://error.png"
                                      : patient_info.diaries![index].before_image!,
                              eyes: patient_info.diaries![index].views_count == null
                                  ? ""
                                  : patient_info.diaries![index].views_count!
                                      .toString(),
                              clinic: patient_info.diaries![index].clinic_name == null
                                  ? ""
                                  : patient_info.diaries![index].clinic_name!,
                              name: patient_info.diaries![index].patient_nickname ==
                                      null
                                  ? ""
                                  : patient_info.diaries![index].patient_nickname!,
                              onpress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Diary_Detail(
                                        index: patient_info.diaries![index].id)));
                              },
                              price: patient_info.diaries![index].price == null
                                  ? ""
                                  : patient_info.diaries![index].price.toString(),
                              sentence:
                                  patient_info.diaries![index].doctor_name == null
                                      ? ""
                                      : patient_info.diaries![index].doctor_name!,
                              type: patient_info.diaries![index].doctor_name == null
                                  ? ""
                                  : patient_info.diaries![index].doctor_name!,
                            );
                      });
            }),
          ),
        ],
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
                  itemCount: patient_info.counselings!.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Counseling_Card(
                              hearts: patient_info.counselings![index].likes_count ==
                                      null
                                  ? ""
                                  : patient_info.counselings![index].likes_count!
                                      .toString(),
                              chats: patient_info.counselings![index].comments_count ==
                                      null
                                  ? ""
                                  : patient_info.counselings![index].comments_count
                                      .toString(),
                              avator: patient_info.counselings![index].patient_photo ==
                                      null
                                  ? "http://error.png"
                                  : patient_info.counselings![index].patient_photo!,
                              check: patient_info.counselings![index].doctor_name ==
                                      null
                                  ? ""
                                  : patient_info.counselings![index].doctor_name!,
                              images:patient_info.counselings![index].media_self!,
                              name: patient_info.counselings![index].patient_nickname ==
                                      null
                                  ? ""
                                  : patient_info.counselings![index].patient_nickname!,
                              onpress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CounselDetail(
                                            index: patient_info.counselings![index].id)));
                              },
                              sentence:
                                  patient_info.counselings![index].content == null
                                      ? ""
                                      : patient_info.counselings![index].content!,
                              type:
                                  patient_info.counselings![index].categories!,
                              clinic: patient_info.counselings![index].clinic_name ==
                                      null
                                  ? ""
                                  : patient_info.counselings![index].clinic_name!, 
                              eyes: patient_info.counselings![index].views_count.toString(),
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
                    itemCount: patient_info.questions!.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Question_Card(
                          isanswer: patient_info.questions![index].answers.isNotEmpty,
                          hearts: patient_info.questions![index].likes_count==null?"":patient_info.questions![index].likes_count!.toString(),
                          chats: patient_info.questions![index].comments_count==null?"":patient_info.questions![index].comments_count.toString(),
                          avator:patient_info.questions![index].owner!.photo==null?"http://error.png": patient_info.questions![index].owner!.photo!,
                          image2: (patient_info.questions![index].medias!.isEmpty||patient_info.questions![index].medias!.length==1)?"http://error.png":patient_info.questions![index].medias![1].path,
                          image1:patient_info.questions![index].medias!.isEmpty?"http://error.png":patient_info.questions![index].medias![0].path,
                          eyes: patient_info.questions![index].views_count==null?"":patient_info.questions![index].views_count!.toString(),
                          name:patient_info.questions![index].owner!.name==null?"": patient_info.questions![index].owner!.name!,
                          onpress: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuestionDetail(index:  patient_info.questions![index].id)));
                            //Navigator.of(context).pushNamed("/QuestionDetail");
                          },
                          sentence:patient_info.questions![index].content==null?"": patient_info.questions![index].content!,
                          type:"二重切開" //patient_info.questions![index]["type"],
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: patient_info.photo==null?"https://error.png":patient_info.photo,
                              placeholder: (context, url) => Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/profile.png',
                                fit: BoxFit.cover,
                              ),
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
                                  patient_info.kana!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    
                                    color: Helper.titleColor,
                                  ),
                                )),
                          ),
                          Container(
                            width: 110,
                            height: 30,
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    postTooglefollow();
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6),
                                    shape: StadiumBorder(),
                                    side: BorderSide(
                                        width: 1, color: Helper.mainColor),
                                        backgroundColor: isFollowing ? Helper.mainColor : Helper.whiteColor),
                                child: isFollowing
                                    ? Text(
                                        "フォロー中",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          
                                          color: Helper.whiteColor
                                        ),
                                      )
                                    : Text(
                                        "フォローする",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Helper.mainColor,
                                        ),
                                      )),
                          ),
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
                      GestureDetector(
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
                                child: Text(
                                  patient_info.followsCount.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    
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
                                
                                color: Color.fromARGB(255, 194, 194, 194),
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
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
                                child: Text(
                                  patient_info.followersCount.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    
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
                            patient_info.intro!,
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

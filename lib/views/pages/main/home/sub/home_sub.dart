import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/home/home_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/home_sub_horizonalbar.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:provider/provider.dart';

class Home_Sub extends StatefulWidget {
  final VoidCallback onpress;
  final bool isvisible;
  const Home_Sub({Key? key, required this.onpress, required this.isvisible})
      : super(key: key);

  @override
  State<Home_Sub> createState() => _Home_SubState();
}

class _Home_SubState extends State<Home_Sub>
    with SingleTickerProviderStateMixin {
  List<String> tabMenus = [
    'おすすめ',
    '二重',
    '美容皮膚',
    'ボディ',
    '輪郭',
    'しわ・たるみ',
  ];
  late TabController _tabController;
  bool flag = true,isLoading=true;
  late Home home_data;
  ScrollController scrollController = new ScrollController();
  PageController _pageController = PageController();
  double? currentPageValue = 0.0;
  int page=1;
  final _con = HomeController();
  Future<void> getData(String id) async {
    try {
      setState(() {
        flag = true;
      });
      Home mid = await _con.getHomeDate(id);
      if(id==""){
          setState(() {
            home_data = mid;
          });
        }else{
           setState(() {
              home_data.data.clear();
              home_data.data.addAll(mid.data);
              print(home_data.data.length);
           });
           
        }
      setState(() {
        flag = false;
      });
    } catch (e) {
      setState(() {
        print("error occured");
      });
    }
  }

  @override
  void initState() {
    _tabController = new TabController(length: 6, vsync: this);
    getData("");
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        getData(_tabController.index.toString());
      }
    });
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        widget.onpress();
      } else if (widget.isvisible == false) {
        widget.onpress();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Helper.homeBgColor,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: _silverBuilder,
          body: Container(
            decoration: BoxDecoration(color: Helper.whiteColor),
            child: Column(
              children: <Widget>[
                // _buildTabBar(),
                TabBarWidget(
                  tabMenus: tabMenus,
                  tabController: _tabController,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Helper.homeBgColor),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Subscrollbarbody(),
                        Subscrollbarbody(),
                        Subscrollbarbody(),
                        Subscrollbarbody(),
                        Subscrollbarbody(),
                        Subscrollbarbody(),
                      ],
                      controller: _tabController,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
          elevation: 0,
          expandedHeight: 214,
          floating: true,
          pinned: false,
          automaticallyImplyLeading: false,
          backgroundColor: Helper.whiteColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: <Widget>[
                Horizontal_Dockbar(pageController: _pageController),
                Container(
                  decoration: BoxDecoration(color: Helper.whiteColor),
                  child: Column(children: [
                    SizedBox(
                      height: 13,
                    ),
                    DockBar_Bottom(
                        pageController: _pageController,
                        currentPageValue: currentPageValue),
                    SizedBox(
                      height: 16,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ]),
                ),
              ],
            ),
          ))
    ];
  }

  Widget Subscrollbarbody() {
    return flag
        ? Container(
            child: Container(
            height: isLoading ? MediaQuery.of(context).size.width*0.5: 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ))
        : Container(
            child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==scrollInfo.metrics.maxScrollExtent) {
                  // getData(page: (page+1).toString());
                  // setState(() {
                  //   page+=1;
                  // }); 
                }
                return true;
              },
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 175 / 291,
                      crossAxisCount: 2,
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 9),
                  itemCount: home_data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Home_Card(
                      onpress: () {},
                      title: home_data.data[index].first_content == null
                          ? ""
                          : home_data.data[index].first_content!,
                      type: home_data.data[index].type == null
                          ? ""
                          : home_data.data[index].type!,
                      clinic: home_data.data[index].clinic == null
                          ? ""
                          : home_data.data[index].clinic!,
                      recommend: home_data.data[index].comments_count == null
                          ? " "
                          : home_data.data[index].comments_count.toString(),
                      source: home_data.data[index].photo!,
                      name: home_data.data[index].nickname == null
                          ? ""
                          : home_data.data[index].nickname!,
                      doctorimage: home_data.data[index].photo!,
                      chat: home_data.data[index].views_count == null
                          ? " "
                          : home_data.data[index].views_count.toString(),
                    );
                  }),
            ),
          );
  }
}

class DockBar_Bottom extends StatelessWidget {
  const DockBar_Bottom({
    Key? key,
    required PageController pageController,
    required this.currentPageValue,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final double? currentPageValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 31,
      height: 6,
      child: InkWell(
        onTap: () {
          _pageController.animateToPage((currentPageValue!.floor() + 1) % 2,
              duration: Duration(milliseconds: 250), curve: Curves.easeIn);
        },
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
              width: 31,
              height: 6,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 111, 82, 82),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Align(
              alignment: currentPageValue!.floor() == 0
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: 16,
                height: 6,
                decoration: BoxDecoration(
                  color: Helper.mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Horizontal_Dockbar extends StatelessWidget {
  const Horizontal_Dockbar({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        color: Helper.whiteColor,
      ),
      height: 178,
      child: PageView(
        controller: _pageController,
        children: [
          Center(
            child: Container(
              height: 178,
              child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.08,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 0),
                  children: [
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/doubles.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(0);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "二重",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Contour.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(1);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "輪郭・小顔",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Raise_nose.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(2);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "鼻を高く",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/drooping_eye.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(3);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "タレ目",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Hair_loss.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(4);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "脱毛",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/chest.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(5);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "胸",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/body.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(6);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "ボディ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Nose.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(7);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "小鼻",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Wrinkles.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(8);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "しわ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Spots_freckles.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(9);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "しみ・そばかす",
                    ),
                  ]),
            ),
          ),
          Center(
            child: Container(
              height: 178,
              child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     childAspectRatio: 1.1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 0),
                  children: [
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/mouth.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(10);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "口元",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Inner_eye.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(11);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "目頭",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/pores.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(12);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "毛穴",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Sagging.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(13);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "たるみ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Eyes.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(14);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "目元",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Mole_warts.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(15);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "ホクロ・イボ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Permanent_makeup.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(16);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "アートメイク",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Nose_tip.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(17);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "鼻先",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/Aesthetic_dentistry.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(18);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "審美歯科",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "assets/icons/menubar/all.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(19);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "すべて",
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

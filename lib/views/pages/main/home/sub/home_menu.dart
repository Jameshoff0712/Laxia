import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/menu/menu_model.dart';
import 'package:laxia/provider/pref_provider.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Home_Menu extends StatefulWidget {
  final bool? isScrollable, isdrawer;
  final List? last;
  Home_Menu(
      {Key? key,
      this.isScrollable = true,
      this.isdrawer = true,
      this.last})
      : super(key: key);

  @override
  State<Home_Menu> createState() => _Home_MenuState();
}

class _Home_MenuState extends State<Home_Menu> {
  String searchdata = "",city_id='',category_id="";
  String filter='';
  bool isloading = true, isexpanding = true, isend = false;
  int page = 1;
  bool expanded = false,first=true;
  int index = -1;
  late Menu menu_data;
  final _con = HomeController();
  Future<void> getData({required String page}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
          print(searchdata);
        final mid = await _con.getMenuData(page: page, q: searchdata,filter:filter,city_id:city_id,category_id:category_id);
        print(mid.data.length);
        setState(() {
          if (isloading) {
            menu_data = mid;
            isloading = false;
          } else {
            menu_data.data.addAll(mid.data);
            isexpanding = true;
          }
        });
      }
    } catch (e) {
      setState(() {
        isexpanding = true;
        isend = true;
        print(e.toString());
      });
    }
  }

  void init() {
    setState(() {
      isloading = true;
      isexpanding = true;
      isend = false;
      page = 1;
      expanded = false;
      index = -1;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
  SurGeryProvider surgeryprovider =
        Provider.of<SurGeryProvider>(context, listen: true);
  PrefProvider prefyprovider =
        Provider.of<PrefProvider>(context, listen: true);
    if(first){
      setState(() {
        searchdata = userProperties.searchtext;
        getData(page: page.toString());
        first=false;
      });
    }
    if (!isloading&&(searchdata != userProperties.searchtext)) {
      init();
      setState(() {
        searchdata = userProperties.searchtext;
        getData(page: page.toString());
      });
    }
    if (!isloading&&(city_id != prefyprovider.getSelectedCurePos.join(","))) {
      init();
      setState(() {
        city_id = prefyprovider.getSelectedCurePos.join(",");
        getData(page: page.toString());
      });
    }
    if(!isloading&&(category_id != surgeryprovider.getSelectedCurePos.join(","))) {
      if(!isloading)
      {
        init();
      setState(() {
        category_id = surgeryprovider.getSelectedCurePos.join(",");
        getData(page: page.toString());
      });}
    }
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          widget.isdrawer!
              ? Container(
                  color: Helper.whiteColor,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: TextButton_Drawer(
                              width: 123,
                              textname: "エリア選択",
                              onpress: () {
                                Navigator.of(context)
                                    .pushNamed("/SelectPrefecture");
                              })), //SelectPrefecture
                      Expanded(
                        flex: 3,
                        child: TextButton_Drawer(
                            width: 123,
                            textname: "悩み・目的",
                            onpress: () {
                              Navigator.of(context).pushNamed("/SelectSurgery");
                            }),
                      ),
                      Expanded(
                        flex: 3,
                        child: Dropdownbutton(
                          onpress: (val){
                            setState(() {
                              filter=val;
                              page=1;
                              isend = false;
                              isloading = true;
                            });
                            // print(val);
                            getData(page: page.toString());
                          },
                          items: <String>[
                          "日記数が多い順",
                          "評価が高い順",
                          "値段が高い順",
                          "値段が安い順"
                        ], hintText: "並び替え", horizontal: 31),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  if (isexpanding) {
                    getData(page: (page + 1).toString());
                    setState(() {
                      page += 1;
                    });
                  }
                } else if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.minScrollExtent) {
                  //widget.scrollTop!();
                }
                return true;
              },
              child: SingleChildScrollView(
                physics: widget.isScrollable!
                    ? AlwaysScrollableScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    widget.isdrawer!
                        ? SizedBox(
                            height: 0,
                          )
                        : Container(
                            color: Helper.whiteColor,
                            child: Column(
                              children: [
                                ExtendedWrap(
                                    alignment: WrapAlignment.center,
                                    maxLines: expanded ? 2 : 100,
                                    clipBehavior: Clip.none,
                                    runSpacing: 10,
                                    spacing: 10,
                                    children: [
                                      for (int i = 0;
                                          i < widget.last!.length;
                                          i++)
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (index == i) {
                                                index = -1;
                                              } else {
                                                index = i;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                                color: index == i
                                                    ? Helper.mainColor
                                                    : Helper.homeBgColor),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 3),
                                              child: Text(
                                                widget.last![i]["label"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: index == i
                                                        ? Helper.whiteColor
                                                        : Helper.titleColor),
                                              ),
                                            ),
                                          ),
                                        )
                                    ]),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      expanded = !expanded;
                                    });
                                  },
                                  child: Icon(
                                    expanded
                                        ? FontAwesomeIcons.angleDown
                                        : FontAwesomeIcons.angleUp,
                                    size: 24,
                                    color: Helper.titleColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    isloading
                        ? Container(
                            child: Container(
                            height: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Center(
                              child: new CircularProgressIndicator(),
                            ),
                          ))
                        : menu_data.data.isNotEmpty? ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            itemCount: menu_data.data.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Menu_Card(
                                  onpress: () {
                                    //Navigator.of(context).pushNamed("/Menu_Detail");
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Menu_Detail(
                                                index:
                                                    menu_data.data[index].id)));
                                  },
                                  image: menu_data.data[index].images!.isEmpty
                                      ? "http://error.png"
                                      : menu_data.data[index].images![0].path,
                                  heading:
                                      menu_data.data[index].description == null
                                          ? ""
                                          : menu_data.data[index].description!,
                                  price: menu_data.data[index].price == 0
                                      ? ""
                                      : menu_data.data[index].price!.toString(),
                                  clinic: menu_data.data[index].clinic == null ? '' : menu_data.data[index].clinic!.name!);
                            })
                            : Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/LAXIA.svg",
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      '検索結果がありません',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.6,
                                        fontWeight: FontWeight.w700,
                                        color: Helper.txtColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                    Container(
                      height: isexpanding ? 0 : 100,
                      color: Colors.transparent,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

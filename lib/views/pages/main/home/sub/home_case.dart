import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/case/case_model.dart';
import 'package:laxia/models/case_model.dart';
import 'package:laxia/provider/pref_provider.dart';
import 'package:laxia/provider/search_provider.dart';
import 'package:laxia/views/pages/main/contribution/case_detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Home_Case extends StatefulWidget {
  final bool? isdrawer;
  final List? last;
  const Home_Case({Key? key, this.isdrawer = true, this.last})
      : super(key: key);

  @override
  State<Home_Case> createState() => _Home_CaseState();
}

class _Home_CaseState extends State<Home_Case> {
  String filter = '', city_id = '';

  String searchdata = "";
  bool expanded = true,first=true;
  int page = 0, index = -1;
  bool isend = false, isloading = true, isexpanding = true;
  late Case case_data;
  int minprice = 0, maxprice = 0;
  List<int> year = [0, 0, 0, 0, 0, 0];
  final _con = HomeController();
  Future<void> getData({required String page}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getCaseData(
            page: page,
            q: searchdata,
            filter: filter,
            price_min: minprice.toString(),
            price_max: maxprice.toString(),
            year: year.join(','),
            city_id: city_id);
        if (mid.data.isEmpty) {
          setState(() {
            isexpanding = true;
            isend = true;
          });
        }
        setState(() {
          if (isloading) {
            case_data = mid;
            isloading = false;
          } else {
            case_data.data.addAll(mid.data);
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

  // @override
  // void initState() {
  //   getData(page: page.toString());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    PrefProvider prefyprovider =
        Provider.of<PrefProvider>(context, listen: true);
    SearchProvider searchprovider =
        Provider.of<SearchProvider>(context, listen: true);
     if(first){
       init();
      setState(() {
        searchdata = userProperties.searchtext;
         getData(page: page.toString());
        first=false;
      });
    } 
    if (searchdata != userProperties.searchtext) {
      init();
      setState(() {
        searchdata = userProperties.searchtext;
        getData(page: page.toString());
      });
    }
    if (isloading == false &&
        city_id != prefyprovider.getSelectedCurePos.join(",")) {
      init();
      setState(() {
        city_id = prefyprovider.getSelectedCurePos.join(",");
        getData(page: page.toString());
      });
    }
    if (minprice != searchprovider.minprice ||
        maxprice != searchprovider.maxprice ||
        year != searchprovider.year) {
      init();
      setState(() {
        minprice = searchprovider.minprice;
        maxprice = searchprovider.maxprice;
        year = searchprovider.year;
        getData(page: page.toString());
      });
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
                              })),
                      Expanded(
                        flex: 3,
                        child: TextButton_Drawer(
                            width: 123,
                            textname: "絞り込み",
                            onpress: () {
                              Navigator.of(context).pushNamed("/NarrowCase");
                            }),
                      ),
                      Expanded(
                        flex: 3,
                        child: Dropdownbutton(
                            onpress: (val) {
                              setState(() {
                                filter = val;
                                page = 1;
                                isend = false;
                                isloading = true;
                              });
                              // print(val);
                              getData(page: page.toString());
                            },
                            items: <String>["人気投稿順", "新着順"],
                            hintText: "並び替え",
                            horizontal: 32),
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
                if (isexpanding && !isend) {
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
              physics: AlwaysScrollableScrollPhysics(),
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
                      : case_data.data.isNotEmpty? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: case_data.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Diary_Card(
                              onpress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CaseDetail(
                                            index: case_data.data[index].id)));
                                // Navigator.of(context).pushNamed("/CaseDetail");
                              },
                              buttoncolor: Helper.btnBgMainColor,
                              buttontext: "症例",
                              avator:
                                  case_data.data[index].clinic!.photo == null
                                      ? "http://error.png"
                                      : case_data.data[index].clinic!.photo!,
                              check: case_data.data[index].doctor == null
                                  ? ""
                                  : case_data.data[index].doctor!.kata_name,
                              image2: case_data.data[index].afterimage!.isEmpty
                                  ? "http://error.png"
                                  : case_data.data[index].afterimage![0].path,
                              image1: case_data.data[index].beforeimage!.isEmpty
                                  ? "http://error.png"
                                  : case_data.data[index].beforeimage![0].path,
                              eyes: case_data.data[index].views_count == null
                                  ? ""
                                  : case_data.data[index].views_count
                                      .toString(),
                              name: case_data.data[index].clinic!.name == null
                                  ? ""
                                  : case_data.data[index].clinic!.name!,
                              price: case_data.data[index].menus!.isEmpty
                                  ? ""
                                  : (case_data.data[index].menus![0].price ==
                                          null
                                      ? ""
                                      : case_data.data[index].menus![0].price!
                                          .toString()),
                              sentence: case_data.data[index].treat_risk == null
                                  ? ""
                                  : case_data.data[index].treat_risk!,
                              type:
                                  case_data.data[index].case_description == null
                                      ? ""
                                      : case_data.data[index].case_description!,
                            );
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
          )),
        ],
      ),
    );
  }
}

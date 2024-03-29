import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/counseling/counceling_model.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/provider/pref_provider.dart';
import 'package:laxia/views/pages/main/contribution/counsel_detail.dart';
import 'package:laxia/views/widgets/counseling_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Home_Counseling extends StatefulWidget {
  final bool? isdrawer;
  final List? last;
  const Home_Counseling({Key? key, this.isdrawer = true, this.last})
      : super(key: key);

  @override
  State<Home_Counseling> createState() => _Home_CounselingState();
}

class _Home_CounselingState extends State<Home_Counseling> {
  String searchdata = "", city_id = '';
  String filter = '';
  bool expanded = true,first=true;
  int index = -1, page = 0;
  bool isend = false, isloading = true, isexpanding = true;
  late Counceling counceling_data;
  final _con = HomeController();
  Future<void> getData({required String page, String? q = ""}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getCouncelingData(
            page: page, q: q, filter: filter, city_id: city_id);
        if (mid.data.isEmpty) {
          setState(() {
            isexpanding = true;
            isend = true;
          });
        }
        setState(() {
          if (isloading) {
            counceling_data = mid;
            isloading = false;
          } else {
            counceling_data.data.addAll(mid.data);
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
      ;
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
    if(first){
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
        getData(page: page.toString(), q: userProperties.searchtext);
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
                              horizontal: 40,
                              width: 186,
                              textname: "エリア選択",
                              onpress: () {
                                Navigator.of(context)
                                    .pushNamed("/SelectPrefecture");
                              })),
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
                              getData(
                                  page: page.toString(),
                                  q: userProperties.searchtext);
                            },
                            items: <String>["人気投稿順", "新着順"],
                            hintText: "並び替え",
                            horizontal: 62),
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
                  getData(page: (page + 1).toString(), q: searchdata);
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
                      :counceling_data.data.isNotEmpty? ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: counceling_data.data.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Counseling_Card(
                              hearts: counceling_data.data[index].likes_count ==
                                      null
                                  ? ""
                                  : counceling_data.data[index].likes_count!
                                      .toString(),
                              chats: counceling_data
                                          .data[index].comments_count ==
                                      null
                                  ? ""
                                  : counceling_data.data[index].comments_count
                                      .toString(),
                              avator: counceling_data
                                          .data[index].patient_photo ==
                                      null
                                  ? "http://error.png"
                                  : counceling_data.data[index].patient_photo!,
                              check: counceling_data.data[index].doctor_name ==
                                      null
                                  ? ""
                                  : counceling_data.data[index].doctor_name!,
                              images: counceling_data.data[index].media_self!,
                              eyes: counceling_data.data[index].views_count ==
                                      null
                                  ? ""
                                  : counceling_data.data[index].views_count!
                                      .toString(),
                              name: counceling_data
                                          .data[index].patient_nickname ==
                                      null
                                  ? ""
                                  : counceling_data
                                      .data[index].patient_nickname!,
                              onpress: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CounselDetail(
                                            index: counceling_data
                                                .data[index].id)));
                              },
                              sentence:
                                  counceling_data.data[index].content == null
                                      ? ""
                                      : counceling_data.data[index].content!,
                              type: counceling_data.data[index].categories!,
                              clinic: counceling_data.data[index].clinic_name ==
                                      null
                                  ? ""
                                  : counceling_data.data[index].clinic_name!,
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

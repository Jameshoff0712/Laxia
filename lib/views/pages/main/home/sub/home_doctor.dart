import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/doctor/doctor_model.dart';
import 'package:laxia/provider/pref_provider.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';

class Home_Doctor extends StatefulWidget {
  final bool? isScrollable, isdrawer;
  final VoidCallback? scrollTop;
  const Home_Doctor(
      {Key? key,
      this.isScrollable = true,
      this.scrollTop = null,
      this.isdrawer = true})
      : super(key: key);

  @override
  State<Home_Doctor> createState() => _Home_DoctorState();
}

class _Home_DoctorState extends State<Home_Doctor> {
  String searchdata = "",city_id='',category_id="";
  String filter='';
  bool isloading = true, isexpanding = true, isend = false;
  int page = 1;
  bool expanded = false;
  int index = -1;
  late Doctor doctor_data;
  final _con = HomeController();
  Future<void> getData({required String page, String? q = ""}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getDoctorData(page: page,city_id:city_id, q: q!,filter:filter,category_id:category_id);
        if (mid.data.isEmpty) {
          setState(() {
            isexpanding = true;
            isend = true;
          });
        }
        setState(() {
          if (isloading) {
            doctor_data = mid;
            isloading = false;
          } else {
            doctor_data.data.addAll(mid.data);
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
    getData(page: page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    PrefProvider prefyprovider =
        Provider.of<PrefProvider>(context, listen: true);
    SurGeryProvider surgeryprovider =
        Provider.of<SurGeryProvider>(context, listen: true);
    if (searchdata != userProperties.searchtext) {
      init();
      setState(() {
        searchdata = userProperties.searchtext;
        getData(page: page.toString(), q: userProperties.searchtext);
      });
    }
    if (city_id != prefyprovider.getSelectedCurePos.join(",")) {
      init();
      setState(() {
        city_id = prefyprovider.getSelectedCurePos.join(",");
        getData(page: page.toString());
      });
    }
    if (category_id != surgeryprovider.getSelectedCurePos.join(",")) {
      if(!isloading)
      {init();
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
                            onpress: (val){
                              setState(() {
                                filter=val;
                                page=1;
                                isend = false;
                                isloading = true;
                              });
                              // print(val);
                              getData(page: page.toString(), q: userProperties.searchtext);
                            },
                            items: <String>["評価が高い順", "日記の多い順"],
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
              child: LayoutBuilder(
                  builder: (context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    Expanded(
                      child: isloading
                          ? Container(
                              child: Container(
                              height: MediaQuery.of(context).size.width,
                              color: Colors.transparent,
                              child: Center(
                                child: new CircularProgressIndicator(),
                              ),
                            ))
                          :doctor_data.data.isNotEmpty?  ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              itemCount: doctor_data.data.length,
                              physics: widget.isScrollable!
                                  ? AlwaysScrollableScrollPhysics()
                                  : NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Doctor_Card(
                                    onpress: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Doctor_Detail(
                                                      index: doctor_data
                                                          .data[index].id)));
                                      // Navigator.of(context).pushNamed("/Doctor_Detail");
                                    },
                                    image: doctor_data.data[index].photo == null
                                        ? "http://error.png"
                                        : doctor_data.data[index].photo!,
                                    name: doctor_data.data[index].hira_name,
                                    mark:  double.parse((doctor_data.data[index].avg_rate).toStringAsFixed(1)).toString(), //doctor_data.data[index]["mark"],
                                    day: doctor_data.data[index].views_count==null?"0":doctor_data.data[index].views_count
                                        .toString(), //doctor_data.data[index]["day"],
                                    clinic:
                                        "湘南美容クリニック 新宿院" //doctor_data.data[index].clinic_id .toString()
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
                    ),
                    Container(
                      height: isexpanding ? 0 : 100,
                      color: Colors.transparent,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

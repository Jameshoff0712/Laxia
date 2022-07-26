import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/clinic/clinic_model.dart';
import 'package:laxia/provider/pref_provider.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_detail.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Home_Clinic extends StatefulWidget {
  final bool? isScrollable;
  final VoidCallback? scrollTop;
  final bool issearch;
  final List? model;
  const Home_Clinic(
      {Key? key,
      required this.issearch,
      this.model,
      this.isScrollable = true,
      this.scrollTop = null})
      : super(key: key);

  @override
  State<Home_Clinic> createState() => _Home_ClinicState();
}

class _Home_ClinicState extends State<Home_Clinic> {
  String searchdata = "" ,category_id="";
  String filter='';
  bool isloading = true, isexpanding = true, isend = false;
  int page = 1;
  bool expanded = false;
  int index = -1;
  late int pref_id;
  String city_id='';
  List mid = [];
  late Clinic clinic_data;
  final _con = HomeController();
  Future<void> getData(
      {required String page,
      String? pref_id = ""}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getclinicData(
            page: page, category_id: category_id, city_id: city_id, q: searchdata,filter:filter);
        setState(() {
          if (isloading) {
            clinic_data = mid;
            isloading = false;
            // print("object");
          } else {
            clinic_data.data.addAll(mid.data);
            isexpanding = true;
          }
        });
      }
    } catch (e) {
      isexpanding = true;
      isend = true;
      setState(() {
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

  @override
  void initState() {
    getData(page: page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SurGeryProvider surgeryprovider =
        Provider.of<SurGeryProvider>(context, listen: true);
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    PrefProvider prefyprovider =
        Provider.of<PrefProvider>(context, listen: true);
    if (searchdata != userProperties.searchtext) {
      init();
      setState(() {
        searchdata = userProperties.searchtext;
        getData(page: page.toString());
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
          Container(
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
                          Navigator.of(context).pushNamed("/SelectPrefecture");
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
                              searchdata=userProperties.searchtext;
                            });
                            // print(val);
                            getData(page: page.toString());
                      },
                      width: 123,
                      items: <String>["評価が高い順", "日記の多い順"],
                      hintText: "並び替え",
                      horizontal: 62),
                ),
              ],
            ),
          ),
          Expanded(
            child: isloading
                ? Container(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.transparent,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, BoxConstraints viewportConstraints) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          if (isexpanding) {
                            getData(page: (page + 1).toString());
                            setState(() {
                              page += 1;
                            });
                          }
                        }
                        return true;
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                itemCount: clinic_data.data.length,
                                physics: widget.isScrollable!
                                    ? AlwaysScrollableScrollPhysics()
                                    : NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Clinic_Card(
                                      onpress: () {
                                        // print("object");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Clinic_Detail(
                                                        index: clinic_data
                                                            .data[index].id)));
                                      },
                                      image:
                                          clinic_data.data[index].photo == null
                                              ? "http://error.png"
                                              : clinic_data.data[index].photo!,
                                      post: "",
                                      name: clinic_data.data[index].name==null?"":clinic_data.data[index].name!,
                                      mark: clinic_data
                                                  .data[index].avg_rate ==
                                              null
                                          ? "11"
                                          : clinic_data.data[index].diaries_count
                                              .toString(),
                                      day: clinic_data
                                                  .data[index].diaries_count ==
                                              null
                                          ? ""
                                          : clinic_data.data[index].diaries_count
                                              .toString(),
                                      location: (clinic_data.data[index].addr01 ==
                                                  null
                                              ? ""
                                              : clinic_data
                                                  .data[index].addr01!) +
                                          " " +
                                          (clinic_data.data[index].addr02 == null
                                              ? ""
                                              : clinic_data.data[index].addr02!));
                                }),
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
                    );
                  }),
          ),
        ],
      ),
    );
  }
}

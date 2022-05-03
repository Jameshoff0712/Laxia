import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/diary/diary_model.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Home_Diary extends StatefulWidget {
  final bool? isScrollable, isdrawer;
  final VoidCallback? scrollTop;
  final bool issearch;
  final List? model, last;
  const Home_Diary(
      {Key? key,
      required this.issearch,
      this.model,
      this.isScrollable = true,
      this.scrollTop = null,
      this.isdrawer = true,
      this.last})
      : super(key: key);

  @override
  State<Home_Diary> createState() => _Home_DiaryState();
}

class _Home_DiaryState extends State<Home_Diary> {
  String searchdata="";
  int page = 0;
  bool isend = false, isloading = true, isexpanding = true;
  bool expanded = true;
  int index = -1;
  late Diary diary_data;
  final _con = HomeController();
  Future<void> getData({required String page,String?q=""}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getDiaryData(page: page,q:q);
        if (mid.data.isEmpty) {
          setState(() {
            isexpanding = true;
            isend = true;
          });
        }
        setState(() {
          if (isloading) {
            diary_data = mid;
            isloading = false;
          } else {
            diary_data.data.addAll(mid.data);
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
  void init(){
    setState(() {
       isloading = true;
       isexpanding=true;
       isend=false;
       page = 1;
       expanded=false;
       index=-1;
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
    if(searchdata!=userProperties.searchtext){
      init();
      setState(() {
        searchdata=userProperties.searchtext;
        getData(page: page.toString(), q: userProperties.searchtext);
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
                              Navigator.of(context).pushNamed("/NarrowDiary");
                            }),
                      ),
                      Expanded(
                        flex: 3,
                        child: Dropdownbutton(
                            items: <String>["人気投稿順", "満足度が高い順", "新着順"],
                            hintText: "並び替え",
                            horizontal: 20),
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
                if (isexpanding&&!isend) {
                  getData(page: (page + 1).toString(),q: searchdata);
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
                                      InkWell(
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
                              InkWell(
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
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: diary_data.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Diary_Card(
                              avator:
                                  diary_data.data[index].patient_photo == null
                                      ? "http://error.png"
                                      : diary_data.data[index].patient_photo!,
                              check: diary_data.data[index].doctor_name == null
                                  ? ""
                                  : diary_data.data[index].doctor_name!,
                              image2: diary_data.data[index].after_image == null
                                  ? "http://error.png"
                                  : diary_data.data[index].after_image!,
                              image1:
                                  diary_data.data[index].before_image == null
                                      ? "http://error.png"
                                      : diary_data.data[index].before_image!,
                              eyes: diary_data.data[index].views_count == null
                                  ? ""
                                  : diary_data.data[index].views_count!
                                      .toString(),
                              clinic: diary_data.data[index].clinic_name == null
                                  ? ""
                                  : diary_data.data[index].clinic_name!,
                              name: diary_data.data[index].patient_nickname ==
                                      null
                                  ? ""
                                  : diary_data.data[index].patient_nickname!,
                              onpress: () {
                                Navigator.of(context)
                                    .pushNamed("/Diary_Detail");
                              },
                              price: diary_data.data[index].price == null
                                  ? ""
                                  : diary_data.data[index].price.toString(),
                              sentence:
                                  diary_data.data[index].doctor_name == null
                                      ? ""
                                      : diary_data.data[index].doctor_name!,
                              type: diary_data.data[index].doctor_name == null
                                  ? ""
                                  : diary_data.data[index].doctor_name!,
                            );
                          }),
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

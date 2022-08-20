import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/static_controller.dart';
import 'package:laxia/models/static/master_model.dart';
import 'package:laxia/provider/pref_provider.dart';
import 'package:laxia/provider/search_provider.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/home/sub/home_clinic.dart';
import 'package:laxia/views/pages/main/home/sub/home_diary.dart';
import 'package:laxia/views/pages/main/home/sub/home_doctor.dart';
import 'package:laxia/views/pages/main/home/sub/home_menu.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:provider/provider.dart';

class Part extends StatefulWidget {
  final int index ;
  final int? part_id;
  const Part({Key? key, required this.index, this.part_id=0}) : super(key: key);

  @override
  State<Part> createState() => _PartState();
}

class _PartState extends State<Part> with SingleTickerProviderStateMixin {
  List<String> tabMenus = ['日記', 'メニュー', 'クリニック', 'ドクター'];
  late TabController _tabController;
  bool expanded = true, isChildScrollable = false;
  late ScrollController scrollController;
  late Master_Model master_model;
  final _con = StaticController();
  List<bool> willSelect = [];
  bool isloading = true;
  Future<void> getData() async {
    try {
      master_model = await _con.getIndexPartCategories(widget.index);
      print('--------------------------------');
      print(master_model);
      for (int i = 0; i < master_model.all_childrens!.length; i++) {
        setState(() {
          if(widget.part_id== master_model.all_childrens![i].id)
          {
            willSelect.add(true);
          }else
            willSelect.add(false);
        });
      }
      setState(() {
        isloading = false;
      });

    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    getData();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        setState(() {
          isChildScrollable = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PrefProvider prefyprovider =
        Provider.of<PrefProvider>(context, listen: true);
    SurGeryProvider surgeryprovider =
        Provider.of<SurGeryProvider>(context, listen: true);
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);
    return //(partResult.isNotEmpty && treatment.isNotEmpty)
    isloading
    ? Container(
        child: Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      ))
    : Scaffold(
            backgroundColor: Helper.whiteColor,
            body: Container(
              color: Helper.whiteColor,
              child: Column(
                children: [
                  SizedBox(height: 45,),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 16, right: 16),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Center(
                          child: Text(
                              master_model.name!,
                              style: defaultTextStyle(
                                  Helper.blackColor, FontWeight.w700,
                                  size: 20)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: (){
                                            surgeryprovider.initSelected();
                                            Navigator.pop(context);
                                          },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Helper.blackColor,
                              size: 16,
                            ),
                            iconSize: 16,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,  
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
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
                                            i <
                                                master_model.all_childrens!
                                                    .length;
                                            i++)
                                          GestureDetector(
                                            onTap: () {
                                              surgeryprovider.setSelectedCurePos(master_model.all_childrens![i].id,master_model.all_childrens![i].name!);
                                              print(surgeryprovider.selectedCurePos.join(','));
                                              setState(() {
                                                willSelect[i]=!willSelect[i];
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Helper.mainColor),
                                                  color: willSelect[i]
                                                      ? Helper.mainColor
                                                      : Helper.whiteColor),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 3),
                                                child: Text(
                                                  master_model.all_childrens![i].name!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color:willSelect[i]
                                                          ? Helper.whiteColor
                                                          : Helper.mainColor),
                                                ),
                                              ),
                                            ),
                                          )
                                      ]),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                expanded = !expanded;
                              });
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    expanded?"すべて表示":"閉じる",
                                    style: TextStyle(
                                        color: Helper.mainColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 8.41,
                                  ),
                                  
                                  Icon(
                                    expanded? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                                    color: Helper.mainColor,
                                    size: 24,
                                  ),
                                ]),
                          ),
                          Container(
                              child: Column(
                            children: [
                              TabBarWidget(
                                tabMenus: tabMenus,
                                tabController: _tabController,
                                padding: 25, onpress: () {
                                  searchProvider.initSelected();
                                  prefyprovider.initSelected();
                                },
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 101,
                                child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Home_Diary(
                                    ),
                                    Home_Menu(
                                    ),
                                    Home_Clinic(
                                    ),
                                    Home_Doctor(
                                    ),
                                  ],
                                  controller: _tabController,
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

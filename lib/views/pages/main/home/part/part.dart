import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/home/sub/home_clinic.dart';
import 'package:laxia/views/pages/main/home/sub/home_diary.dart';
import 'package:laxia/views/pages/main/home/sub/home_doctor.dart';
import 'package:laxia/views/pages/main/home/sub/home_menu.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:provider/provider.dart';

class Part extends StatefulWidget {
  const Part({Key? key}) : super(key: key);

  @override
  State<Part> createState() => _PartState();
}

class _PartState extends State<Part> with SingleTickerProviderStateMixin {
  List<String> tabMenus = ['日記', 'メニュー', 'クリニック', 'ドクター'];
  late TabController _tabController;
  int index = -1;
  bool expanded = true, isChildScrollable = false;
  List treatment = [];
  List partResult = [];
  late ScrollController scrollController;
  Future<void> initSettings() async {
    String mid =
        await rootBundle.loadString("assets/cfg/treatment_location.json");
    setState(() {
      treatment.addAll(json.decode(mid));
    });
  }

  Future<void> searchResult() async {
    String mid = await rootBundle.loadString("assets/cfg/part_result.json");
    setState(() {
      partResult.addAll(json.decode(mid));
    });
  }

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    searchResult();
    initSettings();
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
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    return (partResult.isNotEmpty && treatment.isNotEmpty)
        ? Scaffold(
            backgroundColor: Helper.whiteColor,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 16, right: 16),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Center(
                          child: Text(
                              treatment[userProperties.currentPartIndex]
                                  ["label"],
                              style: defaultTextStyle(
                                  Helper.blackColor, FontWeight.w700,
                                  size: 20)),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Helper.blackColor,
                              size: 16,
                            ),
                            iconSize: 16,
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
                                                treatment[userProperties
                                                            .currentPartIndex]
                                                        ["children"]
                                                    .length;
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
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Helper.mainColor),
                                                  color: index == i
                                                      ? Helper.mainColor
                                                      : Helper.whiteColor),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 3),
                                                child: Text(
                                                  treatment[userProperties
                                                          .currentPartIndex]
                                                      ["children"][i]["label"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: index == i
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
                                  SvgPicture.asset(
                                    expanded?"assets/icons/arrowdownpart.svg": "assets/icons/arrowuppart.svg",
                                    fit: BoxFit.cover,
                                    width: 10,
                                    height: 5,
                                    color: Helper.mainColor,
                                  ),
                                ]),
                          ),
                          Container(
                              child: Column(
                            children: [
                              TabBarWidget(
                                tabMenus: tabMenus,
                                tabController: _tabController,
                                padding: 25,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 101,
                                child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Home_Diary(
                                      issearch: true,
                                      model: partResult[0],
                                      isScrollable: isChildScrollable,
                                      scrollTop: () {
                                        setState(() {
                                          isChildScrollable = false;
                                        });
                                      },
                                    ),
                                    Home_Menu(
                                      issearch: true,
                                      model: partResult[1],
                                      isScrollable: isChildScrollable,
                                      scrollTop: () {
                                        setState(() {
                                          isChildScrollable = false;
                                        });
                                      },
                                    ),
                                    Home_Clinic(
                                      issearch: true,
                                      model: partResult[2],
                                      isScrollable: isChildScrollable,
                                      scrollTop: () {
                                        setState(() {
                                          isChildScrollable = false;
                                        });
                                      },
                                    ),
                                    Home_Doctor(
                                      issearch: true,
                                      model: partResult[3],
                                      isScrollable: isChildScrollable,
                                      scrollTop: () {
                                        setState(() {
                                          isChildScrollable = false;
                                        });
                                      },
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
          )
        : Scaffold();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/doctor/doctordetail_model.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_top.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_case.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_counseling.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_diary.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_question.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Doctor_Sub_Detail extends StatefulWidget {
  final int index;
  final DoctorDetail_Model doctor_detail;
  const Doctor_Sub_Detail(
      {Key? key, required this.doctor_detail, required this.index})
      : super(key: key);

  @override
  State<Doctor_Sub_Detail> createState() => _Doctor_Sub_DetailState();
}

class _Doctor_Sub_DetailState extends State<Doctor_Sub_Detail>
    with SingleTickerProviderStateMixin {
  List<String> tabMenus = [
    'トップ',
    '日記',
    '症例',
    'カウセレポ',
    '質問',
  ];
  late TabController _tabController;
  bool isfavourite = false;
  late ScrollController scrollController;
  @override
  void initState() {
    setState(() {
      isfavourite = widget.doctor_detail.doctor.is_favorite == null
          ? false
          : widget.doctor_detail.doctor.is_favorite!;
    });
    _tabController =
        new TabController(initialIndex: widget.index, length: 5, vsync: this);
    super.initState();
  }

  void changeTabIndex(int index) {
    _tabController.animateTo(index,
        duration: const Duration(microseconds: 300), curve: Curves.easeIn);
  }

  final _con = HomeController();
  Future<void> postToogleFavorite(index) async {
    try {
      final res =
          await _con.postToogleFavorite(index: index, domain: 'doctors');
      if (res == true) {
        setState(() {
          isfavourite = !isfavourite;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Helper.whiteColor,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios,
                                  size: 22, color: Colors.black),
                              onPressed: () => Navigator.pop(context),
                              splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: widget
                                                .doctor_detail.doctor.photo ==
                                            null
                                        ? "https://error.png"
                                        : widget.doctor_detail.doctor.photo!,
                                    placeholder: (context, url) => Image.asset(
                                      'assets/images/loading.gif',
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/profile.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.doctor_detail.doctor.name == null
                                      ? ""
                                      : widget.doctor_detail.doctor.name!,
                                  style: TextStyle(
                                      fontFamily: Helper.headFontFamily,
                                      color: Helper.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: Helper.starColor,
                                      size: 9,
                                    ),
                                    SizedBox(
                                      width: 2.7,
                                    ),
                                    Text(
                                      "4.5", // widget.doctor_detail["mark"],
                                      style: TextStyle(
                                          color: Helper.titleColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          "assets/icons/upright_nobg.svg",
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  TabBarWidget(
                    tabMenus: tabMenus,
                    tabController: _tabController,
                    padding: 15, onpress: () {  },
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Doctor_Top(
                            doctor_detail: widget.doctor_detail,
                            onpress: changeTabIndex),
                        Home_Diary(diaries: widget.doctor_detail.diaries, categories: widget.doctor_detail.doctor.categories!,),
                        Home_Case(cases: widget.doctor_detail.cases, categories: widget.doctor_detail.doctor.categories!,),
                        Home_Counseling(
                            councelings: widget.doctor_detail.counselings, categories: widget.doctor_detail.doctor.categories!,),
                        Home_Question(
                            questions: widget.doctor_detail.questions, categories: widget.doctor_detail.doctor.categories!,),
                      ],
                      controller: _tabController,
                    ),


                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
         decoration: BoxDecoration(color: Helper.whiteColor),
        child: SafeArea(
          child: Container(
            height: 66,
            decoration: BoxDecoration(color: Helper.whiteColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    postToogleFavorite(widget.doctor_detail.doctor.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isfavourite
                          ? SvgPicture.asset(
                              "assets/icons/star.svg",
                              width: 22,
                              height: 22,
                              color: Helper.starColor,
                            )
                          : SvgPicture.asset(
                              "assets/icons/borderstar.svg",
                              width: 22,
                              height: 22,
                            ),
                      Text(
                        "お気に入り",
                        style: TextStyle(
                            color: Helper.txtColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 42),
                    decoration: BoxDecoration(
                      color: Helper.btnBgYellowColor,
                      borderRadius:BorderRadius.circular(40.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "このドクターに相談",
                          style: defaultTextStyle(Helper.whiteColor, FontWeight.w700,
                              size: 16),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/clinic/clinicdetail_model.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_top.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_case.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_counseling.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_diary.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_doctor.dart';
import 'package:laxia/views/pages/main/home/detail/staticsub/home_menu.dart';
import 'package:laxia/views/widgets/tabbar.dart';

class Clinic_Sub_Detail extends StatefulWidget {
  final int index;
  final ClinicDetail_Model clinic_Detail;
  const Clinic_Sub_Detail(
      {Key? key, required this.clinic_Detail, required this.index})
      : super(key: key);

  @override
  State<Clinic_Sub_Detail> createState() => _Clinic_Sub_DetailState();
}

class _Clinic_Sub_DetailState extends State<Clinic_Sub_Detail>
    with SingleTickerProviderStateMixin {
  List<String> tabMenus = [
    'トップ',
    'ドクター',
    'メニュー',
    '日記',
    'カウセレポ',
    '質問',
  ];
  late TabController _tabController;
  bool isfavourite = false;
  final _con = HomeController();
  late ScrollController scrollController;
  Future<void> postToogleFavorite(index) async {
    try {
      final res =
          await _con.postToogleFavorite(index: index, domain: 'clinics');
      if (res == true) {
        setState(() {
          isfavourite = !isfavourite;
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    setState(() {
      isfavourite = widget.clinic_Detail.clinic.is_favorite == null
          ? false
          : widget.clinic_Detail.clinic.is_favorite!;
    });
    _tabController =
        new TabController(initialIndex: widget.index, length: 6, vsync: this);
    super.initState();
  }

  void changeTabIndex(int index) {
    _tabController.animateTo(index,
        duration: const Duration(microseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              size: 22, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          widget.clinic_Detail.clinic.name == null
                              ? ""
                              : widget.clinic_Detail.clinic.name!,
                          style: TextStyle(
                              color: Helper.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
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
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Clinic_Top(
                            clinic_detail: widget.clinic_Detail,
                            onpress: changeTabIndex),
                        Home_Doctor(
                          doctors: widget.clinic_Detail.doctors,
                        ),
                        Home_Menu(menus: widget.clinic_Detail.menu),
                        Home_Diary(diaries: widget.clinic_Detail.diaries),
                        Home_Counseling(
                            councelings: widget.clinic_Detail.counselings),
                        Home_Case(cases: widget.clinic_Detail.cases),
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
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 66,
          decoration: BoxDecoration(color: Helper.whiteColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  postToogleFavorite(widget.clinic_Detail.clinic.id);
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
                          color: isfavourite
                              ? Helper.btnBgYellowColor
                              : Helper.txtColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  primary: Helper.btnBgYellowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "クリニックを予約",
                      style: defaultTextStyle(
                          Helper.whiteColor, FontWeight.w700,
                          size: 14),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/Reservation");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

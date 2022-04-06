import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_top.dart';
import 'package:laxia/views/pages/main/home/sub/home_case.dart';
import 'package:laxia/views/pages/main/home/sub/home_counseling.dart';
import 'package:laxia/views/pages/main/home/sub/home_diary.dart';
import 'package:laxia/views/pages/main/home/sub/home_doctor.dart';
import 'package:laxia/views/pages/main/home/sub/home_menu.dart';
import 'package:laxia/views/pages/main/home/sub/home_sub.dart';
import 'package:laxia/views/widgets/tabbar.dart';

class Clinic_Sub_Detail extends StatefulWidget {
  final int index;
  final dynamic clinic_Detail;
  const Clinic_Sub_Detail({ Key? key, required this.clinic_Detail, required this.index }) : super(key: key);

  @override
  State<Clinic_Sub_Detail> createState() => _Clinic_Sub_DetailState();
}

class _Clinic_Sub_DetailState extends State<Clinic_Sub_Detail>   with SingleTickerProviderStateMixin{
   List<String> tabMenus = [
    'トップ',
    'ドクター',
    'メニュー',
    '日記',
    'カウセレポ',
    '質問',
  ];
  late TabController _tabController;
  bool isfavourite=false;
  List treatment = [];
  late ScrollController scrollController;
  Future<void> initSettings() async {
    String mid =
        await rootBundle.loadString("assets/cfg/treatment_location.json");
    setState(() {
      treatment.addAll(json.decode(mid));
    });
  }
  @override
  void initState() {
    initSettings();
    _tabController = new TabController(initialIndex: widget.index,length: 6, vsync: this);
    super.initState();
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                          widget.clinic_Detail["name"],
                          style: TextStyle(
                              color:
                                  Helper.blackColor,
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
                      Clinic_Top(clinic_detail: widget.clinic_Detail,),
                      Home_Doctor(isdrawer:false,issearch: true,model: widget.clinic_Detail["doctors"],),
                       Home_Menu(issearch: true,model: widget.clinic_Detail["menus"],last:treatment[0]["children"],isdrawer:false),
                      Home_Diary(issearch: true,model: widget.clinic_Detail["diarys"],last:treatment[0]["children"],isdrawer:false),
                      Home_Counseling(issearch: true,model: widget.clinic_Detail["counceling"],last:treatment[0]["children"],isdrawer:false),
                      Home_Case(issearch: true,model: widget.clinic_Detail["case"],last:treatment[0]["children"],isdrawer:false),
                    ],
                    controller: _tabController,
                  ),
                ),
              ],),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 66,
         decoration: BoxDecoration(color: Helper.whiteColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
              InkWell(
                onTap: (){
                  setState(() {
                    isfavourite=!isfavourite;
                  });
                },
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  isfavourite?Icon(Icons.star,color: Helper.btnBgYellowColor,size: 30,)
                  : Icon(Icons.star_border,color: Helper.txtColor,size: 30,),
                  Text(
                    "お気に入り",
                    style: TextStyle(
                        color: isfavourite?Helper.btnBgYellowColor:Helper.txtColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
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
        ],),
      ),
    );
  }
}
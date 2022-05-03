import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_top.dart';
import 'package:laxia/views/pages/main/home/sub/home_case.dart';
import 'package:laxia/views/pages/main/home/sub/home_counseling.dart';
import 'package:laxia/views/pages/main/home/sub/home_diary.dart';
import 'package:laxia/views/pages/main/home/sub/home_question.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Doctor_Sub_Detail extends StatefulWidget {
  final int index;
  final dynamic doctor_detail;
  const Doctor_Sub_Detail({ Key? key, required this.doctor_detail, required this.index }) : super(key: key);

  @override
  State<Doctor_Sub_Detail> createState() => _Doctor_Sub_DetailState();
}

class _Doctor_Sub_DetailState extends State<Doctor_Sub_Detail>   with SingleTickerProviderStateMixin{
   List<String> tabMenus = [
    'トップ',
    '日記',
    '症例',
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
    print(widget.doctor_detail["avator"]);
    initSettings();
    _tabController = new TabController(initialIndex: widget.index,length: 5, vsync: this);
    super.initState();
  
  }
  @override
  Widget build(BuildContext context) {
    return treatment.isNotEmpty? Scaffold(
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
                      
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("/Mypage");
                            },
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      widget.doctor_detail["avatar"],
                                  placeholder: (context, url) =>
                                      Image.asset(
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
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  widget.doctor_detail["name"],
                                  style: TextStyle(
                                      color:
                                          Helper.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,size: 10,),
                                    Text(
                                      widget.doctor_detail["mark"],
                                      style: TextStyle(
                                          color:
                                              Helper.blackColor,
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
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Doctor_Top(doctor_detail: widget.doctor_detail,),
                      Home_Diary(issearch: true,model: widget.doctor_detail["diarys"],last:treatment[0]["children"],isdrawer:false),
                      Home_Case(issearch: true,model: widget.doctor_detail["case"],last:treatment[0]["children"],isdrawer:false),
                      Home_Counseling(issearch: true,model: widget.doctor_detail["counceling"],last:treatment[0]["children"],isdrawer:false),
                      Home_Question(issearch: true,model: widget.doctor_detail["questions"],last:treatment[0]["children"],isdrawer:false),
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
                      "さあ, はじめよう！",
                      style: defaultTextStyle(
                          Helper.whiteColor, FontWeight.w700,
                          size: 14),
                    ),
                  ],
                ),
                onPressed: () {
                  
                },
              ),
        ],),
      ),
    ):Scaffold();
  }
}
import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_sub_detail.dart';
import 'package:laxia/views/widgets/doctor_detail_card.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/question_card.dart';

class Doctor_Detail extends StatefulWidget {
  const Doctor_Detail({Key? key}) : super(key: key);

  @override
  State<Doctor_Detail> createState() => _Doctor_DetailState();
}

class _Doctor_DetailState extends State<Doctor_Detail> {
  bool isfavourite=false;
  List doctor_Details = [];
  Future<void> get_doctor_Details() async {
    String mid = await rootBundle.loadString("assets/cfg/detail_doctor.json");
    setState(() {
      doctor_Details.addAll(json.decode(mid));
    });
  }

  @override
  void initState() {
    get_doctor_Details();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(doctor_Details.isNotEmpty);
    return doctor_Details.isNotEmpty? Scaffold(
      backgroundColor: Helper.homeBgColor,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Helper.whiteColor,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Helper.mainColor,
                  ),
                  Column(
                    children: [
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/back_detail.svg",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/icons/upright.svg",
                                width: 30,
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.1),
                                  blurRadius: 5)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0)),
                        margin:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
                        // padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Column(
                          children: [
                            Doctor_DetailCard(
                                image: "none",
                                clinic: doctor_Details[0]["clinic"],
                                name: doctor_Details[0]["name"],
                                mark: doctor_Details[0]["mark"],
                                post: doctor_Details[0]["post"],
                                profile: doctor_Details[0]['profile'],
                                items: doctor_Details[0]['items'])
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Helper.whiteColor,
              child: Clinic_Card(
                onpress: (){
                },
                  image: "none",
                  post: doctor_Details[0]["post"],
                  name: doctor_Details[0]["name"],
                  mark: doctor_Details[0]["mark"],
                  day: "",
                  location: doctor_Details[0]["clinic"]),
            ),
            SizedBox(height: 5,),
            Container(
              color: Helper.whiteColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "日記",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 5),
                            Text(
                              doctor_Details[0]["diarys"].length.toString() +
                                  "件",
                              style: TextStyle(
                                  color: Helper.darkGrey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push( MaterialPageRoute(builder: (_) => Doctor_Sub_Detail(doctor_detail: doctor_Details[0], index: 1,)));
                          },
                          child: Row(
                            children: [
                              Text(
                                "すべての日記",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 156, 161, 161),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.navigate_next,
                                size: 15,
                                color: Color.fromARGB(255, 156, 161, 161),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: doctor_Details[0]['diarys'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Diary_Card(
                            avator: doctor_Details[0]['diarys'][index]
                                ["avator"],
                            check: doctor_Details[0]['diarys'][index]["check"],
                            image2: doctor_Details[0]['diarys'][index]
                                ["image2"],
                            image1: doctor_Details[0]['diarys'][index]
                                ["image1"],
                            eyes: doctor_Details[0]['diarys'][index]["eyes"],
                            clinic: doctor_Details[0]['diarys'][index]
                                ["clinic"],
                            name: doctor_Details[0]['diarys'][index]["name"],
                            onpress: () {},
                            price: doctor_Details[0]['diarys'][index]["price"],
                            sentence: doctor_Details[0]['diarys'][index]
                                ["sentence"],
                            type: doctor_Details[0]['diarys'][index]["type"]);
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(
                                "すべての日記",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 156, 161, 161),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.navigate_next,
                                size: 15,
                                color: Color.fromARGB(255, 156, 161, 161),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(
              color: Helper.whiteColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "医師が回答した質問",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 5),
                            Text(
                              doctor_Details[0]["diarys"].length.toString() +
                                  "件",
                              style: TextStyle(
                                  color: Helper.darkGrey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push( MaterialPageRoute(builder: (_) => Doctor_Sub_Detail(doctor_detail: doctor_Details[0], index: 2,)));
                          },
                          child: Row(
                            children: [
                              Text(
                                "すべての質問",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 156, 161, 161),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.navigate_next,
                                size: 15,
                                color: Color.fromARGB(255, 156, 161, 161),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: doctor_Details[0]['questions'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Question_Card(
                          buttoncolor: Helper.allowStateButtonColor,
                          buttontext: "回答あり",
                          hearts: doctor_Details[0]['questions'][index]
                              ["hearts"],
                          chats: doctor_Details[0]['questions'][index]["chats"],
                          avator: doctor_Details[0]['questions'][index]
                              ["avator"],
                          image2: doctor_Details[0]['questions'][index]
                              ["image2"],
                          image1: doctor_Details[0]['questions'][index]
                              ["image1"],
                          eyes: doctor_Details[0]['questions'][index]["eyes"],
                          name: doctor_Details[0]['questions'][index]["name"],
                          onpress: () {},
                          sentence: doctor_Details[0]['questions'][index]
                              ["sentence"],
                          type: doctor_Details[0]['questions'][index]["type"],
                        );
                        ;
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(
                                "すべての質問",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 156, 161, 161),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.navigate_next,
                                size: 15,
                                color: Color.fromARGB(255, 156, 161, 161),
                              )
                            ],
                          ),
                        )
                      ],
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
      ),
    ):Scaffold();
  }
}

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/home/detail/Doctor_Sub_Detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';

class Doctor_Top extends StatefulWidget {
  final dynamic doctor_detail;
  const Doctor_Top({ Key? key, required this.doctor_detail }) : super(key: key);

  @override
  State<Doctor_Top> createState() => _Doctor_TopState();
}

class _Doctor_TopState extends State<Doctor_Top> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(child: Column(children: [
         SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
              child: Column(
               
                children: [
                  Container(
                    decoration: BoxDecoration(color: Helper.whiteColor),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "メニュー",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push( MaterialPageRoute(builder: (_) => Doctor_Sub_Detail(doctor_detail: widget.doctor_detail[0], index: 2,)));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "もっと見る",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 156, 161, 161),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      size: 15,
                                      color: Color.fromARGB(
                                          255, 156, 161, 161),
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
                            itemCount: widget.doctor_detail["menus"].length,
                            // physics: const AlwaysScrollableScrollPhysics(),
                            // scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return Menu_Card(
                                shadow: BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                                  image: widget.doctor_detail["menus"][index]
                                      ["image"],
                                  heading: widget.doctor_detail["menus"][index]
                                      ["heading"],
                                  price: widget.doctor_detail["menus"][index]
                                      ["price"],
                                  tax: widget.doctor_detail["menus"][index]["tax"],
                                  clinic: widget.doctor_detail["menus"][index]
                                      ["clinic"]);
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push( MaterialPageRoute(builder: (_) => Doctor_Sub_Detail(doctor_detail: widget.doctor_detail[0], index: 2,)));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "もっと見る",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 156, 161, 161),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          Icons.navigate_next,
                                          size: 15,
                                          color: Color.fromARGB(
                                              255, 156, 161, 161),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
              child: Column(
               
                children: [
                  Container(
                    decoration: BoxDecoration(color: Helper.whiteColor),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "日記",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push( MaterialPageRoute(builder: (_) => Doctor_Sub_Detail(doctor_detail: widget.doctor_detail[0], index: 3,)));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "すべての日記",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 156, 161, 161),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      size: 15,
                                      color: Color.fromARGB(
                                          255, 156, 161, 161),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                            itemCount: widget.doctor_detail["diarys"].length,
                            physics:NeverScrollableScrollPhysics(),
                            shrinkWrap:true,
                            itemBuilder: (BuildContext context, int index) {
                              return Diary_Card(
                                avator: widget.doctor_detail["diarys"][index]["avator"],
                                check: widget.doctor_detail["diarys"][index]["check"],
                                image2: widget.doctor_detail["diarys"][index]["image2"],
                                image1: widget.doctor_detail["diarys"][index]["image1"],
                                eyes: widget.doctor_detail["diarys"][index]["eyes"],
                                clinic: widget.doctor_detail["diarys"][index]["clinic"],
                                name: widget.doctor_detail["diarys"][index]["name"],
                                onpress: () {},
                                price: widget.doctor_detail["diarys"][index]["price"],
                                sentence: widget.doctor_detail["diarys"][index]["sentence"],
                                type: widget.doctor_detail["diarys"][index]["type"],
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                     Navigator.of(context).push( MaterialPageRoute(builder: (_) => Doctor_Sub_Detail(doctor_detail: widget.doctor_detail[0], index: 3,)));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "すべての日記",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 156, 161, 161),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          Icons.navigate_next,
                                          size: 15,
                                          color: Color.fromARGB(
                                              255, 156, 161, 161),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ],)),
    );
  }
}
import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_sub_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_one.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_three.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_two.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/detail_image.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/doctor_group_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';

class Menu_Datail extends StatefulWidget {
  const Menu_Datail({Key? key}) : super(key: key);

  @override
  State<Menu_Datail> createState() => _Menu_DatailState();
}

class _Menu_DatailState extends State<Menu_Datail> {
   List Menu_Datails = [];
   bool isfavourite=false;
  Future<void> get_Menu_Datails() async {
    String mid = await rootBundle.loadString("assets/cfg/detail_menu.json");
    setState(() {
      Menu_Datails.addAll(json.decode(mid));
      isfavourite=Menu_Datails[0]["favourite"];
    });
  }
  @override
  void initState() {
    get_Menu_Datails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print(Menu_Datails[0]);
    return Scaffold(
     backgroundColor:Helper.homeBgColor,
      body: SingleChildScrollView(
        physics:AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Detail_Image(
                  insidestar: true,
                  height: 375,
                  imageList: Menu_Datails[0]["images"], onPressUpRight: () {  }, onPressBack: () {  },
                ),
           Container(
             decoration: BoxDecoration(color: Helper.whiteColor),
             child: Padding(
               padding:EdgeInsets.all(8),
               child: Column(
                 crossAxisAlignment:CrossAxisAlignment.start,
                 children: [
                 Row(
                    children: [
                      Text(
                        Menu_Datails[0]["price"],
                        style: defaultTextStyle(Helper.priceColor, FontWeight.w700,
                            size: 24.0),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        Menu_Datails[0]["tax"],
                        style: defaultTextStyle(
                            Helper.titleColor, FontWeight.w500,
                            size: 12.0),
                      ),
                      SizedBox(
                      height: 2.5,
                    ),
                    
                    ],
                  ),
                  SizedBox(height: 9,),
                  Text(
                      Menu_Datails[0]["heading"],
                      style: defaultTextStyle(Helper.titleColor, FontWeight.w700,
                          size: 16.0),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                        Text(
                           Menu_Datails[0]["mark"],
                          style: defaultTextStyle(
                              Helper.titleColor, FontWeight.w700,
                              size: 14.0),
                        )
                      ],
                    ),
             ],)),
           ),
           SizedBox(height: 10,),
           Container(
             decoration: BoxDecoration(color: Helper.whiteColor),
             child: Padding(
               padding:EdgeInsets.all(8),
               child: Column(
                 crossAxisAlignment:CrossAxisAlignment.start,
                 children: [
                   Text(
                      "施術の説明",
                      style: defaultTextStyle(Helper.titleColor, FontWeight.w700,
                          size: 18.0),
                    ),
                    SizedBox(height: 12,),
                    Text(
                      Menu_Datails[0]["description"]["label"],
                      overflow: TextOverflow.ellipsis,
                      maxLines:3,
                      style: defaultTextStyle(Helper.maintxtColor, FontWeight.w400,
                          size: 14.0),
                    ),
                    SizedBox(height: 24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 219,
                            height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Helper.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "詳細を表示",
                                  style: defaultTextStyle(
                                      Helper.mainColor, FontWeight.w700,
                                      size: 13),
                                ),
                              ],
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                 isScrollControlled:true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                context: context,
                                builder: (context) {
                                  return Menu_Sub_Detail_One(detailList: Menu_Datails[0]["description"]["children"],);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
             ],)),
           ),
           SizedBox(height: 10,),
           Container(
             decoration: BoxDecoration(color: Helper.whiteColor),
             child: Padding(
               padding:EdgeInsets.all(8),
               child: Column(
                 crossAxisAlignment:CrossAxisAlignment.start,
                 children: [
                   Text(
                      "施術の詳細",
                      style: defaultTextStyle(Helper.titleColor, FontWeight.w700,
                          size: 18.0),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 0,
                        dataTextStyle:TextStyle(),
                        showBottomBorder: true,
                        showCheckboxColumn: false,
                        columnSpacing: 0,
                        columns: [
                        DataColumn(label: Text(  
                            '施術時間',  
                            style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700)  
                        )),  
                        DataColumn(label: Text(  
                            Menu_Datails[0]["description"]["children"][0],  
                            style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  
                        )),  
                      ], 
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('抜糸',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700)),),  
                        DataCell(Text(Menu_Datails[0]["description"]["children"][1], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                        ]),
                        DataRow(cells: [
                          DataCell(Text('施術後の通院')),  
                        DataCell(Text(Menu_Datails[0]["description"]["children"][2], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                        ]),
                        DataRow(cells: [
                          DataCell(Text('腫れ')),  
                        DataCell(Text(Menu_Datails[0]["description"]["children"][3], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                        ])
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 219,
                            height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Helper.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "詳細を表示",
                                  style: defaultTextStyle(
                                      Helper.mainColor, FontWeight.w700,
                                      size: 13),
                                ),
                              ],
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled:true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                context: context,
                                builder: (context) {
                                  return Menu_Sub_Detail_Two(detailList:Menu_Datails[0]["cert"]["children"] ,);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
             ],)),
           ),
           SizedBox(height: 10,),
           Container(
             decoration: BoxDecoration(color: Helper.whiteColor),
             child: Padding(
               padding:EdgeInsets.all(8),
               child: Column(
                 crossAxisAlignment:CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                          "施術の説明",
                          style: defaultTextStyle(Helper.titleColor, FontWeight.w700,
                              size: 18.0),
                        ),
                        Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Color.fromARGB(255, 249, 161, 56).withOpacity(0.3),),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Text(
                                  "施術時間 90分",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 249, 161, 56),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 16.0),
                     child: ListView.builder(
                       physics:NeverScrollableScrollPhysics(),
                              shrinkWrap:true,
                       itemCount: Menu_Datails[0]["follow"].length,
                       itemBuilder:(BuildContext context, int index) {
                         return Container(
                           decoration:BoxDecoration(color:  index%2==0?Helper.searchBarBgColor:Helper.whiteColor),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical:   7),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(children: [
                                   Container(
                                     width: 20,
                                     height: 20,
                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Helper.mainColor),
                                     child: Center(child: Text(index.toString(),style:TextStyle(fontSize: 14,color: Helper.whiteColor, fontWeight: FontWeight.w400))),
                                   ),
                                   Text(
                                      Menu_Datails[0]["follow"][index]["label"],style:TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)
                                   ),
                                 ],),
                                 Text(
                                      Menu_Datails[0]["follow"][index]["value"].toString()+"分",style:TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)
                                   ),
                             ],),
                           ),
                         );
                       }
                       
                        ),
                   )
             ],)),
           ),
           SizedBox(height: 10,),
           Container(
             decoration: BoxDecoration(color: Helper.whiteColor),
             child: Padding(
               padding:EdgeInsets.all(8),
               child: Column(
                 crossAxisAlignment:CrossAxisAlignment.start,
                 children: [
                   Text(
                      "施術の保証",
                      style: defaultTextStyle(Helper.titleColor, FontWeight.w700,
                          size: 18.0),
                    ),
                    SizedBox(height: 12,),
                    Text(
                      Menu_Datails[0]["cert"]["label"],
                      overflow: TextOverflow.ellipsis,
                      maxLines:3,
                      style: defaultTextStyle(Helper.maintxtColor, FontWeight.w400,
                          size: 14.0),
                    ),
                    SizedBox(height: 24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 219,
                            height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Helper.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "詳細を表示",
                                  style: defaultTextStyle(
                                      Helper.mainColor, FontWeight.w700,
                                      size: 13),
                                ),
                              ],
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled:true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                context: context,
                                builder: (context) {
                                  return Menu_Sub_Detail_Three(detailList: Menu_Datails[0]["check"],);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
             ],)),
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
                                "クリニック・ドクター",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: 0,),
                            ],
                          ),
                        ),
                        ListView.builder(
                            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                            itemCount: Menu_Datails[0]["doctors"].length,
                            physics:NeverScrollableScrollPhysics(),
                            shrinkWrap:true,
                            itemBuilder: (BuildContext context, int index) {
                               return  Doctor_Card(
                                image: Menu_Datails[0]["doctors"][index]["image"],
                                post: Menu_Datails[0]["doctors"][index]["post"],
                                name: Menu_Datails[0]["doctors"][index]["name"],
                                mark: Menu_Datails[0]["doctors"][index]["mark"],
                                day: Menu_Datails[0]["doctors"][index]["day"],
                                clinic: Menu_Datails[0]["doctors"][index]["clinic"]);
                            }),
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
                                "この施術の日記",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: 0,),
                            ],
                          ),
                        ),
                        ListView.builder(
                            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                            itemCount: Menu_Datails[0]["diarys"].length,
                            physics:NeverScrollableScrollPhysics(),
                            shrinkWrap:true,
                            itemBuilder: (BuildContext context, int index) {
                              return Diary_Card(
                                avator: Menu_Datails[0]["diarys"][index]["avator"],
                                check: Menu_Datails[0]["diarys"][index]["check"],
                                image2: Menu_Datails[0]["diarys"][index]["image2"],
                                image1: Menu_Datails[0]["diarys"][index]["image1"],
                                eyes: Menu_Datails[0]["diarys"][index]["eyes"],
                                clinic: Menu_Datails[0]["diarys"][index]["clinic"],
                                name: Menu_Datails[0]["diarys"][index]["name"],
                                onpress: () {},
                                price: Menu_Datails[0]["diarys"][index]["price"],
                                sentence: Menu_Datails[0]["diarys"][index]["sentence"],
                                type: Menu_Datails[0]["diarys"][index]["type"],
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        Menu_Datails[0]["price"],
                        style: defaultTextStyle(Helper.priceColor, FontWeight.w700,
                            size: 24.0),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        Menu_Datails[0]["tax"],
                        style: defaultTextStyle(
                            Helper.titleColor, FontWeight.w500,
                            size: 12.0),
                      ),
                      SizedBox(
                      height: 2.5,
                    ),
                    
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        isfavourite=!isfavourite;
                      });
                    },
                    child: Row(
                      children: [
                      isfavourite?Icon(Icons.star,color: Helper.btnBgYellowColor,size: 30,)
                      : Icon(Icons.star_border,color: Helper.txtColor,size: 30,),
                      Text(
                        "4.23(102)",
                        style: TextStyle(
                            color: Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],),
                  ),
                ],
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
    );
  }
}

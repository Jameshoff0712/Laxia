import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_one.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_three.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_two.dart';
import 'package:laxia/views/widgets/detail_image.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';
import 'package:laxia/views/widgets/home_card.dart';


class Menu_Detail extends StatefulWidget {
  const Menu_Detail({Key? key}) : super(key: key);

  @override
  State<Menu_Detail> createState() => _Menu_DetailState();
}

class _Menu_DetailState extends State<Menu_Detail> {
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
    return Menu_Datails.isNotEmpty?Scaffold(
     backgroundColor:Helper.homeBgColor,
      body: Menu_Datails.isNotEmpty? SingleChildScrollView(
        physics:AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          InkWell(
            onTap:(){
              Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget( onBoardingInstructions: [
                  for (int j = 0; j < Menu_Datails[0]["images"].length; j++)
                    Menu_Datails[0]["images"][j]
                ],
                startindex: 1,)));
            },
            child: Detail_Image(
                    insidestar: true,
                    height: 375,
                    imageList: Menu_Datails[0]["images"], onPressUpRight: () {  }, onPressBack: () {
                      Navigator.of(context).pop();
                      },
                    onStar: (){
                      setState(() {
                        isfavourite=!isfavourite;
                      });
                      print("add favorite");
                    },
                  ),
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
           SizedBox(height: 5,),
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
                      style: defaultTextStyle(Helper.titleColor, FontWeight.w400,
                          size: 14.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                              height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Helper.mainColor,width: 1),
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
                    ),
             ],)),
           ),
           SizedBox(height: 5,),
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
                            style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w400)  
                        )),  
                      ], 
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('抜糸',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700)),),  
                        DataCell(Text(Menu_Datails[0]["description"]["children"][1], style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w400)  )),  
                        ]),
                        DataRow(cells: [
                          DataCell(Text('施術後の通院',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700))),  
                        DataCell(Text(Menu_Datails[0]["description"]["children"][2], style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w400)  )),  
                        ]),
                        DataRow(cells: [
                          DataCell(Text('腫れ',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700))),  
                        DataCell(Text(Menu_Datails[0]["description"]["children"][3], style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w400)  )),  
                        ])
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                              height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Helper.mainColor,width: 1),
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
                    ),
             ],)),
           ),
           SizedBox(height: 5,),
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
                          "施術の流れ",
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
                                     child: Center(child: Text(index.toString(),style:TextStyle(fontSize: 10,color: Helper.whiteColor, fontWeight: FontWeight.w400))),
                                   ),
                                   SizedBox(width: 12,),
                                   Text(
                                      Menu_Datails[0]["follow"][index]["label"],style:TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700)
                                   ),
                                 ],),
                                 Text(
                                      Menu_Datails[0]["follow"][index]["value"].toString()+"分",style:TextStyle(fontSize: 12,color: Helper.titleColor, fontWeight: FontWeight.w400)
                                   ),
                             ],),
                           ),
                         );
                       }
                       
                        ),
                   )
             ],)),
           ),
           SizedBox(height: 5,),
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
                      style: defaultTextStyle(Helper.titleColor, FontWeight.w400,
                          size: 14.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                              height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Helper.mainColor,width: 1),
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
                    ),
             ],)),
           ),
            SizedBox(height: 5,),
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
                               return  InkWell(
                                 onTap: (){
                                   Navigator.of(context).push( MaterialPageRoute(builder: (_) =>Doctor_Detail()));
                                 },
                                 child: Container(
                                   child: Row(
                                     children: [
                                       Expanded(
                                         child: Doctor_Card(
                                           onpress: (){
                                           },
                                          image: Menu_Datails[0]["doctors"][index]["image"],
                                          post: Menu_Datails[0]["doctors"][index]["post"],
                                          name: Menu_Datails[0]["doctors"][index]["name"],
                                          mark: Menu_Datails[0]["doctors"][index]["mark"],
                                          day: Menu_Datails[0]["doctors"][index]["day"],
                                          clinic: Menu_Datails[0]["doctors"][index]["clinic"]),
                                       ),
                                        Icon(Icons.arrow_forward_ios_outlined,size: 15,),
                                        SizedBox(width: 20,)
                                     ],
                                   ),
                                 ),
                               );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
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
                        // ListView.builder(
                        //     padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                        //     itemCount: Menu_Datails[0]["diarys"].length,
                        //     physics:NeverScrollableScrollPhysics(),
                        //     shrinkWrap:true,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return Diary_Card(
                        //         avator: Menu_Datails[0]["diarys"][index]["avator"],
                        //         check: Menu_Datails[0]["diarys"][index]["check"],
                        //         image2: Menu_Datails[0]["diarys"][index]["image2"],
                        //         image1: Menu_Datails[0]["diarys"][index]["image1"],
                        //         eyes: Menu_Datails[0]["diarys"][index]["eyes"],
                        //         clinic: Menu_Datails[0]["diarys"][index]["clinic"],
                        //         name: Menu_Datails[0]["diarys"][index]["name"],
                        //         onpress: () {
                        //           Navigator.of(context).push( MaterialPageRoute(builder: (_) =>Diary_Detail()));
                        //         },
                        //         price: Menu_Datails[0]["diarys"][index]["price"],
                        //         sentence: Menu_Datails[0]["diarys"][index]["sentence"],
                        //         type: Menu_Datails[0]["diarys"][index]["type"],
                        //       );
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio:175/291,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          itemCount: Menu_Datails[0]["home"].length,
                          itemBuilder: (BuildContext context, int index) {
                              return Home_Card(
                                onpress: () {
                                },
                                title: Menu_Datails[0]["home"][index]["title"],
                                type: Menu_Datails[0]["home"][index]["type"],
                                clinic: Menu_Datails[0]["home"][index]["clinic"],
                                recommend: Menu_Datails[0]["home"][index]["recommend"],
                                source: Menu_Datails[0]["home"][index]["source"],
                                name: Menu_Datails[0]["home"][index]["name"],
                                doctorimage: Menu_Datails[0]["home"][index]["doctorimage"],
                                chat: Menu_Datails[0]["home"][index]["chat"],
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
      ):Container(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 90,
          padding: EdgeInsets.all(10),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        width: 2.5,
                      ),
                      
                      ],
                    ),
                    Row(
                      children: [
                      isfavourite?Icon(Icons.star,color: Helper.btnBgYellowColor,size: 25,)
                      : Icon(Icons.star_border,color: Helper.txtColor,size: 25,),
                      Text(
                        "4.23(102)",
                        style: TextStyle(
                            color: Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],),
                  ],
                ),
                SizedBox(
                  width: 170,
                  height: 44,
                  child: ElevatedButton(
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
                      Navigator.of(context).pushNamed("/Reservation");
                    },
                  ),
                ),
          ],),
        ),
      ),
    ):Container();
  }
}

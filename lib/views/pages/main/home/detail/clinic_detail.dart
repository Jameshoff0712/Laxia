import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_medialist.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_pos.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_sub_detail.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/detail_image.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/doctor_group_card.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';

class Clinic_Detail extends StatefulWidget {
  const  Clinic_Detail({Key? key}) : super(key: key);

  @override
  State<Clinic_Detail> createState() => _Clinic_DetailState();
}

class _Clinic_DetailState extends State<Clinic_Detail> {
   List clinic_Details = [];
   bool isfavourite=false;
  Future<void> get_Clinic_Details() async {
    String mid = await rootBundle.loadString("assets/cfg/detail_clinic.json");
    setState(() {
      clinic_Details.addAll(json.decode(mid));
      isfavourite=clinic_Details[0]["favourite"];
    });
  }
  @override
  void initState() {
    get_Clinic_Details();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print(clinic_Details[0]);
    return clinic_Details.isNotEmpty? Scaffold(
     backgroundColor:Helper.homeBgColor,
      body:clinic_Details.isNotEmpty? SingleChildScrollView(
        physics:AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Helper.whiteColor,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_MediaList(clinic_list:  clinic_Details[0]["images"],)));
                        },
                        child: Detail_Image(
                          height: 200,
                          imageList: clinic_Details[0]["images"], onPressUpRight: () {  }, onPressBack: () {  },
                        ),
                      ),
                      Clinic_Card(
                          posPress: (){
                            Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Pos(pos: "")));
                          },
                          onpress: (){},
                          image: "none",
                          pos:clinic_Details[0]["clinic"],
                          name: clinic_Details[0]["name"],
                          mark: clinic_Details[0]["mark"],
                          day: "",
                          post: "")
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 170,right: 18),
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:  clinic_Details[0]["hopsMarker"],
                          placeholder: (context, url) => Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color:Helper.whiteColor,
              padding: EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 2,)));
                    },
                    child: Column(children: [
                      Text(
                        clinic_Details[0]["items"][0].toString(),
                        style: TextStyle(
                            color:
                                Helper.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "メニュー",
                        style: TextStyle(
                            color:
                                Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 3,)));
                    },
                    child: Column(children: [
                      Text(
                        clinic_Details[0]["items"][1].toString(),
                        style: TextStyle(
                            color:
                                Helper.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "日記",
                        style: TextStyle(
                            color:
                                Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 4,)));
                    },
                    child: Column(children: [
                      Text(
                       clinic_Details[0]["items"][2].toString(),
                        style: TextStyle(
                            color:
                                Helper.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "カウセレポ",
                        style: TextStyle(
                            color:
                                Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 1,)));
                    },
                    child: Column(children: [
                      Text(
                        clinic_Details[0]["items"][3].toString(),
                        style: TextStyle(
                            color:
                                Helper.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "ドクター",
                        style: TextStyle(
                            color:
                                Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],),
                  ),
              ],),
            ),
            SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ドクター",
                        style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                                Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 1,)));
                              },
                        child: Row(
                          children: [
                            Text(
                              "14名のドクター",
                              style: TextStyle(
                                  color: Color.fromARGB(
                                      255, 156, 161, 161),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              Icons.navigate_next,
                              size: 15,
                              color:
                                  Color.fromARGB(255, 156, 161, 161),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    height:120,
                    child: GridView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio:110/87,
                          crossAxisCount: 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0),
                      itemCount: clinic_Details[0]["doctors"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Doctor_Group_Card(doctor: clinic_Details[0]["doctors"][index], onpress: () {
                          Navigator.of(context).pushNamed("/Doctor_Detail");
                        },);
                      }),
                  ),
                ),
              ]),
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
                                "メニュー",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 2,)));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "すべてのメニュー",
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
                            itemCount: clinic_Details[0]["menus"].length,
                            // physics: const AlwaysScrollableScrollPhysics(),
                            // scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return Menu_Card(
                                onpress:(){
                                   Navigator.of(context).pushNamed("/Menu_Detail");
                                },
                                shadow: BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                                  image: clinic_Details[0]["menus"][index]
                                      ["image"],
                                  heading: clinic_Details[0]["menus"][index]
                                      ["heading"],
                                  price: clinic_Details[0]["menus"][index]
                                      ["price"],
                                  tax: clinic_Details[0]["menus"][index]["tax"],
                                  clinic: clinic_Details[0]["menus"][index]
                                      ["clinic"]);
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 2,)));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "すべてのメニュー",
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
                            ),
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
                                "日記",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 3,)));
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
                          itemCount: clinic_Details[0]["home"].length,
                          itemBuilder: (BuildContext context, int index) {
                              return Home_Card(
                                onpress: () {
                                   Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 3,)));
                              },
                                title: clinic_Details[0]["home"][index]["title"],
                                type: clinic_Details[0]["home"][index]["type"],
                                clinic: clinic_Details[0]["home"][index]["clinic"],
                                recommend: clinic_Details[0]["home"][index]["recommend"],
                                source: clinic_Details[0]["home"][index]["source"],
                                name: clinic_Details[0]["home"][index]["name"],
                                doctorimage: clinic_Details[0]["home"][index]["doctorimage"],
                                chat: clinic_Details[0]["home"][index]["chat"],
                              );
                              // return Diary_Card(
                              //   avator: clinic_Details[0]["diarys"][index]["avator"],
                              //   check: clinic_Details[0]["diarys"][index]["check"],
                              //   image2: clinic_Details[0]["diarys"][index]["image2"],
                              //   image1: clinic_Details[0]["diarys"][index]["image1"],
                              //   eyes: clinic_Details[0]["diarys"][index]["eyes"],
                              //   clinic: clinic_Details[0]["diarys"][index]["clinic"],
                              //   name: clinic_Details[0]["diarys"][index]["name"],
                              //   onpress: () {
                              //      Navigator.of(context).pushNamed("/Diary_Detail");
                              //   },
                              //   price: clinic_Details[0]["diarys"][index]["price"],
                              //   sentence: clinic_Details[0]["diarys"][index]["sentence"],
                              //   type: clinic_Details[0]["diarys"][index]["type"],
                              // );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push( MaterialPageRoute(builder: (_) => Clinic_Sub_Detail(clinic_Detail: clinic_Details[0], index: 3,)));
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
            SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "クリニック基本情報",
                    style: TextStyle(
                        color: Helper.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "住所",
                        style: TextStyle(
                            color:
                                Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      InkWell(
                        onTap: () {
                          // widget.tabController.animateTo(1);
                        },
                        child: Row(
                          children: [
                            Text(
                             clinic_Details[0]["map_pos"],
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
                Container(
                  decoration: BoxDecoration(color: Helper.whiteColor),
                  child: Text("This is googlemap"),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: DataTable(
                      horizontalMargin: 0,
                      dataTextStyle:TextStyle(),
                      showBottomBorder: true,
                      showCheckboxColumn: false,
                      columnSpacing: 0,
                      columns: [
                      DataColumn(label: Text(  
                          '最寄駅',  
                          style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700)  
                      )),  
                      DataColumn(label: Text(  
                          clinic_Details[0]["clinicname"],  
                          style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  
                      )),  
                    ], 
                    rows: [
                      DataRow(cells: [
                         DataCell(Text('アクセス',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700)),),  
                      DataCell(Text(clinic_Details[0]["access"], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                      ]),
                      DataRow(cells: [
                         DataCell(Text('営業時間',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700),)),  
                      DataCell(Text(clinic_Details[0]["times"], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                      ]),
                      DataRow(cells: [
                         DataCell(Text('営業日',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700))),  
                      DataCell(Text(clinic_Details[0]["workday"], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                      ]),
                      DataRow(cells: [
                         DataCell(Text('電話番号',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700))),  
                      DataCell(Text(clinic_Details[0]["phonenumber"], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                      ]),
                      DataRow(cells: [
                         DataCell(Text('クレジットカード',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700))),  
                      DataCell(Text(clinic_Details[0]["card"], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                      ]),
                       DataRow(cells: [
                         DataCell(Text('駐車場',style: TextStyle(fontSize: 14,color: Helper.titleColor, fontWeight: FontWeight.w700))),  
                      DataCell(Text(clinic_Details[0]["park"], style: TextStyle(fontSize: 14,color: Helper.maintxtColor, fontWeight: FontWeight.w400)  )),  
                      ])
                    ]),
                  ),
                )
              ],)
            )
          ],
        ),
      ):Container(),
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
    ):Scaffold();
  }
}

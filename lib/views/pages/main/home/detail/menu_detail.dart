import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';
import 'package:laxia/models/menu/menudetail_model.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_one.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_three.dart';
import 'package:laxia/views/pages/main/home/detail/menu_sub_detail_two.dart';
import 'package:laxia/views/widgets/detail_image.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';
import 'package:laxia/views/widgets/home_card.dart';

class Menu_Detail extends StatefulWidget {
  final int index;
  const Menu_Detail({Key? key, required this.index}) : super(key: key);

  @override
  State<Menu_Detail> createState() => _Menu_DetailState();
}

class _Menu_DetailState extends State<Menu_Detail> {
  bool isVisible=false,isPostVisible=false;
  bool isloading = true,islike=false;
  final _con = HomeController();
  late MenuDetail_Model menu_detail;
  Future<void> getData() async {
    try {
      final mid = await _con.getMenuDetail(index: widget.index);
      setState(() {
        menu_detail = mid;
         islike=menu_detail.menu.is_favorite==null?false:menu_detail.menu.is_favorite!;
         isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> postToogleLike(index) async {
    try {
      final res=await _con.postToogleLike(index:index, domain: 'diaries');
      if(res==true){
        setState(() {
          islike=!islike;
        });
      }
    } catch (e) {
    }
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Helper.whiteColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Helper.whiteColor,
    ));
    // print(Menu_Datails[0]);
    return isloading
    ? Container(
        child: Container(
        height: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Center(
          child: new CircularProgressIndicator(),
        ),
      ))
    :Scaffold(
            backgroundColor: Helper.homeBgColor,
            body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PageViewWidget(
                                      onBoardingInstructions: [
                                        for (int j = 0;
                                            j <
                                                menu_detail.menu.images!.length;
                                            j++)
                                          menu_detail.menu.images![j].path
                                      ],
                                      startindex: 1,
                                    )));
                          },
                          child: Detail_Image(
                            insidestar: true,
                            height: 375,
                            imageList: menu_detail.menu.images!,
                            onPressUpRight: () {},
                            onPressBack: () {
                              Navigator.of(context).pop();
                            },
                            onStar: () {
                              setState(() {
                                // isfavorite = !isfavorite;
                              });
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Helper.whiteColor),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        menu_detail.menu.price.toString(),
                                        style: defaultTextStyle(
                                            Helper.priceColor, FontWeight.w700,
                                            size: 24.0),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        '（税込）',
                                        style: TextStyle(
                                            color: Helper.titleColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    menu_detail.menu.name,
                                    style: TextStyle(
                                        fontFamily: Helper.headFontFamily,
                                        color: Helper.titleColor,
                                        fontWeight: FontWeight.w700,
                                        
                                        fontSize: 16.0),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        Icon(
                                          Icons.star,
                                          color:menu_detail.menu.avg_rate.round()>=i+1?Helper.starColor:Color.fromARGB(255, 222, 222, 222),
                                          size: 18,
                                        ),
                                      Text(
                                        menu_detail.menu.avg_rate.toString(),
                                        style: defaultTextStyle(
                                            Helper.titleColor, FontWeight.w700,
                                            size: 14.0),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Helper.whiteColor),
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "施術の説明",
                                    style: defaultTextStyle(
                                        Helper.titleColor, FontWeight.w700,
                                        size: 18.0),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    menu_detail.menu.description!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Helper.titleColor,
                                        fontWeight: FontWeight.w400,
                                        height: 25 / 14,
                                        fontSize: 14.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 158,
                                          height: 30,
                                          child: GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Helper.whiteColor,
                                                border: Border.all(color: Helper.mainColor),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                ),
                                              child:
                                                Center(
                                                  child: Text(
                                                    "詳細を表示",
                                                    style: defaultTextStyle(
                                                        Helper.mainColor,
                                                        FontWeight.w700,
                                                        size: 13),
                                                  ),
                                                ),
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    15.0)),
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return Menu_Sub_Detail_Two(
                                                      menu: menu_detail.menu,
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Helper.whiteColor),
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "施術の詳細",
                                    style: defaultTextStyle(
                                        Helper.titleColor, FontWeight.w700,
                                        size: 18.0),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: DataTable(
                                        border: TableBorder(
                                            bottom: BorderSide(
                                                color: Helper.txtColor
                                                    .withOpacity(0.3),
                                                width: 1)),
                                        dataRowHeight: 38,
                                        headingRowHeight: 38,
                                        horizontalMargin: 0,
                                        dataTextStyle: TextStyle(),
                                        showBottomBorder: true,
                                        showCheckboxColumn: false,
                                        columnSpacing: 0,
                                        columns: [
                                          DataColumn(
                                              label: Text('施術時間',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          Helper.headFontFamily,
                                                      
                                                      fontSize: 14,
                                                      color: Helper.titleColor,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text(
                                                  Helper.TreatTime(menu_detail.menu.treat_time!),
                                                  style: TextStyle(
                                                      
                                                      fontSize: 14,
                                                      color: Helper.titleColor,
                                                      fontWeight:
                                                          FontWeight.w400))),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(
                                              Text('抜糸',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          Helper.headFontFamily,
                                                      
                                                      fontSize: 14,
                                                      color: Helper.titleColor,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                            DataCell(Text(
                                                Helper.Basshi(menu_detail.menu.basshi!),
                                                style: TextStyle(
                                                    
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('施術後の通院',
                                                style: TextStyle(
                                                    fontFamily:
                                                        Helper.headFontFamily,
                                                    
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                            DataCell(Text(
                                                Helper.HospitalVisit(menu_detail.menu.hospital_visit!),
                                                style: TextStyle(
                                                    
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('腫れ',
                                                style: TextStyle(
                                                    fontFamily:
                                                        Helper.headFontFamily,
                                                    
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                            DataCell(Text(
                                                Helper.Hare(menu_detail.menu.hare!),
                                                style: TextStyle(
                                                    
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ])
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 158,
                                          height: 30,
                                          child: GestureDetector(
                                           child: Container(
                                              decoration: BoxDecoration(
                                                color: Helper.whiteColor,
                                                border: Border.all(color: Helper.mainColor),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                ),
                                              child:
                                                Center(
                                                  child: Text(
                                                    "詳細を表示",
                                                    style: defaultTextStyle(
                                                        Helper.mainColor,
                                                        FontWeight.w700,
                                                        size: 13),
                                                  ),
                                                ),
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    15.0)),
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return Menu_Sub_Detail_One(
                                                      menu:menu_detail.menu,
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Helper.whiteColor),
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "施術の流れ",
                                        style: defaultTextStyle(
                                            Helper.titleColor, FontWeight.w700,
                                            size: 18.0),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color:
                                              Color.fromARGB(255, 249, 161, 56)
                                                  .withOpacity(0.3),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          child: Text(
                                            "施術時間"+menu_detail.menu.alltime.toString()+"分",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 249, 161, 56),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            menu_detail.process.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: index % 2 == 0
                                                    ? Helper.homeBgColor
                                                    : Helper.whiteColor),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 7),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 14,
                                                        height: 14,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            color: Helper
                                                                .mainColor),
                                                        child: Center(
                                                            child: Text(index.toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Helper
                                                                        .whiteColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400))),
                                                      ),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                          menu_detail.process[index].title,
                                                          style: TextStyle(
                                                              
                                                              fontSize: 12,
                                                              color: Helper
                                                                  .titleColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    ],
                                                  ),
                                                  Text(
                                                      menu_detail.process[index].period.toString() + "分",
                                                      style: TextStyle(
                                                          
                                                          fontSize: 12,
                                                          color:
                                                              Helper.titleColor,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Helper.whiteColor),
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "施術の保証",
                                    style: defaultTextStyle(
                                        Helper.titleColor, FontWeight.w700,
                                        size: 18.0),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    menu_detail.menu.guarantee!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Helper.titleColor,
                                        fontWeight: FontWeight.w400,
                                        height: 25 / 14,
                                        fontSize: 14.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 158,
                                          height: 30,
                                          child: GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Helper.whiteColor,
                                                border: Border.all(color: Helper.mainColor),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                ),
                                              child:
                                                Center(
                                                  child: Text(
                                                    "詳細を表示",
                                                    style: defaultTextStyle(
                                                        Helper.mainColor,
                                                        FontWeight.w700,
                                                        size: 13),
                                                  ),
                                                ),
                                            ),
                                            onTap: () {
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    15.0)),
                                                  ),
                                                  context: context,
                                                  builder: (context) {
                                                    return Menu_Sub_Detail_Three(
                                                      menu:menu_detail.menu,
                                                    );
                                                  });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Helper.whiteColor),
                          child: Column(
                            children: [
                              Container(
                                decoration:
                                    BoxDecoration(color: Helper.whiteColor),
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
                                                fontFamily:
                                                    Helper.headFontFamily,
                                                
                                                color: Color.fromARGB(
                                                    255, 51, 51, 51),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        //  Navigator.of(context).push( MaterialPageRoute(builder: (_) =>Doctor_Detail()));
                                      },
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Doctor_Card(
                                                  onpress: () {},
                                                  image: menu_detail.menu.clinic!.photo!,
                                                  name: menu_detail.menu.clinic!.name!,
                                                  mark: menu_detail.menu.clinic!.avg_rate.toString(),
                                                  day: menu_detail.menu.clinic!.diaries_count.toString(),
                                                  clinic: menu_detail.menu.clinic!.addr01!),
                                            ),
                                            Icon(
                                              Icons
                                                  .arrow_forward_ios_outlined,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Helper.whiteColor),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.center,
                                    colors: [
                                      Colors.white,
                                      Helper.homeBgColor,
                                    ],
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    menu_detail.diaries.isEmpty?Container()
                                    :Container(
                                      color: Helper.whiteColor,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "この施術の日記",
                                              style: TextStyle(
                                                  fontFamily:
                                                      Helper.headFontFamily,
                                                  
                                                  color: Color.fromARGB(
                                                      255, 51, 51, 51),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            menu_detail.diaries.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Diary_Card(
                                            avator:
                                                menu_detail.diaries[index].patient_photo == null
                                                    ? "http://error.png"
                                                    : menu_detail.diaries[index].patient_photo!,
                                            check: menu_detail.diaries[index].doctor_name == null
                                                ? ""
                                                : menu_detail.diaries[index].doctor_name!,
                                            image2: menu_detail.diaries[index].after_image == null
                                                ? "http://error.png"
                                                : menu_detail.diaries[index].after_image!,
                                            image1:
                                                menu_detail.diaries[index].before_image == null
                                                    ? "http://error.png"
                                                    : menu_detail.diaries[index].before_image!,
                                            eyes: menu_detail.diaries[index].views_count == null
                                                ? ""
                                                : menu_detail.diaries[index].views_count!
                                                    .toString(),
                                            clinic: menu_detail.diaries[index].clinic_name == null
                                                ? ""
                                                : menu_detail.diaries[index].clinic_name!,
                                            name: menu_detail.diaries[index].patient_nickname ==
                                                    null
                                                ? ""
                                                : menu_detail.diaries[index].patient_nickname!,
                                            onpress: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (_) => Diary_Detail(
                                                      index: menu_detail.diaries[index].id)));
                                            },
                                            price: menu_detail.diaries[index].price == null
                                                ? ""
                                                : menu_detail.diaries[index].price.toString(),
                                            sentence:
                                                menu_detail.diaries[index].doctor_name == null
                                                    ? ""
                                                    : menu_detail.diaries[index].doctor_name!,
                                            type: menu_detail.diaries[index].doctor_name == null
                                                ? ""
                                                : menu_detail.diaries[index].doctor_name!,
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
              color: Helper.whiteColor,
              child: SafeArea(
                child: Container(
                  height: 76,
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
                                menu_detail.menu.price.toString()+"円",
                                style: defaultTextStyle(
                                    Helper.priceColor, FontWeight.w700,
                                    size: 18.0),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                '（税込）',
                                style: TextStyle(
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w500,
                                    
                                    fontSize: 12.0),
                              ),
                              SizedBox(
                                width: 2.5,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    postToogleLike(widget.index);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      islike
                                          ? SvgPicture.asset(
                                              "assets/icons/star.svg",
                                              width: 16,
                                              height: 16,
                                              color: Helper.starColor,
                                            )
                                          : SvgPicture.asset(
                                              "assets/icons/borderstar.svg",
                                              width: 16,
                                              height: 16,
                                              // color: Colors.red,
                                              color: Color.fromARGB(255, 155, 155, 155),
                                            ),
                                    ],
                                  ),
                                ),
                              SizedBox(width: 5,),
                              Text(
                                menu_detail.menu.avg_rate.toString()+"("+menu_detail.diaries.length.toString()+")",
                                style: TextStyle(
                                  height: 1,
                                    color: Helper.titleColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/Reservation");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Helper.btnBgYellowColor),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Text(
                              "クリニックを予約",
                              style: defaultTextStyle(
                                  Helper.whiteColor, FontWeight.w700,
                                  size: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

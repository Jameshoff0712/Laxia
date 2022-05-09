import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/clinic/clinicdetail_model.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_medialist.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_pos.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_sub_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/detail_image.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/doctor_group_card.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';

class Clinic_Detail extends StatefulWidget {
  final int index;
  const Clinic_Detail({Key? key, required this.index}) : super(key: key);

  @override 
  State<Clinic_Detail> createState() => _Clinic_DetailState();
}

class _Clinic_DetailState extends State<Clinic_Detail> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(35.6674466, 139.7396131);

  bool isfavourite = false, isloading = true;
  final _con = HomeController();
  late ClinicDetail_Model clinic_detail;
  Future<void> getData({required int index}) async {
    try {
      final mid = await _con.getClinicDetail(index: index);
      setState(() {
        clinic_detail = mid;
         isfavourite=clinic_detail.clinic.is_favorite==null?false:clinic_detail.clinic.is_favorite!;
         isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> postToogleFavorite(index) async {
    try {
      final res=await _con.postToogleFavorite(index:index, domain: 'clinics');
      if(res==true){
        setState(() {
          isfavourite=!isfavourite;
        });
      }
    } catch (e) {
    }
  }
  @override
  void initState() {
    getData(index: widget.index);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // print(clinic_detail);
    return isloading
        ? Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ))
        : Scaffold(
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
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => Clinic_MediaList(
                                                    clinic_list:
                                                     [
                                                        for (int j = 0; j < clinic_detail.images.length; j++)
                                                        clinic_detail.images[j].path
                                                      ],
                                                        
                                                  )));
                                    },
                                    child: Detail_Image(
                                      height: 200,
                                      imageList:[
                                                  for (int j = 0; j < clinic_detail.images.length; j++)
                                                  clinic_detail.images[j].path
                                                ],
                                      onPressUpRight: () {},
                                      onPressBack: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  Clinic_Card(
                                      posPress: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Clinic_Pos(pos: "")));
                                      },
                                      onpress: () {},
                                      image: "none",
                                      location: clinic_detail.clinic.address==null?"": clinic_detail.clinic.address!,
                                      name:clinic_detail.clinic.name==null?"": clinic_detail.clinic.name!,
                                      mark: 4.8.toString(),// clinic_detail.clinic.mark
                                      day: "",
                                      post: "")
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 170, right: 18),
                                child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: clinic_detail.clinic.photo,
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
                            ],
                          ),
                        ),
                        Container(
                          color: Helper.whiteColor,
                          padding: EdgeInsets.only(bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Clinic_Sub_Detail(
                                            clinic_Detail: clinic_detail,
                                            index: 2,
                                          )));
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      clinic_detail.menu.length.toString(),
                                      style: TextStyle(
                                          color: Helper.blackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "メニュー",
                                      style: TextStyle(
                                          color: Helper.titleColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Clinic_Sub_Detail(
                                            clinic_Detail: clinic_detail,
                                            index: 3,
                                          )));
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      clinic_detail.diaries.length.toString(),
                                      style: TextStyle(
                                          color: Helper.blackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "日記",
                                      style: TextStyle(
                                          color: Helper.titleColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Clinic_Sub_Detail(
                                            clinic_Detail: clinic_detail,
                                            index: 4,
                                          )));
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      clinic_detail.counselings.length.toString(),
                                      style: TextStyle(
                                          color: Helper.blackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "カウセレポ",
                                      style: TextStyle(
                                          color: Helper.titleColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Clinic_Sub_Detail(
                                            clinic_Detail: clinic_detail,
                                            index: 1,
                                          )));
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      clinic_detail.doctors.length.toString(),
                                      style: TextStyle(
                                          color: Helper.blackColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "ドクター",
                                      style: TextStyle(
                                          color: Helper.titleColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
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
                          child: Column(children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => Clinic_Sub_Detail(
                                                    clinic_Detail:
                                                        clinic_detail,
                                                    index: 1,
                                                  )));
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
                                          color: Color.fromARGB(
                                              255, 156, 161, 161),
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
                                height: 120,
                                child: GridView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8),
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 110 / 87,
                                            crossAxisCount: 1,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 0),
                                    itemCount:
                                        clinic_detail.doctors.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Doctor_Group_Card(
                                        doctor: clinic_detail.doctors[index],
                                        onpress: () {
                                          Navigator.of(context)
                                              .pushNamed("/clinic_detail");
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ]),
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
                                            "メニュー",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 51, 51),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (_) =>
                                              //             Clinic_Sub_Detail(
                                              //               clinic_Detail:
                                              //                   clinic_Details[
                                              //                       0],
                                              //               index: 2,
                                              //             )));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "すべてのメニュー",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 156, 161, 161),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                        itemCount:
                                            clinic_detail.menu.length,
                                        // physics: const AlwaysScrollableScrollPhysics(),
                                        // scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Menu_Card(
                                            onpress: (){
                                              // Navigator.of(context).pushNamed("/Menu_Detail");
                                              // Navigator.of(context).push( MaterialPageRoute(builder: (_) => Menu_Detail(Menu_Datails: clinic_detail.menu[index])));
                                            },
                                              image: clinic_detail.menu[index].images!.isEmpty?"http://error.png": clinic_detail.menu[index].images![0].path,
                                              heading: clinic_detail.menu[index].description==null?"":clinic_detail.menu[index].description!,
                                              price: clinic_detail.menu[index].price==0?"":clinic_detail.menu[index].price!.toString(),
                                              clinic: clinic_detail.menu[index].name
                                            );
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (_) =>
                                              //             Clinic_Sub_Detail(
                                              //               clinic_Detail:
                                              //                   clinic_Details[
                                              //                       0],
                                              //               index: 2,
                                              //             )));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "すべてのメニュー",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 156, 161, 161),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                            "日記",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 51, 51),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (_) =>
                                              //             Clinic_Sub_Detail(
                                              //               clinic_Detail:
                                              //                   clinic_Details[
                                              //                       0],
                                              //               index: 3,
                                              //             )));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "すべての日記",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 156, 161, 161),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 175 / 291,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemCount:
                                            clinic_detail.diaries.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // return Home_Card(
                                          //   onpress: () {
                                          //     // Navigator.of(context).push(
                                          //     //     MaterialPageRoute(
                                          //     //         builder: (_) =>
                                          //     //             Clinic_Sub_Detail(
                                          //     //               clinic_Detail:
                                          //     //                   clinic_Details[
                                          //     //                       0],
                                          //     //               index: 3,
                                          //     //             )));
                                          //   },
                                          //   title: clinic_detail["home"]
                                          //       [index]["title"],
                                          //   type: clinic_detail["home"]
                                          //       [index]["type"],
                                          //   clinic: clinic_detail["home"]
                                          //       [index]["clinic"],
                                          //   recommend: clinic_detail["home"]
                                          //       [index]["recommend"],
                                          //   source: clinic_detail["home"]
                                          //       [index]["source"],
                                          //   name: clinic_detail["home"]
                                          //       [index]["name"],
                                          //   doctorimage: clinic_detail
                                          //       ["home"][index]["doctorimage"],
                                          //   chat: clinic_detail["home"]
                                          //       [index]["chat"],
                                          // );
                                          return Diary_Card(
                                            avator:
                                                clinic_detail.diaries[index].patient_photo == null
                                                    ? "http://error.png"
                                                    : clinic_detail.diaries[index].patient_photo!,
                                            check: clinic_detail.diaries[index].doctor_name == null
                                                ? ""
                                                : clinic_detail.diaries[index].doctor_name!,
                                            image2: clinic_detail.diaries[index].after_image == null
                                                ? "http://error.png"
                                                : clinic_detail.diaries[index].after_image!,
                                            image1:
                                                clinic_detail.diaries[index].before_image == null
                                                    ? "http://error.png"
                                                    : clinic_detail.diaries[index].before_image!,
                                            eyes: clinic_detail.diaries[index].views_count == null
                                                ? ""
                                                : clinic_detail.diaries[index].views_count!
                                                    .toString(),
                                            clinic: clinic_detail.diaries[index].clinic_name == null
                                                ? ""
                                                : clinic_detail.diaries[index].clinic_name!,
                                            name: clinic_detail.diaries[index].patient_nickname ==
                                                    null
                                                ? ""
                                                : clinic_detail.diaries[index].patient_nickname!,
                                            onpress: () {
                                              Navigator.of(context)
                                                  .pushNamed("/Diary_Detail");
                                            },
                                            price: clinic_detail.diaries[index].price == null
                                                ? ""
                                                : clinic_detail.diaries[index].price.toString(),
                                            sentence:
                                                clinic_detail.diaries[index].doctor_name == null
                                                    ? ""
                                                    : clinic_detail.diaries[index].doctor_name!,
                                            type: clinic_detail.diaries[index].doctor_name == null
                                                ? ""
                                                : clinic_detail.diaries[index].doctor_name!,
                                          );
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          Clinic_Sub_Detail(
                                                            clinic_Detail:
                                                                 [
                                                                    0],
                                                            index: 3,
                                                          )));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "すべての日記",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 156, 161, 161),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            decoration: BoxDecoration(color: Helper.whiteColor),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "クリニック基本情報",
                                    style: TextStyle(
                                        color: Helper.blackColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
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
                                              clinic_detail.clinic.addr01==null?"":clinic_detail.clinic.addr01!,
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
                                  decoration:
                                      BoxDecoration(color: Helper.whiteColor),
                                  height: 300,
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    onMapCreated: _onMapCreated,
                                    initialCameraPosition: CameraPosition(
                                      target: _center,
                                      zoom: 15.0,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: MarkerId('current'),
                                        position: _center,
                                      )
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: DataTable(
                                        horizontalMargin: 0,
                                        dataTextStyle: TextStyle(),
                                        showBottomBorder: true,
                                        showCheckboxColumn: false,
                                        columnSpacing: 0,
                                        columns: [
                                          DataColumn(
                                              label: Text('最寄駅',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Helper.titleColor,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text(
                                                  'clinic_detail["clinicname"]',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Helper.maintxtColor,
                                                      fontWeight:
                                                          FontWeight.w400))),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(
                                              Text('アクセス',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Helper.titleColor,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                            DataCell(Text(
                                                'clinic_detail["access"]',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.maintxtColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text(
                                              '営業時間',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Helper.titleColor,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                            DataCell(Text(
                                                'clinic_detail["times"]',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.maintxtColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('営業日',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                            DataCell(Text(
                                               ' clinic_detail["workday"]',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.maintxtColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('電話番号',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                            DataCell(Text(
                                                'clinic_detail["phonenumber"]',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.maintxtColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('クレジットカード',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                            DataCell(Text(
                                                'clinic_detail["card"]',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.maintxtColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text('駐車場',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.titleColor,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                            DataCell(Text(
                                                'clinic_detail["park"]',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Helper.maintxtColor,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                          ])
                                        ]),
                                  ),
                                )
                              ],
                            ))
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
                        setState(() {
                          isfavourite = !isfavourite;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          isfavourite
                              ? Icon(
                                  Icons.star,
                                  color: Helper.btnBgYellowColor,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.star_border,
                                  color: Helper.txtColor,
                                  size: 30,
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

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
}

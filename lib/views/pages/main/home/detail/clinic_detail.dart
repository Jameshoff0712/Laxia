import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/clinic/clinicdetail_model.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_medialist.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_pos.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_sub_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
import 'package:laxia/views/pages/main/reservation/reservation.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/detail_image.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/doctor_group_card.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:provider/provider.dart';

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
  List<Category> categories = [];
  Future<void> getData({required int index}) async {
    try {
      final mid = await _con.getClinicDetail(index: index);
      setState(() {
        clinic_detail = mid;
        isfavourite = clinic_detail.clinic.is_favorite == null
            ? false
            : clinic_detail.clinic.is_favorite!;
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

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

  String getFreeday() {
    String mid = '';
    for (int i = 0; i < clinic_detail.clinic.work_times!.length; i++)
      if (clinic_detail.clinic.work_times![i].type == 1) {
        mid += clinic_detail.clinic.work_times![i].weekday + ' ';
      }
    return mid;
  }

  void addCategory(Category cate) {
    for (int i = 0; i < categories.length; i++) {
      if (cate.id == categories[i].id) {
        return;
      }
    }
    setState(() {
      categories.add(cate);
    });
  }

  @override
  void initState() {
    getData(index: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Helper.whiteColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Helper.whiteColor,
    ));
    if (!isloading) {
      for (int i = 0; i < clinic_detail.doctors.length; i++) {
        for (int j = 0; j < clinic_detail.doctors[i].categories!.length; j++) {
          addCategory(clinic_detail.doctors[i].categories![j]);
        }
      }
    }
    return isloading
        ? Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Color.fromARGB(0, 10, 9, 9),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Clinic_MediaList(
                                          clinic_list: [
                                            for (int j = 0;
                                                j < clinic_detail.images.length;
                                                j++)
                                              clinic_detail.images[j].path
                                          ],
                                        )));
                              },
                              child: Detail_Image(
                                height: 200,
                                imageList: clinic_detail.images,
                                onPressUpRight: () {},
                                onPressBack: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Clinic_Card(
                                posPress: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => Clinic_Pos(pos: "")));
                                },
                                onpress: () {},
                                image: "none",
                                location: clinic_detail.clinic.address == null
                                    ? ""
                                    : clinic_detail.clinic.address!,
                                name: clinic_detail.clinic.name == null
                                    ? ""
                                    : clinic_detail.clinic.name!,
                                mark: double.parse(
                                        (clinic_detail.clinic.avg_rate)!
                                            .toStringAsFixed(1))
                                    .toString(),
                                day: "",
                                post: "")
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 170, right: 18),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: clinic_detail.clinic.photo,
                                placeholder: (context, url) => Image.asset(
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
                    padding: EdgeInsets.only(bottom: 25, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Clinic_Sub_Detail(
                                      clinic_Detail: clinic_detail,
                                      index: 2,
                                      categories: categories,
                                    )));
                          },
                          child: Column(
                            children: [
                              Text(
                                clinic_detail.menu.length.toString(),
                                style: TextStyle(
                                    fontFamily: Helper.headFontFamily,
                                    color: Helper.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 2),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Clinic_Sub_Detail(
                                      categories: categories,
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
                              SizedBox(height: 2),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Clinic_Sub_Detail(
                                      categories: categories,
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
                              SizedBox(height: 2),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Clinic_Sub_Detail(
                                      categories: categories,
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
                              SizedBox(height: 2),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "ドクター",
                              style: TextStyle(
                                  fontFamily: Helper.headFontFamily,
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Clinic_Sub_Detail(
                                          categories: categories,
                                          clinic_Detail: clinic_detail,
                                          index: 1,
                                        )));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    clinic_detail.doctors.length.toString() +
                                        "名のドクター",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Helper.maintxtColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    size: 20,
                                    color: Helper.maintxtColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 118,
                          child: GridView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 110 / 80,
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 0),
                              itemCount: clinic_detail.doctors.length,
                              itemBuilder: (BuildContext context, int index) {
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
                      SizedBox(
                        height: 15,
                      )
                    ]),
                  ),
                  clinic_detail.menu.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 5,
                        ),
                  clinic_detail.menu.isEmpty
                      ? Container()
                      : Container(
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
                                                fontFamily:
                                                    Helper.headFontFamily,
                                                color: Color.fromARGB(
                                                    255, 51, 51, 51),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          Clinic_Sub_Detail(
                                                            categories:
                                                                categories,
                                                            clinic_Detail:
                                                                clinic_detail,
                                                            index: 2,
                                                          )));
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "すべてのメニュー",
                                                  style: TextStyle(
                                                      color:
                                                          Helper.maintxtColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Icon(
                                                  Icons.navigate_next,
                                                  size: 20,
                                                  color: Helper.maintxtColor,
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
                                        itemCount: clinic_detail.menu.length,
                                        // physics: const AlwaysScrollableScrollPhysics(),
                                        // scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Menu_Card(
                                              shadow: BoxShadow(
                                                color: Color.fromARGB(255, 238,
                                                    238, 238), //color of shadow
                                                spreadRadius: 1, //spread radius
                                                offset: Offset(0,
                                                    0), // changes position of shadow
                                                //first paramerter of offset is left-right
                                                //second parameter is top to down
                                              ),
                                              onpress: () {
                                                // Navigator.of(context).pushNamed("/Menu_Detail");
                                                // Navigator.of(context).push( MaterialPageRoute(builder: (_) => Menu_Detail(Menu_Datails: clinic_detail.menu[index])));
                                              },
                                              image: clinic_detail.menu[index]
                                                      .images!.isEmpty
                                                  ? "http://error.png"
                                                  : clinic_detail.menu[index]
                                                      .images![0].path,
                                              heading: clinic_detail.menu[index]
                                                          .description ==
                                                      null
                                                  ? ""
                                                  : clinic_detail
                                                      .menu[index].description!,
                                              price: clinic_detail
                                                          .menu[index].price ==
                                                      0
                                                  ? ""
                                                  : clinic_detail
                                                      .menu[index].price!
                                                      .toString(),
                                              clinic: clinic_detail
                                                  .menu[index].name);
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
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
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                Clinic_Sub_Detail(
                                                                  categories:
                                                                      categories,
                                                                  clinic_Detail:
                                                                      clinic_detail,
                                                                  index: 2,
                                                                )));
                                                  },
                                                  child: Text(
                                                    "すべてのメニュー",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 156, 161, 161),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 19,
                                                ),
                                                Icon(
                                                  Icons.navigate_next,
                                                  size: 20,
                                                  color: Helper.maintxtColor,
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
                  clinic_detail.diaries.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 5,
                        ),
                  clinic_detail.diaries.isEmpty
                      ? Container()
                      : Container(
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
                                                fontFamily:
                                                    Helper.headFontFamily,
                                                color: Color.fromARGB(
                                                    255, 51, 51, 51),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          Clinic_Sub_Detail(
                                                            categories:
                                                                categories,
                                                            clinic_Detail:
                                                                clinic_detail,
                                                            index: 3,
                                                          )));
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "すべての日記",
                                                  style: TextStyle(
                                                      color:
                                                          Helper.maintxtColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Icon(
                                                  Icons.navigate_next,
                                                  size: 20,
                                                  color: Helper.maintxtColor,
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
                                        // physics: const AlwaysScrollableScrollPhysics(),
                                        // scrollDirection: Axis.horizontal,
                                        itemCount: clinic_detail.diaries.length,
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
                                            avator: clinic_detail.diaries[index]
                                                        .patient_photo ==
                                                    null
                                                ? "http://error.png"
                                                : clinic_detail.diaries[index]
                                                    .patient_photo!,
                                            check: clinic_detail.diaries[index]
                                                        .doctor_name ==
                                                    null
                                                ? ""
                                                : clinic_detail.diaries[index]
                                                    .doctor_name!,
                                            image2: clinic_detail.diaries[index]
                                                        .after_image ==
                                                    null
                                                ? "http://error.png"
                                                : clinic_detail.diaries[index]
                                                    .after_image!,
                                            image1: clinic_detail.diaries[index]
                                                        .before_image ==
                                                    null
                                                ? "http://error.png"
                                                : clinic_detail.diaries[index]
                                                    .before_image!,
                                            eyes: clinic_detail.diaries[index]
                                                        .views_count ==
                                                    null
                                                ? ""
                                                : clinic_detail
                                                    .diaries[index].views_count!
                                                    .toString(),
                                            clinic: clinic_detail.diaries[index]
                                                        .clinic_name ==
                                                    null
                                                ? ""
                                                : clinic_detail.diaries[index]
                                                    .clinic_name!,
                                            name: clinic_detail.diaries[index]
                                                        .patient_nickname ==
                                                    null
                                                ? ""
                                                : clinic_detail.diaries[index]
                                                    .patient_nickname!,
                                            onpress: () {
                                              Navigator.of(context)
                                                  .pushNamed("/Diary_Detail");
                                            },
                                            price: clinic_detail
                                                        .diaries[index].price ==
                                                    null
                                                ? ""
                                                : clinic_detail
                                                    .diaries[index].price
                                                    .toString(),
                                            sentence: clinic_detail
                                                        .diaries[index]
                                                        .doctor_name ==
                                                    null
                                                ? ""
                                                : clinic_detail.diaries[index]
                                                    .doctor_name!,
                                            type: clinic_detail.diaries[index]
                                                        .doctor_name ==
                                                    null
                                                ? ""
                                                : clinic_detail.diaries[index]
                                                    .doctor_name!,
                                          );
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          Clinic_Sub_Detail(
                                                            categories:
                                                                categories,
                                                            clinic_Detail:
                                                                clinic_detail,
                                                            index: 3,
                                                          )));
                                            },
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                Clinic_Sub_Detail(
                                                                  categories:
                                                                      categories,
                                                                  clinic_Detail:
                                                                      clinic_detail,
                                                                  index: 3,
                                                                )));
                                                  },
                                                  child: Text(
                                                    "すべての日記",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 156, 161, 161),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 19,
                                                ),
                                                Icon(
                                                  Icons.navigate_next,
                                                  size: 20,
                                                  color: Helper.maintxtColor,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 18),
                            child: Text(
                              "クリニック基本情報",
                              style: TextStyle(
                                  fontFamily: Helper.headFontFamily,
                                  color: Helper.blackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "住所",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 14,
                                      fontFamily: Helper.headFontFamily,
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // widget.tabController.animateTo(1);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        clinic_detail.clinic.addr01 == null
                                            ? "東京都港区赤坂4-3-2absビル4F"
                                            : clinic_detail.clinic.addr01!,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 156, 161, 161),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        size: 24,
                                        color: Helper.maintxtColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(color: Helper.whiteColor),
                            height: 200,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: DataTable(
                                  border: TableBorder(
                                      bottom: BorderSide(
                                          color:
                                              Helper.txtColor.withOpacity(0.3),
                                          width: 1)),
                                  headingRowHeight: 38,
                                  dataRowHeight: 38,
                                  horizontalMargin: 0,
                                  dataTextStyle: TextStyle(),
                                  showBottomBorder: true,
                                  showCheckboxColumn: false,
                                  columnSpacing: 0,
                                  columns: [
                                    DataColumn(
                                        label: Text('クリニック名',
                                            style: TextStyle(
                                                fontFamily:
                                                    Helper.headFontFamily,
                                                fontSize: 14,
                                                color: Helper.titleColor,
                                                fontWeight: FontWeight.w700))),
                                    DataColumn(
                                        label: Text(clinic_detail.clinic.name!,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Helper.maintxtColor,
                                                fontWeight: FontWeight.w400))),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(
                                        Text('最寄駅',
                                            style: TextStyle(
                                                fontFamily:
                                                    Helper.headFontFamily,
                                                fontSize: 14,
                                                color: Helper.titleColor,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      DataCell(Text(
                                          clinic_detail
                                                      .clinic.nearest_station ==
                                                  null
                                              ? ""
                                              : clinic_detail
                                                  .clinic.nearest_station!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Helper.maintxtColor,
                                              fontWeight: FontWeight.w400))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(
                                        Text('アクセス',
                                            style: TextStyle(
                                                fontFamily:
                                                    Helper.headFontFamily,
                                                fontSize: 14,
                                                color: Helper.titleColor,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      DataCell(Text(
                                          clinic_detail.clinic.access == null
                                              ? ""
                                              : clinic_detail.clinic.access!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Helper.maintxtColor,
                                              fontWeight: FontWeight.w400))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                        '営業時間',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Helper.titleColor,
                                            fontWeight: FontWeight.w700),
                                      )),
                                      DataCell(Text('clinic_detail["times"]',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Helper.maintxtColor,
                                              fontWeight: FontWeight.w400))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('営業日',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Helper.headFontFamily,
                                              color: Helper.titleColor,
                                              fontWeight: FontWeight.w700))),
                                      DataCell(Text(getFreeday(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Helper.maintxtColor,
                                              fontWeight: FontWeight.w400))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('電話番号',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Helper.headFontFamily,
                                              color: Helper.titleColor,
                                              fontWeight: FontWeight.w700))),
                                      DataCell(Text(
                                          clinic_detail.clinic.phone_number ==
                                                  null
                                              ? ""
                                              : clinic_detail
                                                  .clinic.phone_number
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Helper.maintxtColor,
                                              fontWeight: FontWeight.w400))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('クレジットカード',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Helper.headFontFamily,
                                              color: Helper.titleColor,
                                              fontWeight: FontWeight.w700))),
                                      DataCell(Text(
                                          clinic_detail.clinic.credit_card ==
                                                  null
                                              ? ""
                                              : clinic_detail
                                                  .clinic.credit_card!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Helper.maintxtColor,
                                              fontWeight: FontWeight.w400))),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('駐車場',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: Helper.headFontFamily,
                                              color: Helper.titleColor,
                                              fontWeight: FontWeight.w700))),
                                      DataCell(Text(
                                          clinic_detail.clinic.parking == null
                                              ? ""
                                              : clinic_detail.clinic.parking!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Helper.maintxtColor,
                                              fontWeight: FontWeight.w400))),
                                    ])
                                  ]),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
              child: SafeArea(
                child: Container(
                  height: 66,
                  decoration: BoxDecoration(color: Helper.whiteColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          postToogleFavorite(clinic_detail.clinic.id);
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
                                  color: Helper.txtColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 6),
                          primary: Helper.btnBgYellowColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "クリニックを予約",
                              style: defaultTextStyle(
                                  Helper.whiteColor, FontWeight.w700,
                                  size: 16),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => Reservation(
                                    clinic_id: widget.index,
                                    treat: null,
                                  )));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
}

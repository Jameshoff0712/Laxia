import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/views/pages/main/contribution/case_media_list.dart';
import 'package:laxia/views/widgets/curemethod_card.dart';
import 'package:laxia/views/widgets/diray_card.dart';

class CaseDetail extends StatefulWidget {
  final int index;
  const CaseDetail({Key? key, required this.index}) : super(key: key);
  @override
  State<CaseDetail> createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
  bool isloading = true;
  final _con = HomeController();
  late Case_Sub_Model case_detail;
  Future<void> getData({required int index}) async {
    try {
      final mid = await _con.getCaseDetail(index: index);
      setState(() {
        case_detail = mid;
        //  print(case_detail);
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getData(index: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).pushNamed("/Mypage");
                        },
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: case_detail.doctor == null
                                  ? "http://error.png"
                                  : case_detail.doctor!.photo,
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
                      SizedBox(width: 5),
                      Text(
                        case_detail.name == null ? "" : case_detail.name!,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Helper.headFontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        "assets/icons/upright_nobg.svg",
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                height: 66,
                decoration: BoxDecoration(color: Helper.whiteColor),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    //padding: EdgeInsets.symmetric(vertical: 10),
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
                            "クリニックを予約",
                            style: defaultTextStyle(
                                Helper.whiteColor, FontWeight.w700,
                                size: 14),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Container(
                color: Helper.whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CaseMediaList())),
                      child: Container(
                        child: GridView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 3.5,
                                  crossAxisSpacing: 7,
                                  crossAxisCount: 2,
                                  childAspectRatio: 1),
                          children: [
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Container(
                                    width: 426,
                                    height: 426,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "http://error.png", // case_data.data[index]["image1"],
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          'assets/images/loading.gif',
                                          fit: BoxFit.fill,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/profile.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Helper.blackColor
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30))),
                                      child: Center(
                                        child: Text(
                                          "Before",
                                          style: TextStyle(
                                              color: Helper.whiteColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.fill,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Container(
                                    width: 426,
                                    height: 426,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl:
                                            "http://error.png", // case_data.data[index]["image2"],
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          'assets/images/loading.gif',
                                          fit: BoxFit.fill,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/profile.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 100,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Helper.blackColor
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30),
                                              bottomLeft: Radius.circular(30))),
                                      child: Center(
                                        child: Text(
                                          "After",
                                          style: TextStyle(
                                              color: Helper.whiteColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < case_detail.categories!.length;
                              i++)
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                        width: 1, color: Helper.mainColor),
                                    color: Helper.whiteColor),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  child: Text(
                                    case_detail.categories![i].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Helper.mainColor),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        case_detail.case_description == null
                            ? ""
                            : case_detail.case_description!,
                        style: TextStyle(
                            color: Helper.appTxtColor,
                            fontSize: 18,
                            fontFamily: Helper.headFontFamily),
                      ),
                    ),
                    Container(
                      child: Text(
                        case_detail.patient_age.toString() +
                            "代/" +
                            case_detail.patient_gender!,
                        style: TextStyle(color: Helper.darkGrey, fontSize: 14),
                      ),
                    ),
                    // CureMethod_Card(
                    //     image: case_detail.["cure_method"][0]["image"],
                    //     heading: case_detail.["cure_method"][0]["heading"],
                    //     price: case_detail.["cure_method"][0]["price"],
                    //     tax: case_detail.["cure_method"][0]["tax"],
                    //     clinic: case_detail.["cure_method"][0]["clinic"],
                    //     doctor: case_detail.["cure_method"][0]["doctor"]),
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "メニューについて",
                        style: TextStyle(
                            color: Helper.appTxtColor,
                            fontSize: 18,
                            fontFamily: Helper.headFontFamily),
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.only(
                    //     top: 20,
                    //   ),
                    //   margin: EdgeInsets.only(
                    //     bottom: 10,
                    //   ),
                    //   decoration: BoxDecoration(
                    //       color: Helper.lightGrey,
                    //       borderRadius: BorderRadius.circular(6.0)),
                    //   child: Column(
                    //     children: [
                    //       for (int i = 0;
                    //           i < case_detail.["menu_info"].length;
                    //           i++)
                    //         Column(
                    //           children: [
                    //             Padding(
                    //               padding: const EdgeInsets.only(
                    //                 left: 15,
                    //               ),
                    //               child: Align(
                    //                 alignment: Alignment.centerLeft,
                    //                 child: Row(
                    //                   children: [
                    //                     SvgPicture.asset(
                    //                       "assets/icons/menubar/tag_fill.svg",
                    //                       width: 12,
                    //                       height: 12,
                    //                     ),
                    //                     SizedBox(
                    //                       width: 4,
                    //                     ),
                    //                     Text(
                    //                       case_detail.["menu_info"][i]["title"],
                    //                       style: defaultTextStyle(
                    //                           Helper.titleColor, FontWeight.w500,
                    //                           size: 14.0),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(
                    //                   left: 25, top: 10, right: 20, bottom: 20),
                    //               child: Align(
                    //                 alignment: Alignment.centerLeft,
                    //                 child: Text(
                    //                   case_detail.["menu_info"][i]["content"],
                    //                   style: defaultTextStyle(
                    //                       Helper.titleColor, FontWeight.w500,
                    //                       size: 12.0),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "同じ施術の日記",
                        style: TextStyle(
                            color: Helper.appTxtColor,
                            fontSize: 18,
                            fontFamily: Helper.headFontFamily),
                      ),
                    ),
                    // Container(
                    //   color: Helper.whiteColor,
                    //   child: Column(
                    //     children: [
                    //       ListView.builder(
                    //           physics: NeverScrollableScrollPhysics(),
                    //           shrinkWrap: true,
                    //           itemCount: case_detail.['diarys'].length,
                    //           itemBuilder: (BuildContext context, int index) {
                    //             return Diary_Card(
                    //                 avator: case_detail.['diarys'][index]
                    //                     ["avator"],
                    //                 check: case_detail.['diarys'][index]
                    //                     ["check"],
                    //                 image2: case_detail.['diarys'][index]
                    //                     ["image2"],
                    //                 image1: case_detail.['diarys'][index]
                    //                     ["image1"],
                    //                 eyes: case_detail.['diarys'][index]["eyes"],
                    //                 clinic: case_detail.['diarys'][index]
                    //                     ["clinic"],
                    //                 name: case_detail.['diarys'][index]["name"],
                    //                 onpress: () {},
                    //                 price: case_detail.['diarys'][index]
                    //                     ["price"],
                    //                 sentence: case_detail.['diarys'][index]
                    //                     ["sentence"],
                    //                 type: case_detail.['diarys'][index]
                    //                     ["type"]);
                    //           }),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
  }
}

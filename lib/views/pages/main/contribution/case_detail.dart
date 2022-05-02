import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:laxia/views/pages/main/contribution/case_media_list.dart';
import 'package:laxia/views/widgets/curemethod_card.dart';
import 'package:laxia/views/widgets/diray_card.dart';

class CaseDetail extends StatefulWidget {
  @override
  _CaseDetailState createState() => _CaseDetailState();
}

class _CaseDetailState extends StateMVC<CaseDetail> {
  List disease_Details = [];
  bool isfavourite = false;

  Future<void> get_disease_info() async {
    String mid = await rootBundle.loadString("assets/cfg/detail_disease.json");
    setState(() {
      disease_Details.addAll(json.decode(mid));
    });
  }

  @override
  void initState() {
    get_disease_info();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return disease_Details.isNotEmpty? Scaffold(
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
                onTap: (){
                  Navigator.of(context).pushNamed("/Mypage");
                },
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: disease_Details[0]["avator"],
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
                  disease_Details[0]["name"],
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 10,),
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
          padding: EdgeInsets.symmetric(vertical: 5),
          height: 60,
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
                      style: defaultTextStyle(Helper.whiteColor, FontWeight.w700,
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                  imageUrl: disease_Details[0]["image_before"][0],
                                  placeholder: (context, url) => Image.asset(
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
                                    color: Helper.blackColor.withOpacity(0.5),
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
                                  imageUrl: disease_Details[0]["image_after"][0],
                                  placeholder: (context, url) => Image.asset(
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
                                    color: Helper.blackColor.withOpacity(0.5),
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
                        i < disease_Details[0]["surgery"].length;
                        i++)
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border:
                                  Border.all(width: 1, color: Helper.mainColor),
                              color: Helper.whiteColor),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            child: Text(
                              disease_Details[0]["surgery"][i],
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
                  disease_Details[0]["info"],
                  style: TextStyle(color: Helper.appTxtColor, fontSize: 15),
                ),
              ),
              Container(
                child: Text(
                  disease_Details[0]["age"].toString() +
                      "代/" +
                      disease_Details[0]["gender"],
                  style: TextStyle(color: Helper.darkGrey, fontSize: 12),
                ),
              ),
              CureMethod_Card(
                  image: disease_Details[0]["cure_method"][0]["image"],
                  heading: disease_Details[0]["cure_method"][0]["heading"],
                  price: disease_Details[0]["cure_method"][0]["price"],
                  tax: disease_Details[0]["cure_method"][0]["tax"],
                  clinic: disease_Details[0]["cure_method"][0]["clinic"],
                  doctor: disease_Details[0]["cure_method"][0]["doctor"]),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "メニューについて",
                  style: TextStyle(color: Helper.appTxtColor, fontSize: 15),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                    color: Helper.lightGrey,
                    borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  children: [
                    for (int i = 0;
                        i < disease_Details[0]["menu_info"].length;
                        i++)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/menubar/tag_fill.svg",
                                    width: 12,
                                    height: 12,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    disease_Details[0]["menu_info"][i]["title"],
                                    style: defaultTextStyle(
                                        Helper.titleColor, FontWeight.w500,
                                        size: 14.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 10, right: 20, bottom: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                disease_Details[0]["menu_info"][i]["content"],
                                style: defaultTextStyle(
                                    Helper.titleColor, FontWeight.w500,
                                    size: 12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "同じ施術の日記",
                  style: TextStyle(color: Helper.appTxtColor, fontSize: 15),
                ),
              ),
              Container(
                color: Helper.whiteColor,
                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: disease_Details[0]['diarys'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Diary_Card(
                              avator: disease_Details[0]['diarys'][index]
                                  ["avator"],
                              check: disease_Details[0]['diarys'][index]
                                  ["check"],
                              image2: disease_Details[0]['diarys'][index]
                                  ["image2"],
                              image1: disease_Details[0]['diarys'][index]
                                  ["image1"],
                              eyes: disease_Details[0]['diarys'][index]["eyes"],
                              clinic: disease_Details[0]['diarys'][index]
                                  ["clinic"],
                              name: disease_Details[0]['diarys'][index]["name"],
                              onpress: () {},
                              price: disease_Details[0]['diarys'][index]
                                  ["price"],
                              sentence: disease_Details[0]['diarys'][index]
                                  ["sentence"],
                              type: disease_Details[0]['diarys'][index]
                                  ["type"]);
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ):Scaffold();
  }
}

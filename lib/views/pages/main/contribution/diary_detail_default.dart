import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/widgets/state_slider_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:laxia/views/widgets/curemethod_card.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:laxia/views/widgets/comment_dialog.dart';
import 'package:laxia/views/widgets/diray_card.dart';

class DiaryDetailDefault extends StatefulWidget {
  final bool isMyDiary;
  const DiaryDetailDefault({ Key? key, this.isMyDiary = false }) : super(key: key);
  @override
  _DiaryDetailDefaultState createState() => _DiaryDetailDefaultState();
}

class _DiaryDetailDefaultState extends StateMVC<DiaryDetailDefault> {
  List question_Details = [];
  bool isfavourite = false;
  int currentSlider = 1;

  Future<void> get_counsel_info() async {
    String mid = await rootBundle.loadString("assets/cfg/detail_diary_default.json");
    setState(() {
      question_Details.addAll(json.decode(mid));
    });
  }

  @override
  void initState() {
    get_counsel_info();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return question_Details.isNotEmpty? Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: question_Details[0]["avator"],
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
                SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question_Details[0]["name"],
                      style: TextStyle(
                          color: Helper.titleColor, fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                    Text(
                      "施術 " +
                          question_Details[0]["date"] +
                          "   " +
                          "経過" +
                          question_Details[0]["days"] +
                          "日",
                      style: TextStyle(
                              color: Helper.maintxtColor, fontWeight: FontWeight.w400,fontSize: 8),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                !widget.isMyDiary ?
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/AddDiaryProgress");
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 110, 198, 210),
                        width: 2,
                        style: BorderStyle.solid),
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    onSurface: Color.fromARGB(255, 110, 198, 210),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'フォロー',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 110, 198, 210)),
                        ),
                      ],
                    ),
                  ),
                )
                : ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/AddDiaryProgress");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    primary: Color.fromARGB(255, 249, 161, 56),
                    onPrimary: Colors.white,
                    onSurface: Color.fromARGB(255, 110, 198, 210),
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "投稿を修正",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            
                            color: Helper.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
SvgPicture.asset(
                  "assets/icons/upright_nobg.svg",
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        height: 60,
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
                          Icons.favorite,
                          color: Helper.btnBgYellowColor,
                          size: 30,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Helper.txtColor,
                          size: 30,
                        ),
                  Text(
                    "223",
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
            InkWell(
              onTap: () {
                setState(() {
                  isfavourite = !isfavourite;
                });

                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    context: context,
                    builder: (context) {
                      return CommentDialogSheet(count: 0, index: 0, domain: 'diaries',);
                    });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  isfavourite
                      ? Icon(
                          FontAwesomeIcons.commentDots,
                          color: Helper.btnBgYellowColor,
                          size: 30,
                        )
                      : Icon(
                          FontAwesomeIcons.commentDots,
                          color: Helper.txtColor,
                          size: 30,
                        ),
                  Text(
                    "20",
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
                    "コメントする",
                    style: defaultTextStyle(Helper.whiteColor, FontWeight.w700,
                        size: 14),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          color: Helper.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                children: [
                  ImageSlideshow(
                    width: double.infinity,
                    height: 480,
                    initialPage: 0,
                    indicatorColor: Colors.blue,
                    indicatorBackgroundColor: Colors.grey,
                    onPageChanged: (value) {
                      setState(() {
                        currentSlider = value + 1;
                      });
                    },
                    autoPlayInterval: 0,
                    isLoop: true,
                    children: [
                      for (int j = 0; j < 5; j++)
                        Image.asset(
                          'assets/images/canada.png',
                          fit: BoxFit.cover,
                        ),
                    ],
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(179, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "$currentSlider/5",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            
                            color: Helper.whiteColor),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "二重整形150日後の経過日記",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0;
                            i < question_Details[0]["surgery"].length;
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
                                  question_Details[0]["surgery"][i],
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
                    StateSliderWidget(state_str: "痛み", state_val: 2),
                    StateSliderWidget(state_str: "腫れ", state_val: 2),
                    StateSliderWidget(state_str: "傷あと", state_val: 3),
                    Text(
                      question_Details[0]["content"],
                      style: TextStyle(color: Helper.extraGrey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              CureMethod_Card(
                  image: question_Details[0]["cure_method"][0]["image"],
                  heading: question_Details[0]["cure_method"][0]["heading"],
                  price: question_Details[0]["cure_method"][0]["price"],
                  tax: question_Details[0]["cure_method"][0]["tax"],
                  clinic: question_Details[0]["cure_method"][0]["clinic"],
                  doctor: question_Details[0]["cure_method"][0]["doctor"]),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("コメント"),
                    Container(
                      height: 42,
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 32,
                              width: 32,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: question_Details[0]["avator"],
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
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                onTap: (){
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0)),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return CommentDialogSheet(count: 0, index: 0, domain: 'diaries',);
                                    });
                                  },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: 0, left: 15, right: 15, bottom: 0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.1)),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
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
                        itemCount: question_Details[0]['diarys'].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Diary_Card(
                              avator: question_Details[0]['diarys'][index]
                                  ["avator"],
                              check: question_Details[0]['diarys'][index]
                                  ["check"],
                              image2: question_Details[0]['diarys'][index]
                                  ["image2"],
                              image1: question_Details[0]['diarys'][index]
                                  ["image1"],
                              eyes: question_Details[0]['diarys'][index]
                                  ["eyes"],
                              clinic: question_Details[0]['diarys'][index]
                                  ["clinic"],
                              name: question_Details[0]['diarys'][index]
                                  ["name"],
                              onpress: () {},
                              price: question_Details[0]['diarys'][index]
                                  ["price"],
                              sentence: question_Details[0]['diarys'][index]
                                  ["sentence"],
                              type: question_Details[0]['diarys'][index]
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

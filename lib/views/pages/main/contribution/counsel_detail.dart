import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step1.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step2.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:laxia/views/widgets/counsel_short_card.dart';
import 'package:laxia/views/widgets/qa_card.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:laxia/views/widgets/comment_dialog.dart';

class CounselDetail extends StatefulWidget {
  final bool isMyDiary;
  const CounselDetail({ Key? key, this.isMyDiary = false }) : super(key: key);
  @override
  _CounselDetailState createState() => _CounselDetailState();
}

class _CounselDetailState extends StateMVC<CounselDetail> {
  List question_Details = [];
  bool isfavourite = false;

  Future<void> get_counsel_info() async {
    String mid = await rootBundle.loadString("cfg/detail_counsel.json");
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
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
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    Text(
                      "カウンセリング日 " + question_Details[0]["date"],
                      style: TextStyle(color: Helper.darkGrey, fontSize: 10),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCounselStep1Page()));
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
                            height: 1.5,
                            color: Helper.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
SvgPicture.asset(
                  "icons/upright_nobg.svg",
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
                      return CommentDialogSheet();
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
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  question_Details[0]["title"],
                  style: TextStyle(
                      color: Helper.titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
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
                              border:
                                  Border.all(width: 1, color: Helper.mainColor),
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
              ),
              CounselShort_Card(
                  clinic: question_Details[0]["clinic"],
                  doctor: question_Details[0]["doctor"]),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      question_Details[0]["question"][0]['question'],
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Text(
                      question_Details[0]["question"][0]['answer'],
                      style: TextStyle(color: Helper.extraGrey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "自分の写真",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PhotoCarouselWidget(
                                    ImageList: question_Details[0]
                                        ["self_images"])
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "理想の写真",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PhotoCarouselWidget(
                                    ImageList: question_Details[0]
                                        ["ideal_images"])
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "理想じゃない写真",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PhotoCarouselWidget(
                                    ImageList: question_Details[0]
                                        ["non_ideal_images"])
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      question_Details[0]["question"][1]['question'],
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Text(
                      question_Details[0]["question"][1]['answer'],
                      style: TextStyle(color: Helper.extraGrey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "どんなことを質問しましたか？",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    for (int i = 0;
                        i < question_Details[0]["custom_question"].length;
                        i++)
                      QA_Card(
                          question: question_Details[0]["custom_question"][i]
                              ["question"],
                          answer: question_Details[0]["custom_question"][i]
                              ["answer"])
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      question_Details[0]["question"][2]['question'],
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Text(
                      question_Details[0]["question"][2]['answer'],
                      style: TextStyle(color: Helper.extraGrey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      question_Details[0]["question"][3]['question'],
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Text(
                      question_Details[0]["question"][3]['answer'],
                      style: TextStyle(color: Helper.extraGrey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              CounselShort_Card(
                  clinic: question_Details[0]["clinic"],
                  doctor: question_Details[0]["doctor"]),
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
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 0, left: 15, right: 15, bottom: 0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

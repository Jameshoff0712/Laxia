import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/pages/main/contribution/question.dart';
import 'package:laxia/views/pages/main/mypage/question_fix_post.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:laxia/views/widgets/comment_dialog.dart';

class QuestionDetail extends StatefulWidget {
  final bool isMyDiary;
  const QuestionDetail({ Key? key, this.isMyDiary = false }) : super(key: key);
  @override
  _QuestionDetailState createState() => _QuestionDetailState();
}

class _QuestionDetailState extends StateMVC<QuestionDetail> {
  List question_Details = [];
  bool isfavourite = false,isStar=false;

  Future<void> get_question_info() async {
    String mid = await rootBundle.loadString("assets/cfg/detail_question.json");
    setState(() {
      question_Details.addAll(json.decode(mid));
    });
  }

  @override
  void initState() {
    get_question_info();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return question_Details.isNotEmpty? Scaffold(
      resizeToAvoidBottomInset: true,
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
                ),
                SizedBox(width: 5),
                Text(
                  question_Details[0]["name"],
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
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
                              fontSize: 13,
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
                            builder: (context) => QuestionFixPostPage()));
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
                    isStar = !isStar;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isStar
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
                          color: isStar
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
                  showModalBottomSheet(
                    constraints:BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9, ),
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
                          Icon(
                            FontAwesomeIcons.commentDots,
                            color: Helper.txtColor,
                            size: 30,
                          ),
                    Text(
                      "20",
                      style: TextStyle(
                          color:Helper.txtColor,
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
      ),
      body: SingleChildScrollView(
        reverse: false,
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: question_Details[0]["status"] == 0
                      ? Helper.extraGrey
                      : Helper.whiteColor,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(
                    question_Details[0]["status"] == 0 ? "未回答" : "回答あり",
                    style: TextStyle(
                        color: question_Details[0]["status"] == 0
                            ? Helper.lightGrey
                            : Helper.mainColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
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
                child: Text(
                  question_Details[0]["date"],
                  style: TextStyle(color: Helper.darkGrey, fontSize: 10),
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
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  question_Details[0]["content"],
                  style: TextStyle(color: Helper.extraGrey, fontSize: 14),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PhotoCarouselWidget(
                                  ImageList: question_Details[0]["images"],bRemove: false, onRemove: (int ) {  },)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
    ):Scaffold();
  }
}
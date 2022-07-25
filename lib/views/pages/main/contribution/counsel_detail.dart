import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/counseling/councelingdetail_model.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step1.dart';
import 'package:laxia/views/pages/main/contribution/counsel_add_step2.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_detail.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:laxia/views/widgets/counsel_short_card.dart';
import 'package:laxia/views/widgets/qa_card.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:laxia/views/widgets/comment_dialog.dart';

class CounselDetail extends StatefulWidget {
  final bool isMyDiary;
  final int index;
  const CounselDetail({Key? key, this.isMyDiary = false, required this.index})
      : super(key: key);
  @override
  _CounselDetailState createState() => _CounselDetailState();
}

class _CounselDetailState extends StateMVC<CounselDetail> {
  final apiUrl = dotenv.env["DEV_API_URL"];
  bool isloading = true, isfavorite = false, islike = false, isfollow = false;
  final _con = HomeController();
  late CouncelingDetail_Model counceling_detail;
  Future<void> getData({required int index}) async {
    try {
      final mid = await _con.getCouncelingDetail(index: index);
      setState(() {
        counceling_detail = mid;
        isfavorite = counceling_detail.counceling.is_favorite!;
        isfollow = counceling_detail.owner.is_follow!;
        islike = counceling_detail.counceling.is_like!;
        isloading = false;
      });
    } catch (e) {
      print(e.toString() + "");
    }
  }

  Future<void> postToogleFollow(index) async {
    try {
      final res =
          await _con.postToogleFollow(index: counceling_detail.owner.id);
      if (res == true) {
        setState(() {
          isfollow = !isfollow;
        });
      }
    } catch (e) {}
  }

  Future<void> postToogleFavorite(index) async {
    try {
      final res =
          await _con.postToogleFavorite(index: index, domain: 'counselings');
      if (res == true) {
        setState(() {
          isfavorite = !isfavorite;
        });
      }
    } catch (e) {}
  }

  Future<void> postToogleLike(index) async {
    try {
      final res =
          await _con.postToogleLike(index: index, domain: 'counselings');
      if (res == true) {
        setState(() {
          islike = !islike;
        });
      }
    } catch (e) {}
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
                      GestureDetector(
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
                              imageUrl: counceling_detail.owner.photo,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            counceling_detail.counceling.clinic_name == null
                                ? ""
                                : counceling_detail.counceling.clinic_name!,
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Row(
                            children: [
                              Text(
                                "カウンセリング日",
                                style: TextStyle(
                                    fontFamily: Helper.headFontFamily,
                                    color: Helper.darkGrey,
                                    fontSize: 10),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                (counceling_detail.counceling.counseling_date ==
                                        null
                                    ? ""
                                    : counceling_detail
                                        .counceling.counseling_date!),
                                style: TextStyle(
                                    color: Helper.darkGrey, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      !widget.isMyDiary
                          ? InkWell(
                              onTap: () {
                                postToogleFollow(counceling_detail.owner.id);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 110, 198, 210),
                                        width: 2,
                                        style: BorderStyle.solid),
                                    color: isfollow
                                        ? Color.fromARGB(255, 110, 198, 210)
                                        : Colors.white),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 2, 12, 3),
                                  child: Text(
                                    'フォロー',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isfollow
                                          ? Helper.whiteColor
                                          : Color.fromARGB(255, 110, 198, 210),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddCounselStep1Page(
                                                isMyDiary: widget.isMyDiary)));
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                primary: Color.fromARGB(255, 249, 161, 56),
                                onPrimary: Colors.white,
                                onSurface: Color.fromARGB(255, 110, 198, 210),
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                              ),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                height: 60,
                decoration: BoxDecoration(color: Helper.whiteColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 21,
                    ),
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
                                  width: 22,
                                  height: 22,
                                  color: Helper.starColor,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/borderstar.svg",
                                  width: 22,
                                  height: 22,
                                  // color: Colors.red,
                                  color: Color.fromARGB(255, 155, 155, 155),
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
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        postToogleFavorite(widget.index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isfavorite
                              ? SvgPicture.asset(
                                  "assets/icons/red_heart.svg",
                                  width: 22,
                                  height: 22,
                                  color: Colors.red,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/heart.svg",
                                  width: 22,
                                  height: 22,
                                  color: Color.fromARGB(255, 155, 155, 155),
                                ),
                          Text(
                            counceling_detail.counceling.likes_count!
                                .toString(),
                            style: TextStyle(
                                color: Helper.txtColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.9,
                            ),
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                            context: context,
                            builder: (context) {
                              return CommentDialogSheet(
                                index: widget.index,
                                domain: 'counselings',
                              );
                            });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/chat.svg",
                            width: 22,
                            height: 22,
                            color: Color.fromARGB(255, 155, 155, 155),
                          ),
                          Text(
                            counceling_detail.counceling.comments_count
                                .toString(),
                            style: TextStyle(
                                color: Helper.txtColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 21,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 243, 243),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, top: 7, bottom: 7, right: 100),
                          child: Text(
                            "コメントする",
                            style: TextStyle(
                                color: Helper.txtColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                        ),
                      ),
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
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        counceling_detail.counceling.title == null
                            ? ""
                            : counceling_detail.counceling.title!,
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
                              i <
                                  counceling_detail
                                      .counceling.categories!.length;
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
                                    counceling_detail
                                        .counceling.categories![i].name,
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
                      clinic: counceling_detail.clinic.name!,
                      doctor: counceling_detail.doctor.kata_name,
                      onclinic: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Clinic_Detail(
                                    index: counceling_detail.clinic.id)));
                      },
                      ondoctor: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Doctor_Detail(
                                    index: counceling_detail.doctor.id)));
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "どんなことで悩んでいたのか？", // counceling_detail.["question"][0]['question'],
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            counceling_detail.counceling.content!,
                            style: TextStyle(
                                color: Helper.extraGrey, fontSize: 14),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PhotoCarouselWidget(
                                        bRemove: false,
                                        ImageList: counceling_detail
                                            .counceling.media_self!,
                                        onRemove: (int) {}, 
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PhotoCarouselWidget(
                                        bRemove: false,
                                        ImageList: counceling_detail
                                            .counceling.media_like!,
                                        onRemove: (int) {},
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      PhotoCarouselWidget(
                                        bRemove: false,
                                        ImageList: counceling_detail
                                            .counceling.media_dislike!,
                                        onRemove: (int) {},
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
                    Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "このクリニック、ドクターを選んだ理由は？", //counceling_detail.counceling.reason!,
                            style: TextStyle(
                                color: Helper.extraGrey, fontSize: 14),
                          ),
                          SizedBox(height: 10),
                          Text(
                            counceling_detail.counceling.reason!,
                            style: TextStyle(fontSize: 15),
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
                              i < counceling_detail.questions.length;
                              i++)
                            QA_Card(
                                question:
                                    counceling_detail.questions[i].question!,
                                answer: counceling_detail.questions[i].answer!)
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
                            "カウンセリングの様子は？", //counceling_detail.["question"][2]['question'],
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            counceling_detail.counceling.before_counseling!,
                            style: TextStyle(
                                color: Helper.extraGrey, fontSize: 14),
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
                            "カウンセリングの様子は？", // counceling_detail.counceling.before_counseling!,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            counceling_detail.counceling.after_ccounseling!,
                            style: TextStyle(
                                color: Helper.extraGrey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    CounselShort_Card(
                      clinic: counceling_detail.clinic.name!,
                      doctor: counceling_detail.doctor.kata_name,
                      onclinic: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Clinic_Detail(
                                    index: counceling_detail.clinic.id)));
                      },
                      ondoctor: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Doctor_Detail(
                                    index: counceling_detail.doctor.id)));
                      },
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
                                          imageUrl:
                                              "http://error.png", //counceling_detail.counceling.patient_photo,
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
                                              return CommentDialogSheet( index: widget.index, domain: 'counselings',);
                                            });
                                          },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 0,
                                              left: 15,
                                              right: 15,
                                              bottom: 0),
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

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/views/pages/main/contribution/question.dart';
import 'package:laxia/views/pages/main/mypage/question_fix_post.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:laxia/views/widgets/comment_dialog.dart';

class QuestionDetail extends StatefulWidget {
  final bool isMyDiary;
  final int index;
  const QuestionDetail({Key? key, this.isMyDiary = false, required this.index})
      : super(key: key);
  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  final apiUrl = dotenv.env["DEV_API_URL"];
  bool isloading = true, isfavorite = false, islike = false;
  final _con = HomeController();
  late Question_Sub_Model question_detail;
  Future<void> getData({required int index}) async {
    try {
      final mid = await _con.getQuestionDetail(index: index);
      setState(() {
        question_detail = mid;
        //  print(question_detail);
        isfavorite = question_detail.is_favorite!;
        islike = question_detail.is_like!;
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postToogleFavorite(index) async {
    try {
      final res =
          await _con.postToogleFavorite(index: index, domain: 'questions');
      if (res == true) {
        setState(() {
          isfavorite = !isfavorite;
        });
      }
    } catch (e) {}
  }

  Future<void> postToogleLike(index) async {
    try {
      final res = await _con.postToogleLike(index: index, domain: 'questions');
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
                              imageUrl: question_detail.owner!.photo == null
                                  ? "http://error.png"
                                  : (question_detail.owner!.photo!
                                          .contains("http")
                                      ? question_detail.owner!.photo
                                      : apiUrl! +
                                          question_detail.owner!.photo!),
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
                        question_detail.owner!.name!,
                        style: TextStyle(
                            fontFamily: Helper.headFontFamily,
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      !widget.isMyDiary
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed("/AddDiaryProgress");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Helper.mainColor),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 3, 12, 3),
                                    child: Text(
                                      'フォロー',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Helper.mainColor),
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
                                            QuestionFixPostPage()));
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
                        width: 16,
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
                padding: EdgeInsets.symmetric(vertical: 5),
                height: 66,
                decoration: BoxDecoration(color: Helper.whiteColor),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 16,
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
                                color:Helper.txtColor,
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
                        postToogleFavorite(widget.index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isfavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: Helper.redColor,
                                  size: 23,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/heart.svg",
                                  width: 22,
                                  height: 22,
                                  color: Color.fromARGB(255, 155, 155, 155),
                                ),
                          Text(
                            question_detail.likes_count!.toString(),
                            style: TextStyle(
                                color:Helper.txtColor,
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
                                count: question_detail.comments_count!,
                                domain: 'questions',
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
                            question_detail.comments_count.toString(),
                            style: TextStyle(
                                color: Helper.txtColor,
                                fontSize: 10,
                                
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 243, 243),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 7, bottom: 7, right: 10),
                            child: Text(
                              "コメントする",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Helper.whiteColor,
            body: SingleChildScrollView(
              reverse: false,
              child: Container(
                color: Helper.whiteColor,
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: question_detail.answers.isEmpty
                            ? Color.fromARGB(255, 224, 226, 226)
                            : Color.fromARGB(255, 240, 154, 55)
                                .withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        child: Text(
                          question_detail.answers.isEmpty ? "未回答" : "回答あり",
                          style: TextStyle(
                              color: question_detail.answers.isEmpty
                                  ? Helper.maintxtColor
                                  : Color.fromARGB(255, 249, 161, 56),
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        question_detail.title!,
                        style: TextStyle(
                            fontFamily: Helper.headFontFamily,
                            color: Helper.titleColor,
                            height: 25/18,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      child: Text(
                        question_detail.created_at!
                            .split("T")[0]
                            .replaceAll('-', '/'),
                        style: TextStyle(color: Helper.searchBartxtColor, fontSize: 10),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < question_detail.categories!.length;
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
                                    question_detail.categories![i].name,
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
                        question_detail.content!,
                        style: TextStyle(
                            color: Helper.titleColor,
                            fontSize: 14,
                            height: 25 / 14),
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
                                      ImageList: question_detail.medias!,
                                      bRemove: false,
                                      onRemove: (int) {},
                                    )
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
                            Text(
                              "コメント",
                              style: TextStyle(
                                  fontFamily: Helper.headFontFamily,
                                  color: Helper.titleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
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
                                              question_detail.owner!.photo,
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
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 0,
                                              left: 15,
                                              right: 15,
                                              bottom: 0),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    192, 231, 231, 231)),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    192, 231, 231, 231)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    192, 231, 231, 231)),
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

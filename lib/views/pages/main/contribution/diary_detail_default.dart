import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/diary/diary/progress_detail_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_progress.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/widgets/state_slider_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:laxia/views/widgets/curemethod_card.dart';
import 'package:laxia/views/widgets/comment_dialog.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:provider/provider.dart';

class DiaryDetailDefault extends StatefulWidget {
  final bool isMyDiary;
  final int index;
  final String diary_id;
  const DiaryDetailDefault(
      {Key? key,
      this.isMyDiary = false,
      required this.index,
      required this.diary_id})
      : super(key: key);
  @override
  _DiaryDetailDefaultState createState() => _DiaryDetailDefaultState();
}

class _DiaryDetailDefaultState extends StateMVC<DiaryDetailDefault> {
  bool isloading = true, isfavorite = false, islike = false, isfollow = false;
  int currentSlider = 1;
  final _con = HomeController();
  late ProgressDetail_Model progress_detail;
  Future<void> getData() async {
    try {
      final mid = await _con.getProgressDetail(index: widget.index);
      setState(() {
        progress_detail = mid;
        isfavorite = progress_detail.diary.is_favorite == null
            ? false
            : progress_detail.diary.is_favorite!;
        islike = progress_detail.diary.is_like!;
        isloading = false;
        isfollow = progress_detail.owner.is_follow!;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postToogleFollow(index) async {
    try {
      final res = await _con.postToogleFollow(index: progress_detail.owner.id);
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
          await _con.postToogleFavorite(index: index, domain: 'diaries');
      if (res == true) {
        setState(() {
          isfavorite = !isfavorite;
        });
      }
    } catch (e) {}
  }

  Future<void> postToogleLike(index) async {
    try {
      final res = await _con.postToogleLike(index: index, domain: 'diaries');
      if (res == true) {
        setState(() {
          islike = !islike;
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
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
                            imageUrl: progress_detail.diary.patient_photo,
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
                            progress_detail.diary.patient_nickname == null
                                ? ""
                                : progress_detail.diary.patient_nickname!,
                            style: TextStyle(
                                color: Helper.titleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Text(
                            "施術 " +
                                progress_detail.diary.treat_date! +
                                "   " +
                                "経過" +
                                progress_detail.progress.from_treat_day
                                    .toString() +
                                "日",
                            style: TextStyle(
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 8),
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
                                postToogleFollow(progress_detail.owner.id);
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
                          : InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AddDiaryProgressPage(
                                          isMyDiary: widget.isMyDiary,
                                          progress_id: widget.index.toString(),
                                          diary_id: widget.diary_id,
                                        )));
                              },
                              child: Container(
                                 decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Color.fromARGB(255, 249, 161, 56)
                                ),
                                child: Padding(
                                 padding: EdgeInsets.symmetric(horizontal:5,vertical: 2),
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
                            ),
                      SizedBox(
                        width: 10,
                      ),
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
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            bottomNavigationBar: Container(
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
                            progress_detail.diary.likes_count!
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
                                domain: 'progresses',
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
                            progress_detail.diary.comments_count
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
                            progress_detail.progress.medias.isEmpty
                                ? SizedBox()
                                : CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        progress_detail.progress.medias[0].path,
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
                            for (int j = 1;
                                j < progress_detail.progress.medias.length;
                                j++)
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    progress_detail.progress.medias[j].path,
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
                          ],
                        ),
                        Positioned(
                          bottom: 15,
                          right: 15,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(179, 0, 0, 0),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "$currentSlider/${progress_detail.progress.medias.length}",
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
                            progress_detail.menu.name +
                                progress_detail.progress.from_treat_day
                                    .toString() +
                                '日後の経過日記',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < progress_detail.diary.categories!.length;
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
                                        progress_detail
                                            .diary.categories![i].name,
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
                          StateSliderWidget(
                            state_str: "痛み",
                            state_val: progress_detail.statuses[0].pivot.value,
                            isenable: false,
                          ),
                          StateSliderWidget(
                              state_str: "腫れ",
                              state_val:
                                  progress_detail.statuses[1].pivot.value,
                              isenable: false),
                          StateSliderWidget(
                              state_str: "傷あと",
                              state_val:
                                  progress_detail.statuses[2].pivot.value,
                              isenable: false),
                          Text(
                            progress_detail.progress.content!,
                            style: TextStyle(
                                color: Helper.extraGrey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    CureMethod_Card(
                        image: progress_detail.menu.photo!,
                        heading: progress_detail.menu.name,
                        price: progress_detail.menu.price.toString(),
                        tax: '（税込）',
                        clinic: progress_detail.diary.clinic_name!,
                        doctor: progress_detail.diary.doctor_name!),
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
                                            userProperties.currentMe.photo,
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
                                                domain: 'progresses',
                                              );
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
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "同じ施術の日記",
                        style:
                            TextStyle(color: Helper.appTxtColor, fontSize: 15),
                      ),
                    ),
                    Container(
                      color: Helper.whiteColor,
                      child: Column(
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: progress_detail.diaries.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Diary_Card(
                                  avator: progress_detail
                                              .diaries[index].patient_photo ==
                                          null
                                      ? "http://error.png"
                                      : progress_detail
                                          .diaries[index].patient_photo!,
                                  check: progress_detail
                                              .diaries[index].doctor_name ==
                                          null
                                      ? ""
                                      : progress_detail
                                          .diaries[index].doctor_name!,
                                  image2: progress_detail
                                              .diaries[index].after_image ==
                                          null
                                      ? "http://error.png"
                                      : progress_detail
                                          .diaries[index].after_image!,
                                  image1: progress_detail
                                              .diaries[index].before_image ==
                                          null
                                      ? "http://error.png"
                                      : progress_detail
                                          .diaries[index].before_image!,
                                  eyes: progress_detail
                                              .diaries[index].views_count ==
                                          null
                                      ? ""
                                      : progress_detail
                                          .diaries[index].views_count!
                                          .toString(),
                                  clinic: progress_detail
                                              .diaries[index].clinic_name ==
                                          null
                                      ? ""
                                      : progress_detail
                                          .diaries[index].clinic_name!,
                                  name: progress_detail.diaries[index]
                                              .patient_nickname ==
                                          null
                                      ? ""
                                      : progress_detail
                                          .diaries[index].patient_nickname!,
                                  onpress: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Diary_Detail(
                                                index: progress_detail
                                                    .diaries[index].id)));
                                  },
                                  price: progress_detail.diaries[index].price ==
                                          null
                                      ? ""
                                      : progress_detail.diaries[index].price
                                          .toString(),
                                  sentence: progress_detail
                                              .diaries[index].doctor_name ==
                                          null
                                      ? ""
                                      : progress_detail
                                          .diaries[index].doctor_name!,
                                  type: progress_detail
                                              .diaries[index].doctor_name ==
                                          null
                                      ? ""
                                      : progress_detail
                                          .diaries[index].doctor_name!,
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

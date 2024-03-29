import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/doctor/doctordetail_model.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_sub_detail.dart';
import 'package:laxia/views/pages/main/reservation/reservation.dart';
import 'package:laxia/views/widgets/detail_image.dart';
import 'package:laxia/views/widgets/doctor_detail_card.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';
import 'package:laxia/views/widgets/question_card.dart';

class Doctor_Detail extends StatefulWidget {
  final int index;
  const Doctor_Detail({Key? key, required this.index}) : super(key: key);

  @override
  State<Doctor_Detail> createState() => _Doctor_DetailState();
}

class _Doctor_DetailState extends State<Doctor_Detail> {
  bool isfavourite = false, isloading = true;
  final _con = HomeController();
  late DoctorDetail_Model doctor_detail;
  Future<void> getData({required int index}) async {
    try {
      final mid = await _con.getDoctorDetail(index: index);
      setState(() {
        doctor_detail = mid;
        isfavourite = doctor_detail.doctor.is_favorite == null
            ? false
            : doctor_detail.doctor.is_favorite!;
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postToogleFavorite(int index) async {
    try {
      final res =
          await _con.postToogleFavorite(index: index, domain: 'doctors');
      if (res == true) {
        setState(() {
          isfavourite = !isfavourite;
        });
      }
    } catch (e) {}
  }

  String getcategoryname() {
    String mid = '';
    for (int i = 0; i < doctor_detail.doctor.categories!.length; i++)
      mid += doctor_detail.doctor.categories![i].name + ' ';
    return mid;
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PageViewWidget(
                                      onBoardingInstructions: [
                                        for (int j = 0;
                                            j < doctor_detail.images.length;
                                            j++)
                                          doctor_detail.images[j].path
                                      ],
                                      startindex: 1,
                                    )));
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => PageViewWidget(
                            //           onBoardingInstructions: [
                            //             "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-1.jpg",
                            //             "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-2.jpg",
                            //             "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-3.jpg",
                            //             "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-4.jpg"
                            //           ],
                            //           startindex: 1,
                            //         )));
                          },
                          child: Detail_Image(
                            isDoctor: true,
                            insidestar: true,
                            height: 330,
                            imageList: doctor_detail.images,
                            onPressUpRight: () {},
                            onPressBack: () {
                              Navigator.of(context).pop();
                            },
                            onStar: () {
                              postToogleFavorite(doctor_detail.doctor.id);
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 260),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.1),
                                          blurRadius: 5)
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                // padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                                child: Column(
                                  children: [
                                    Doctor_DetailCard(
                                      image: doctor_detail.doctor.photo == null
                                          ? "http://error.png"
                                          : doctor_detail.doctor.photo!,
                                      clinic: doctor_detail.clinic == null
                                          ? ""
                                          : doctor_detail.clinic.name!,
                                      name: doctor_detail.doctor.hira_name,
                                      mark: double.parse(
                                              (doctor_detail.doctor.avg_rate)
                                                  .toStringAsFixed(1))
                                          .toString(),
                                      post:
                                          doctor_detail.doctor.job_name == null
                                              ? ""
                                              : doctor_detail.doctor.job_name!,
                                      profile: [
                                        {
                                          "title": "専門領域",
                                          "content": getcategoryname()
                                        },
                                        {
                                          "title": "経歴",
                                          "content":
                                              doctor_detail.doctor.career ==
                                                      null
                                                  ? ""
                                                  : doctor_detail.doctor.career
                                        },
                                        {
                                          "title": "資格",
                                          "content":
                                              doctor_detail.doctor.profile ==
                                                      null
                                                  ? ""
                                                  : doctor_detail.doctor.profile
                                        }
                                      ],
                                      items: [
                                        doctor_detail.diaries.length,
                                        doctor_detail.counselings.length,
                                        doctor_detail.cases.length
                                      ],
                                      experience_year: doctor_detail
                                          .doctor.experience_year
                                          .toString(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Helper.whiteColor,
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Helper.bodyBgColor,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                  Container(
                    color: Helper.whiteColor,
                    child: Clinic_Card(
                        onpress: () {},
                        image: doctor_detail.clinic.photo!,
                        post: doctor_detail.clinic.diaries_count!.toString(),
                        name: doctor_detail.clinic.name!,
                        mark: double.parse((doctor_detail.clinic.avg_rate)!
                                .toStringAsFixed(1))
                            .toString(),
                        day: doctor_detail.clinic.diaries_count.toString(),
                        location: doctor_detail.clinic.address!),
                  ),
                  doctor_detail.diaries.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 5,
                        ),
                  doctor_detail.diaries.isEmpty
                      ? Container()
                      : Container(
                          color: Helper.whiteColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "日記",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 51, 51),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          doctor_detail.diaries.length
                                                  .toString() +
                                              "件",
                                          style: TextStyle(
                                              color: Helper.darkGrey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Doctor_Sub_Detail(
                                                      doctor_detail:
                                                          doctor_detail,
                                                      index: 1,
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
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(width: 5),
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
                                  itemCount: doctor_detail.diaries.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Diary_Card(
                                      avator: doctor_detail.diaries[index]
                                                  .patient_photo ==
                                              null
                                          ? "http://error.png"
                                          : doctor_detail
                                              .diaries[index].patient_photo!,
                                      check: doctor_detail
                                                  .diaries[index].doctor_name ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .diaries[index].doctor_name!,
                                      image2: doctor_detail
                                                  .diaries[index].after_image ==
                                              null
                                          ? "http://error.png"
                                          : doctor_detail
                                              .diaries[index].after_image!,
                                      image1: doctor_detail.diaries[index]
                                                  .before_image ==
                                              null
                                          ? "http://error.png"
                                          : doctor_detail
                                              .diaries[index].before_image!,
                                      eyes: doctor_detail
                                                  .diaries[index].views_count ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .diaries[index].views_count!
                                              .toString(),
                                      clinic: doctor_detail
                                                  .diaries[index].clinic_name ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .diaries[index].clinic_name!,
                                      name: doctor_detail.diaries[index]
                                                  .patient_nickname ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .diaries[index].patient_nickname!,
                                      onpress: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => Diary_Detail(
                                                    index: doctor_detail
                                                        .diaries[index].id)));
                                      },
                                      price: doctor_detail
                                                  .diaries[index].price ==
                                              null
                                          ? ""
                                          : doctor_detail.diaries[index].price
                                              .toString(),
                                      sentence: doctor_detail
                                                  .diaries[index].doctor_name ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .diaries[index].doctor_name!,
                                      type: doctor_detail
                                                  .diaries[index].doctor_name ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .diaries[index].doctor_name!,
                                    );
                                  }),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Doctor_Sub_Detail(
                                                      doctor_detail:
                                                          doctor_detail,
                                                      index: 1,
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
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(width: 10),
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
                            ],
                          ),
                        ),
                  doctor_detail.cases.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 5,
                        ),
                  doctor_detail.cases.isEmpty
                      ? Container()
                      : Container(
                          color: Helper.whiteColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "症例",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 51, 51),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          doctor_detail.cases.length
                                                  .toString() +
                                              "件",
                                          style: TextStyle(
                                              color: Helper.darkGrey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Doctor_Sub_Detail(
                                                      doctor_detail:
                                                          doctor_detail,
                                                      index: 2,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "すべての症例",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 156, 161, 161),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(width: 5),
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
                                  itemCount: doctor_detail.cases.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Diary_Card(
                                      onpress: () {
                                        Navigator.of(context)
                                            .pushNamed("/CaseDetail");
                                      },
                                      buttoncolor: Helper.btnBgMainColor,
                                      buttontext: "症例",
                                      avator: doctor_detail
                                                  .cases[index].clinic!.photo ==
                                              null
                                          ? "http://error.png"
                                          : doctor_detail
                                              .cases[index].clinic!.photo!,
                                      check:
                                          doctor_detail.cases[index].doctor ==
                                                  null
                                              ? ""
                                              : doctor_detail
                                                  .cases[index].doctor!.name!,
                                      image2: doctor_detail
                                              .cases[index].afterimage!.isEmpty
                                          ? "http://error.png"
                                          : doctor_detail
                                              .cases[index].afterimage![0].path,
                                      image1: doctor_detail
                                              .cases[index].beforeimage!.isEmpty
                                          ? "http://error.png"
                                          : doctor_detail.cases[index]
                                              .beforeimage![0].path,
                                      eyes: doctor_detail
                                                  .cases[index].views_count ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .cases[index].views_count
                                              .toString(),
                                      name: doctor_detail
                                                  .cases[index].clinic!.name ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .cases[index].clinic!.name!,
                                      price: doctor_detail
                                              .cases[index].menus!.isEmpty
                                          ? ""
                                          : (doctor_detail.cases[index]
                                                      .menus![0].price ==
                                                  null
                                              ? ""
                                              : doctor_detail
                                                  .cases[index].menus![0].price!
                                                  .toString()),
                                      sentence: doctor_detail
                                                  .cases[index].treat_risk ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .cases[index].treat_risk!,
                                      type: doctor_detail.cases[index]
                                                  .case_description ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .cases[index].case_description!,
                                    );
                                  }),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Doctor_Sub_Detail(
                                                      doctor_detail:
                                                          doctor_detail,
                                                      index: 2,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "すべての症例",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 156, 161, 161),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(width: 10),
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
                            ],
                          ),
                        ),
                  doctor_detail.questions.isEmpty
                      ? Container()
                      : SizedBox(
                          height: 5,
                        ),
                  doctor_detail.questions.isEmpty
                      ? Container()
                      : Container(
                          color: Helper.whiteColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "医師が回答した質問",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 51, 51),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          doctor_detail.cases.length
                                                  .toString() +
                                              "件",
                                          style: TextStyle(
                                              color: Helper.darkGrey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Doctor_Sub_Detail(
                                                      doctor_detail:
                                                          doctor_detail,
                                                      index: 4,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "すべての質問",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 156, 161, 161),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(width: 5),
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
                                  itemCount: doctor_detail.questions.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Question_Card(
                                      isanswer: doctor_detail
                                          .questions[index].answers.isNotEmpty,
                                      hearts: doctor_detail.questions[index]
                                                  .likes_count ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .questions[index].likes_count!
                                              .toString(),
                                      chats: doctor_detail.questions[index]
                                                  .comments_count ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .questions[index].comments_count
                                              .toString(),
                                      avator: doctor_detail.questions[index]
                                                  .owner!.photo ==
                                              null
                                          ? "http://error.png"
                                          : doctor_detail
                                              .questions[index].owner!.photo!,
                                      images: doctor_detail
                                          .questions[index].medias!,
                                      eyes: doctor_detail.questions[index]
                                                  .views_count ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .questions[index].views_count!
                                              .toString(),
                                      name: doctor_detail.questions[index]
                                                  .owner!.name ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .questions[index].owner!.name!,
                                      onpress: () {
                                        Navigator.of(context)
                                            .pushNamed("/QuestionDetail");
                                      },
                                      sentence: doctor_detail
                                                  .questions[index].content ==
                                              null
                                          ? ""
                                          : doctor_detail
                                              .questions[index].content!,
                                      type: doctor_detail
                                          .questions[index].categories!,
                                    );
                                  }),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    Doctor_Sub_Detail(
                                                      doctor_detail:
                                                          doctor_detail,
                                                      index: 4,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "すべての質問",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 156, 161, 161),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(width: 10),
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
                            ],
                          ),
                        ),
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
                          postToogleFavorite(widget.index);
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          primary: Helper.btnBgYellowColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          splashFactory: NoSplash.splashFactory,
                          shadowColor: Colors.transparent,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => Reservation(
                                  clinic_id: doctor_detail.clinic.id,
                                  treat: null)));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

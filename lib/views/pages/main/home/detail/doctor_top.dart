import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/doctor/doctordetail_model.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/contribution/question_detail.dart';
import 'package:laxia/views/pages/main/home/detail/Doctor_Sub_Detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/question_card.dart';

class Doctor_Top extends StatefulWidget {
  final DoctorDetail_Model doctor_detail;
  final void Function(int index) onpress;
  const Doctor_Top(
      {Key? key, required this.doctor_detail, required this.onpress})
      : super(key: key);

  @override
  State<Doctor_Top> createState() => _Doctor_TopState();
}

class _Doctor_TopState extends State<Doctor_Top> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: Helper.homeBgColor),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(color: Helper.whiteColor),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "日記",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.doctor_detail.diaries.length
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
                                widget.onpress(1);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "すべての日記",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 161, 161),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    size: 15,
                                    color: Color.fromARGB(255, 156, 161, 161),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: widget.doctor_detail.diaries.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Diary_Card(
                              avator: widget.doctor_detail.diaries[index]
                                          .patient_photo ==
                                      null
                                  ? "http://error.png"
                                  : widget.doctor_detail.diaries[index]
                                      .patient_photo!,
                              check: widget.doctor_detail.diaries[index]
                                          .doctor_name ==
                                      null
                                  ? ""
                                  : widget.doctor_detail.diaries[index]
                                      .doctor_name!,
                              image2: widget.doctor_detail.diaries[index]
                                          .after_image ==
                                      null
                                  ? "http://error.png"
                                  : widget.doctor_detail.diaries[index]
                                      .after_image!,
                              image1: widget.doctor_detail.diaries[index]
                                          .before_image ==
                                      null
                                  ? "http://error.png"
                                  : widget.doctor_detail.diaries[index]
                                      .before_image!,
                              eyes: widget.doctor_detail.diaries[index]
                                          .views_count ==
                                      null
                                  ? ""
                                  : widget
                                      .doctor_detail.diaries[index].views_count!
                                      .toString(),
                              clinic: widget.doctor_detail.diaries[index]
                                          .clinic_name ==
                                      null
                                  ? ""
                                  : widget.doctor_detail.diaries[index]
                                      .clinic_name!,
                              name: widget.doctor_detail.diaries[index]
                                          .patient_nickname ==
                                      null
                                  ? ""
                                  : widget.doctor_detail.diaries[index]
                                      .patient_nickname!,
                              onpress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Diary_Detail(
                                        index: widget
                                            .doctor_detail.diaries[index].id)));
                              },
                              price: widget
                                          .doctor_detail.diaries[index].price ==
                                      null
                                  ? ""
                                  : widget.doctor_detail.diaries[index].price
                                      .toString(),
                              sentence: widget.doctor_detail.diaries[index]
                                          .doctor_name ==
                                      null
                                  ? ""
                                  : widget.doctor_detail.diaries[index]
                                      .doctor_name!,
                              type: widget.doctor_detail.diaries[index]
                                          .doctor_name ==
                                      null
                                  ? ""
                                  : widget.doctor_detail.diaries[index]
                                      .doctor_name!,
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                widget.onpress(1);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "すべての日記",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 161, 161),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    size: 15,
                                    color: Color.fromARGB(255, 156, 161, 161),
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
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: Helper.homeBgColor),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(color: Helper.whiteColor),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "質問",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  widget.doctor_detail.questions.length
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
                                widget.onpress(4);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "すべての質問",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 161, 161),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    size: 15,
                                    color: Color.fromARGB(255, 156, 161, 161),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: widget.doctor_detail.questions.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Question_Card(
                                isanswer: widget.doctor_detail.questions[index]
                                    .answers.isNotEmpty,
                                hearts: widget.doctor_detail.questions[index].likes_count == null
                                    ? ""
                                    : widget.doctor_detail.questions[index].likes_count!
                                        .toString(),
                                chats: widget.doctor_detail.questions[index].comments_count == null
                                    ? ""
                                    : widget.doctor_detail.questions[index].comments_count
                                        .toString(),
                                avator: widget.doctor_detail.questions[index].owner!.photo == null
                                    ? "http://error.png"
                                    : widget.doctor_detail.questions[index]
                                        .owner!.photo!,
                                image2: (widget.doctor_detail.questions[index].medias!.isEmpty ||
                                        widget.doctor_detail.questions[index].medias!.length ==
                                            1)
                                    ? "http://error.png"
                                    : widget.doctor_detail.questions[index]
                                        .medias![1].path,
                                image1: widget.doctor_detail.questions[index].medias!.isEmpty
                                    ? "http://error.png"
                                    : widget.doctor_detail.questions[index].medias![0].path,
                                eyes: widget.doctor_detail.questions[index].views_count == null ? "" : widget.doctor_detail.questions[index].views_count!.toString(),
                                name: widget.doctor_detail.questions[index].owner!.name == null ? "" : widget.doctor_detail.questions[index].owner!.name!,
                                onpress: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QuestionDetail(
                                              index: widget.doctor_detail
                                                  .questions[index].id)));
                                  //Navigator.of(context).pushNamed("/QuestionDetail");
                                },
                                sentence: widget.doctor_detail.questions[index].content == null ? "" : widget.doctor_detail.questions[index].content!,
                                type: "二重切開" //widget.doctor_detail.questions[index]["type"],
                                );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                widget.onpress(4);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "すべての質問",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 161, 161),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    size: 15,
                                    color: Color.fromARGB(255, 156, 161, 161),
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
        ],
      )),
    );
  }
}

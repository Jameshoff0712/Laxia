import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/clinic/clinicdetail_model.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/menu_card.dart';

class Clinic_Top extends StatefulWidget {
  final ClinicDetail_Model clinic_detail;
  final void Function(int index) onpress;
  const Clinic_Top({ Key? key, required this.clinic_detail, required this.onpress }) : super(key: key);

  @override
  State<Clinic_Top> createState() => _Clinic_TopState();
}

class _Clinic_TopState extends State<Clinic_Top> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(child: Column(children: [
         SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Helper.whiteColor),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "メニュー",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.onpress(2);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "すべてのメニュー",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 156, 161, 161),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
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
                            itemCount: widget.clinic_detail.menu.length,
                            // physics: const AlwaysScrollableScrollPhysics(),
                            // scrollDirection: Axis.horizontal,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return Menu_Card(
                                shadow: BoxShadow(
                                          color: Color.fromARGB(255, 238, 238,
                                              238), //color of shadow
                                          spreadRadius: 1, //spread radius
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                          //first paramerter of offset is left-right
                                          //second parameter is top to down
                                        ),
                                  onpress: (){
                                    //Navigator.of(context).pushNamed("/Menu_Detail");
                                    Navigator.of(context).push( MaterialPageRoute(builder: (_) => Menu_Detail(index:widget.clinic_detail.menu[index].id)));
                                  },
                                    image: widget.clinic_detail.menu[index].images!.isEmpty?"http://error.png": widget.clinic_detail.menu[index].images![0].path,
                                    heading: widget.clinic_detail.menu[index].description==null?"":widget.clinic_detail.menu[index].description!,
                                    price: widget.clinic_detail.menu[index].price==0?"":widget.clinic_detail.menu[index].price!.toString(),
                                    clinic: widget.clinic_detail.menu[index].name
                                  );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                       widget.onpress(2);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "すべてのメニュー",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 156, 161, 161),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          Icons.navigate_next,
                                          size: 15,
                                          color: Color.fromARGB(
                                              255, 156, 161, 161),
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
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Helper.whiteColor),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "日記",
                                style: TextStyle(
                                    color:
                                        Color.fromARGB(255, 51, 51, 51),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              GestureDetector(
                                onTap: () {
                                   widget.onpress(3);
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
                            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                            itemCount: widget.clinic_detail.diaries.length,
                            physics:NeverScrollableScrollPhysics(),
                            shrinkWrap:true,
                            itemBuilder: (BuildContext context, int index) {
                              return Diary_Card(
                                avator:
                                    widget.clinic_detail.diaries[index].patient_photo == null
                                        ? "http://error.png"
                                        : widget.clinic_detail.diaries[index].patient_photo!,
                                check: widget.clinic_detail.diaries[index].doctor_name == null
                                    ? ""
                                    : widget.clinic_detail.diaries[index].doctor_name!,
                                image2: widget.clinic_detail.diaries[index].after_image == null
                                    ? "http://error.png"
                                    : widget.clinic_detail.diaries[index].after_image!,
                                image1:
                                    widget.clinic_detail.diaries[index].before_image == null
                                        ? "http://error.png"
                                        : widget.clinic_detail.diaries[index].before_image!,
                                eyes: widget.clinic_detail.diaries[index].views_count == null
                                    ? ""
                                    : widget.clinic_detail.diaries[index].views_count!
                                        .toString(),
                                clinic: widget.clinic_detail.diaries[index].clinic_name == null
                                    ? ""
                                    : widget.clinic_detail.diaries[index].clinic_name!,
                                name: widget.clinic_detail.diaries[index].patient_nickname ==
                                        null
                                    ? ""
                                    : widget.clinic_detail.diaries[index].patient_nickname!,
                                onpress: () {
                                  Navigator.of(context).push( MaterialPageRoute(builder: (_) => Diary_Detail(index:widget.clinic_detail.diaries[index].id)));
                                },
                                price: widget.clinic_detail.diaries[index].price == null
                                    ? ""
                                    : widget.clinic_detail.diaries[index].price.toString(),
                                sentence:
                                    widget.clinic_detail.diaries[index].doctor_name == null
                                        ? ""
                                        : widget.clinic_detail.diaries[index].doctor_name!,
                                type: widget.clinic_detail.diaries[index].doctor_name == null
                                    ? ""
                                    : widget.clinic_detail.diaries[index].doctor_name!,
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.onpress(3);
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
                                        Icon(
                                          Icons.navigate_next,
                                          size: 15,
                                          color: Color.fromARGB(
                                              255, 156, 161, 161),
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
      ],)),
    );
  }
}
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/case_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Case extends StatefulWidget {
  final bool issearch;
  final bool? isdrawer;
  final List? model,last;
  const Home_Case({Key? key, required this.issearch, this.model, this.isdrawer=true, this.last})
      : super(key: key);

  @override
  State<Home_Case> createState() => _Home_CaseState();
}

class _Home_CaseState extends State<Home_Case> {
  bool expanded=true;
  int index=-1;
  List mid = [];
  @override
  void initState() {
    if (!widget.issearch) {
      for (int i = 0; i < case_list.length; i++)
        setState(() {
          mid.add(case_list[i]);
        });
    } else {
      for (int i = 0; i < widget.model!.length; i++)
        setState(() {
          mid.add(widget.model![i]);
        });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          widget.isdrawer!?Container(
            color: Helper.whiteColor,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: TextButton_Drawer(
                        width: 123,
                        textname: "エリア選択",
                        onpress: () {
                          Navigator.of(context).pushNamed("/SelectPrefecture");
                        })),
                Expanded(
                  flex: 3,
                  child: TextButton_Drawer(
                      width: 123,
                      textname: "絞り込み",
                      onpress: () {
                        Navigator.of(context).pushNamed("/NarrowCase");
                      }),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["人気投稿順", "新着順"],
                      hintText: "並び替え",
                      horizontal: 20),
                ),
              ],
            ),
          ):
          SizedBox(height: 0,),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  widget.isdrawer!?SizedBox(height: 0,):
                  Container(
                    color: Helper.whiteColor,
                    child: Column(
                      children: [
                        ExtendedWrap(
                          alignment: WrapAlignment.center,
                          maxLines: expanded ? 2 : 100,
                          clipBehavior: Clip.none,
                          runSpacing: 10,
                          spacing: 10,
                          children: [
                            for (int i = 0;
                                i <widget.last!.length;
                                i++)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (index == i) {
                                      index = -1;
                                    } else {
                                      index = i;
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(22),
                                      color: index == i
                                          ? Helper.mainColor
                                          : Helper.homeBgColor),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    child: Text(
                                    widget.last![i]["label"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: index == i
                                              ? Helper.whiteColor
                                              : Helper.titleColor),
                                    ),
                                  ),
                                ),
                              )
                          ]),
                          InkWell(
                            onTap: () {
                              setState(() {
                                expanded = !expanded;
                              });
                            },
                            child: Icon(
                                    expanded
                                        ? FontAwesomeIcons.angleDown
                                        : FontAwesomeIcons.angleUp,
                                    size: 24,
                                    color: Helper.titleColor,
                                  ),
                          ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    itemCount: mid.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Diary_Card(
                        onpress: (){
                          Navigator.of(context).pushNamed("/CaseDetail");
                        },
                        buttoncolor: Helper.btnBgMainColor,
                        buttontext: mid[index]["buttontext"],
                        hearts: mid[index]["hearts"],
                        chats: mid[index]["chats"],
                        avator: mid[index]["avator"],
                        check: mid[index]["check"],
                        image2: mid[index]["image2"],
                        image1: mid[index]["image1"],
                        eyes: mid[index]["eyes"],
                        name: mid[index]["name"],
                        price: mid[index]["price"],
                        sentence: mid[index]["sentence"],
                        type: mid[index]["type"],
                      );
                    }
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}

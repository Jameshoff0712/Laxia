import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Counseling extends StatefulWidget {
  final bool issearch;
  final bool?isdrawer;
  final List? model,last;
  const Home_Counseling({Key? key, required this.issearch, this.model, this.isdrawer=true, this.last})
      : super(key: key);

  @override
  State<Home_Counseling> createState() => _Home_CounselingState();
}

class _Home_CounselingState extends State<Home_Counseling> {
  bool expanded=true;
  int index=-1;
  List mid = [];
  @override
  void initState() {
    if (!widget.issearch) {
      for (int i = 0; i < counseling_list.length; i++)
        setState(() {
          mid.add(counseling_list[i]);
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
                  child: Dropdownbutton(
                      items: <String>["人気投稿順", "新着順"],
                      hintText: "並び替え",
                      horizontal: 60),
                ),
              ],
            ),
          ):
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "すべて表示",
                            style: TextStyle(
                                color: Helper.mainColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: 8.41,
                          ),
                          Icon(
                            expanded
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            size: 24,
                            color: Helper.mainColor,
                          ),
                        ]),
                  ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  itemCount: mid.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Counseling_Card(
                      hearts: mid[index]["hearts"],
                      chats: mid[index]["chats"],
                      avator: mid[index]["avator"],
                      check: mid[index]["check"],
                      image2: mid[index]["image2"],
                      image1: mid[index]["image1"],
                      image3: mid[index]["image3"],
                      image4: mid[index]["image4"],
                      eyes: mid[index]["eyes"],
                      name: mid[index]["name"],
                       onpress: (){
                          Navigator.of(context).pushNamed("/CounselDetail");
                        },
                      sentence: mid[index]["sentence"],
                      type: mid[index]["type"],
                      clinic: mid[index]["clinic"],
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}

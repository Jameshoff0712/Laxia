import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Diary extends StatefulWidget {

  final bool? isScrollable,isdrawer;
  final VoidCallback? scrollTop;
  final bool issearch;
  final List? model,last;
  const Home_Diary({Key? key, required this.issearch, this.model, this.isScrollable=true, this.scrollTop=null, this.isdrawer=true, this.last})
      : super(key: key);

  @override
  State<Home_Diary> createState() => _Home_DiaryState();
}

class _Home_DiaryState extends State<Home_Diary> {
  bool expanded=true;
  int index=-1;
  List mid = [];
  late ScrollController scrollController;
  @override
  void initState() {
    if (!widget.issearch) {
      for (int i = 0; i < diary_list.length; i++)
        setState(() {
          mid.add(diary_list[i]);
        });
    } else {
      for (int i = 0; i < widget.model!.length; i++)
        setState(() {
          mid.add(widget.model![i]);
        });
    }
      scrollController=ScrollController();
      scrollController.addListener((){
        if (scrollController.offset <= scrollController.position.minScrollExtent &&
            !scrollController.position.outOfRange) {
          setState(() {
            widget.scrollTop!();
          });
        }
    });
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
                        Navigator.of(context).pushNamed("/NarrowDiary");
                      }),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["人気投稿順", "満足度が高い順","新着順"],
                      hintText: "並び替え",
                      horizontal: 20),
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
              return Column(
                children: [
                  // menuAppBar(context),
                  Expanded(
                    child: LayoutBuilder(
                        builder: (context, BoxConstraints viewportConstraints) {
                      return ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: mid.length,
                          controller:scrollController,
                          physics: widget.isScrollable!?AlwaysScrollableScrollPhysics():NeverScrollableScrollPhysics(),
                          shrinkWrap:true,
                          itemBuilder: (BuildContext context, int index) {
                            return Diary_Card(
                              avator: mid[index]["avator"],
                              check: mid[index]["check"],
                              image2: mid[index]["image2"],
                              image1: mid[index]["image1"],
                              eyes: mid[index]["eyes"],
                              clinic: mid[index]["clinic"],
                              name: mid[index]["name"],
                              onpress: () {},
                              price: mid[index]["price"],
                              sentence: mid[index]["sentence"],
                              type: mid[index]["type"],
                            );
                          });
                    }),
                  ),
                ],
              );
            }),
          ),
        ],
        
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/case_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Case extends StatefulWidget {
  final bool issearch;
  final List? model;
  const Home_Case({Key? key, required this.issearch, this.model})
      : super(key: key);

  @override
  State<Home_Case> createState() => _Home_CaseState();
}

class _Home_CaseState extends State<Home_Case> {
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
          Container(
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
                      return
                      ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: mid.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Diary_Card(
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

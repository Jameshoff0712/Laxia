import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Favorite_Diary extends StatefulWidget {
  const Favorite_Diary({Key? key}) : super(key: key);

  @override
  State<Favorite_Diary> createState() => _Favorite_DiaryState();
}

class _Favorite_DiaryState extends State<Favorite_Diary> {
  bool expanded = true;
  int index = -1;
  List mid = [];
  late ScrollController scrollController;
  @override
  void initState() {
    for (int i = 0; i < diary_list.length; i++)
      setState(() {
        mid.add(diary_list[i]);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                itemCount: mid.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Diary_Card(
                    avator: mid[index]["avator"],
                    check: mid[index]["check"],
                    image2: mid[index]["image2"],
                    image1: mid[index]["image1"],
                    eyes: mid[index]["eyes"],
                    hearts: mid[index]["hearts"],
                    chats: mid[index]["chats"],
                    clinic: mid[index]["clinic"],
                    name: mid[index]["name"],
                    onpress: () {
                      Navigator.of(context).pushNamed("/Diary_Detail");
                    },
                    price: mid[index]["price"],
                    sentence: mid[index]["sentence"],
                    type: mid[index]["type"],
                  );
                }),
          )),
        ],
      ),
    );
  }
}

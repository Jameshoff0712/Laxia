import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Favorite_Counseling extends StatefulWidget {
  const Favorite_Counseling({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorite_Counseling> createState() => _Favorite_CounselingState();
}

class _Favorite_CounselingState extends State<Favorite_Counseling> {
  bool expanded = true;
  int index = -1;
  List mid = [];
  @override
  void initState() {
    for (int i = 0; i < counseling_list.length; i++)
      setState(() {
        mid.add(counseling_list[i]);
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
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                    onpress: () {
                      Navigator.of(context).pushNamed("/CounselDetail");
                    },
                    sentence: mid[index]["sentence"],
                    type: mid[index]["type"],
                    clinic: mid[index]["clinic"],
                  );
                }),
          )),
        ],
      ),
    );
  }
}

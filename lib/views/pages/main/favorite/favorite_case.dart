import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/case_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Favorite_Case extends StatefulWidget {
  const Favorite_Case({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorite_Case> createState() => _Favorite_CaseState();
}

class _Favorite_CaseState extends State<Favorite_Case> {
  bool expanded = true;
  int index = -1;
  List mid = [];
  @override
  void initState() {
    for (int i = 0; i < case_list.length; i++)
      setState(() {
        mid.add(case_list[i]);
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
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                itemCount: mid.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Diary_Card(
                    onpress: () {
                      Navigator.of(context).pushNamed("/CaseDetail");
                    },
                    buttoncolor: Helper.btnBgMainColor,
                    buttontext: mid[index]["buttontext"],
                    avator: mid[index]["avator"],
                    check: mid[index]["check"],
                    image2: mid[index]["image2"],
                    image1: mid[index]["image1"],
                    eyes: mid[index]["eyes"],
                    name: mid[index]["name"],
                    price: mid[index]["price"],
                    sentence: mid[index]["sentence"],
                    type: mid[index]["type"],
                    isFavorite: true,
                  );
                }),
          )),
        ],
      ),
    );
  }
}

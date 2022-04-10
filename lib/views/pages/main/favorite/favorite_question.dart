import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/question_model.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/question_card.dart';

class Favorite_Question extends StatefulWidget {
  const Favorite_Question({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorite_Question> createState() => _Favorite_QuestionState();
}

class _Favorite_QuestionState extends State<Favorite_Question> {
  List mid = [];
  @override
  void initState() {
    for (int i = 0; i < question_list.length; i++)
      setState(() {
        mid.add(question_list[i]);
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
                  return Question_Card(
                    buttoncolor: Helper.allowStateButtonColor,
                    buttontext: "回答あり",
                    hearts: mid[index]["hearts"],
                    chats: mid[index]["chats"],
                    avator: mid[index]["avator"],
                    image2: mid[index]["image2"],
                    image1: mid[index]["image1"],
                    eyes: mid[index]["eyes"],
                    name: mid[index]["name"],
                    onpress: () {
                      Navigator.of(context).pushNamed("/QuestionDetail");
                    },
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

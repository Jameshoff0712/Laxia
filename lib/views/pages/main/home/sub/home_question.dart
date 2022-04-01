import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/question_model.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/question_card.dart';

class Home_Question extends StatefulWidget {
  final bool issearch;
  final List? model;
  const Home_Question({Key? key, required this.issearch, this.model})
      : super(key: key);

  @override
  State<Home_Question> createState() => _Home_QuestionState();
}

class _Home_QuestionState extends State<Home_Question> {
  List mid = [];
  @override
  void initState() {
    if (!widget.issearch) {
      for (int i = 0; i < question_list.length; i++)
        setState(() {
          mid.add(question_list[i]);
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
                  child: Dropdownbutton(
                      items: <String>["回答あり", "回答なし"],
                      hintText: "絞り込み",
                      horizontal: 60),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["人気投稿順", "新着順"],
                      hintText: "並び替え",
                      horizontal: 60),
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
                        onpress: () {},
                        sentence: mid[index]["sentence"],
                        type: mid[index]["type"],
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}

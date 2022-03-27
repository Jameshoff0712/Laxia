import 'package:flutter/material.dart';
import 'package:laxia/models/question_model.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/question_card.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Question extends StatefulWidget {
  const Home_Question({ Key? key }) : super(key: key);

  @override
  State<Home_Question> createState() => _Home_QuestionState();
}

class _Home_QuestionState extends State<Home_Question> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(250, 240, 242, 245),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["回答あり","回答なし"],
                      hintText: "絞り込み",
                      horizontal: 60),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["人気投稿順","新着順"],
                      hintText: "並び替え",
                      horizontal: 60),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding:EdgeInsets.only(top:8,left:8,right:8),
                itemCount: question_list.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Question_Card(
                    buttoncolor: Color.fromARGB(255,110, 198, 210),
                    buttontext: "回答あり",
                    hearts: question_list[index].hearts,
                    chats: question_list[index].chats,
                    avator: question_list[index].avator,
                    image2:  question_list[index].image2,
                    image1:  question_list[index].image1,
                    eyes:  question_list[index].eyes,
                    name:  question_list[index].name,
                    onpress: () {},
                    sentence:  question_list[index].sentence,
                    type:  question_list[index].type,
                  );
                }),
          ),
        ],
        
      ),
    );
  }
}
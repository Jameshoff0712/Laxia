import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/models/question_model.dart';
import 'package:laxia/views/pages/main/contribution/question_detail.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/question_card.dart';

class Home_Question extends StatefulWidget {
  final List<Question_Sub_Model> questions;
  const Home_Question({Key? key, required this.questions})
      : super(key: key);

  @override
  State<Home_Question> createState() => _Home_QuestionState();
}

class _Home_QuestionState extends State<Home_Question> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, BoxConstraints viewportConstraints) {
                return ListView.builder(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    itemCount: widget.questions.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Question_Card(
                        isanswer: widget.questions[index].answers.isNotEmpty,
                        hearts: widget.questions[index].likes_count==null?"":widget.questions[index].likes_count!.toString(),
                        chats: widget.questions[index].comments_count==null?"":widget.questions[index].comments_count.toString(),
                        avator:widget.questions[index].owner!.photo==null?"http://error.png": widget.questions[index].owner!.photo!,
                        image2: (widget.questions[index].medias!.isEmpty||widget.questions[index].medias!.length==1)?"http://error.png":widget.questions[index].medias![1].path,
                        image1:widget.questions[index].medias!.isEmpty?"http://error.png":widget.questions[index].medias![0].path,
                        eyes: widget.questions[index].views_count==null?"":widget.questions[index].views_count!.toString(),
                        name:widget.questions[index].owner!.name==null?"": widget.questions[index].owner!.name!,
                        onpress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionDetail(index:  widget.questions[index].id)));
                          //Navigator.of(context).pushNamed("/QuestionDetail");
                        },
                        sentence:widget.questions[index].content==null?"": widget.questions[index].content!,
                        type:"二重切開" //widget.questions[index]["type"],
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

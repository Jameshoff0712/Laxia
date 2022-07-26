import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/models/question_model.dart';
import 'package:laxia/views/pages/main/contribution/question_detail.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/question_card.dart';

class Home_Question extends StatefulWidget {
  final List<Question_Sub_Model> questions;
  final List<Category> categories;
  const Home_Question({Key? key, required this.questions, required this.categories})
      : super(key: key);

  @override
  State<Home_Question> createState() => _Home_QuestionState();
}

class _Home_QuestionState extends State<Home_Question> {
  int select=-1;
  bool expanded = true;
  bool isShow(Question_Sub_Model menu){
    if(select==-1)
       return false;
    for(int i=0;i<menu.categories!.length;i++){
      if(menu.categories![i].id==select){
        return false;
      }
    }
    return true;
  }
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
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
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
                            i <
                                widget.categories
                                    .length;
                            i++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if(select==widget.categories[i].id)
                                  select=-1;
                                else
                                  select=widget.categories[i].id;
                              });
                              // select=widget.categories[i].id;
                              // surgeryprovider.setSelectedCurePos(widget.categories![i].id,widget.categories[i].name);
                              // print(surgeryprovider.selectedCurePos.join(','));
                              // setState(() {
                              //   willSelect[i]=!willSelect[i];
                              // });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(22),
                                  border: Border.all(
                                      width: 1,
                                      color: Helper.mainColor),
                                  color: select==widget.categories[i].id //willSelect[i]
                                      ? Helper.mainColor
                                      : Helper.whiteColor),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                child: Text(
                                  widget.categories[i].name,
                                  style: TextStyle(
                                      fontWeight:
                                          FontWeight.w400,
                                      fontSize: 12,
                                      color:select==widget.categories[i].id //willSelect[i]
                                          ? Helper.whiteColor
                                          : Helper.mainColor),
                                ),
                              ),
                            ),
                          )
                      ]),
                ],
              ),
            ),
          ),
          GestureDetector(
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
                    expanded?"すべて表示":"閉じる",
                    style: TextStyle(
                        color: Helper.mainColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  SizedBox(
                    width: 8.41,
                  ),
                  
                  Icon(
                    expanded? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                    color: Helper.mainColor,
                    size: 24,
                  ),
                ]),
          ),
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
                        images: widget.questions[index].medias!,
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
                        type:widget.questions[index].categories!
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

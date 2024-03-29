import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/question/question_model.dart';
import 'package:laxia/views/pages/main/contribution/question_detail.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/question_card.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Home_Question extends StatefulWidget {
  final List? last;
  final bool?isdrawer;
  const Home_Question({Key? key, this.isdrawer=true, this.last})
      : super(key: key);

  @override
  State<Home_Question> createState() => _Home_QuestionState();
}

class _Home_QuestionState extends State<Home_Question> {
  String searchdata="";
  String filter='';
  String isanswer='';
  bool isloading = true,isexpanding=true,isend=false;
  int page = 1;
  bool expanded=false,first=true;
  int index=-1;
  late Question question_data;
  final _con = HomeController();
  Future<void> getData({required String page}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getQuestionData(page: page,q: searchdata,filter:filter,isanswer:isanswer);
        
        if (mid.data.isEmpty) {
          setState(() {
            isexpanding = true;
            isend = true;
          });
        }
        setState(() {
          if (isloading) {
            question_data = mid;
            isloading = false;
          } else {
            question_data.data.addAll(mid.data);
            isexpanding = true;
          }
        });
      }
    } catch (e) {
      setState(() {
        isexpanding = true;
        isend = true;
        // print(e.toString());
      });
    }
  }
  void init(){
    setState(() {
       isloading = true;
       isexpanding=true;
       isend=false;
       page = 1;
       expanded=false;
       index=-1;
    });
  }
  @override
  void initState() {
    getData(page: page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    if(first){
      setState(() {
        searchdata = userProperties.searchtext;
        getData(page: page.toString());
        first=false;
      });
    } 
    if(searchdata!=userProperties.searchtext){
      init();
      setState(() {
        searchdata=userProperties.searchtext;
        getData(page: page.toString());
      });
    }
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
                  child: Dropdownbutton(
                      onpress: (val){
                        setState(() {
                          isanswer=val;
                          page=1;
                          isend = false;
                          isloading = true;
                        });
                        getData(page: page.toString());
                      },
                      items: <String>["回答あり", "回答なし"],
                      hintText: "絞り込み",
                      horizontal: 60),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      onpress: (val){
                        setState(() {
                          filter=val;
                          page=1;
                          isend = false;
                          isloading = true;
                        });
                        // print(val);
                        getData(page: page.toString());
                      },
                      items: <String>["人気投稿順", "新着順"],
                      hintText: "並び替え",
                      horizontal: 60),
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
                      GestureDetector(
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
            child: isloading
              ? Container(
                  child: Container(
                  height: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Center(
                    child: new CircularProgressIndicator(),
                  ),
                )):question_data.data.isNotEmpty? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==scrollInfo.metrics.maxScrollExtent) {
                        if(isexpanding&&!isend){
                          getData(page: (page+1).toString());
                          setState(() {
                            page+=1;
                          }); 
                        }
                      }else  if (scrollInfo.metrics.pixels ==scrollInfo.metrics.minScrollExtent) {
                        //widget.scrollTop!();
                      }
                      return true;
                    },
                  child: LayoutBuilder(
                              builder: (context, BoxConstraints viewportConstraints) {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      itemCount: question_data.data.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Question_Card(
                          isanswer: question_data.data[index].answers.isNotEmpty,
                          hearts: question_data.data[index].likes_count==null?"":question_data.data[index].likes_count!.toString(),
                          chats: question_data.data[index].comments_count==null?"":question_data.data[index].comments_count.toString(),
                          avator:question_data.data[index].owner!.photo==null?"http://error.png": question_data.data[index].owner!.photo!,
                          images: question_data.data[index].medias!,
                          eyes: question_data.data[index].views_count==null?"":question_data.data[index].views_count!.toString(),
                          name:question_data.data[index].owner!.name==null?"": question_data.data[index].owner!.name!,
                          onpress: () { 
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuestionDetail(index:  question_data.data[index].id)));
                            //Navigator.of(context).pushNamed("/QuestionDetail");
                          },
                          sentence:question_data.data[index].content==null?"": question_data.data[index].content!,
                          type:question_data.data[index].categories!,
                        );
                      });
                              },
                            ),
                )
                : Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        SvgPicture.asset(
                          "assets/images/LAXIA.svg",
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          '検索結果がありません',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            fontWeight: FontWeight.w700,
                            color: Helper.txtColor,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          Container(
                    height: isexpanding ? 0 : 100,
                    color: Colors.transparent,
                    child: Center(
                      child: new CircularProgressIndicator(),
                    ),
                  )
        ],
      ),
    );
  }
}

import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/views/pages/main/contribution/counsel_detail.dart';
import 'package:laxia/views/widgets/counseling_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Counseling extends StatefulWidget {
  final List<Counceling_Sub_Model> councelings;
  final List<Category> categories;
  const Home_Counseling({Key? key, required this.councelings, required this.categories, })
      : super(key: key);

  @override
  State<Home_Counseling> createState() => _Home_CounselingState();
}

class _Home_CounselingState extends State<Home_Counseling> {
  @override
  void initState() {
    super.initState();
  }
  int select=-1;
  bool expanded = true;
  bool isShow(Counceling_Sub_Model menu){
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
                  itemCount: widget.councelings.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return isShow(widget.councelings[index])?Container():Counseling_Card(
                        hearts: widget.councelings[index].likes_count==null?"":widget.councelings[index].likes_count!.toString(),
                        chats: widget.councelings[index].comments_count==null?"":widget.councelings[index].comments_count.toString(),
                        avator:widget.councelings[index].patient_photo==null?"http://error.png": widget.councelings[index].patient_photo!,
                        check: widget.councelings[index].doctor_name==null?"":widget.councelings[index].doctor_name!,
                        images:widget.councelings[index].media_self!,
                        eyes: widget.councelings[index].views_count==null?"":widget.councelings[index].views_count!.toString(),
                        name: widget.councelings[index].patient_nickname==null?"":widget.councelings[index].patient_nickname!,
                         onpress: (){
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CounselDetail(index:  widget.councelings[index].id)));
                          },
                        sentence:widget.councelings[index].content==null?"": widget.councelings[index].content!,
                        type:widget.councelings[index].categories!,
                        clinic:widget.councelings[index].clinic_name==null?"": widget.councelings[index].clinic_name!,
                      );
                  });
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Diary extends StatefulWidget {
  final List<Diary_Sub_Model> diaries;
  final List<Category> categories;
  const Home_Diary({Key? key, required this.diaries, required this.categories,})
      : super(key: key);

  @override
  State<Home_Diary> createState() => _Home_DiaryState();
}

class _Home_DiaryState extends State<Home_Diary> {
  @override
  void initState() {
    super.initState();
  }
  int select=-1;
  bool expanded = true;
  bool isShow(Diary_Sub_Model menu){
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
              return Column(
                children: [
                  // menuAppBar(context),
                  Expanded(
                    child: LayoutBuilder(
                        builder: (context, BoxConstraints viewportConstraints) {
                      return ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: widget.diaries.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap:true,
                          itemBuilder: (BuildContext context, int index) {
                            return isShow(widget.diaries[index])?Container(): Diary_Card(
                              avator:
                                  widget.diaries[index].patient_photo == null
                                      ? "http://error.png"
                                      : widget.diaries[index].patient_photo!,
                              check: widget.diaries[index].doctor_name == null
                                  ? ""
                                  : widget.diaries[index].doctor_name!,
                              image2: widget.diaries[index].after_image == null
                                  ? "http://error.png"
                                  : widget.diaries[index].after_image!,
                              image1:
                                  widget.diaries[index].before_image == null
                                      ? "http://error.png"
                                      : widget.diaries[index].before_image!,
                              eyes: widget.diaries[index].views_count == null
                                  ? ""
                                  : widget.diaries[index].views_count!
                                      .toString(),
                              clinic: widget.diaries[index].clinic_name == null
                                  ? ""
                                  : widget.diaries[index].clinic_name!,
                              name: widget.diaries[index].patient_nickname ==
                                      null
                                  ? ""
                                  : widget.diaries[index].patient_nickname!,
                              onpress: () {
                                Navigator.of(context).push( MaterialPageRoute(builder: (_) => Diary_Detail(index:widget.diaries[index].id)));
                              },
                              price: widget.diaries[index].price == null
                                  ? ""
                                  : widget.diaries[index].price.toString(),
                              sentence:
                                  widget.diaries[index].doctor_name == null
                                      ? ""
                                      : widget.diaries[index].doctor_name!,
                              type: widget.diaries[index].doctor_name == null
                                  ? ""
                                  : widget.diaries[index].doctor_name!,
                            );
                          });
                    }),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

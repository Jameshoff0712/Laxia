import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/case_model.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/views/pages/main/contribution/case_detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Case extends StatefulWidget {
  final List<Case_Sub_Model> cases;
  final List<Category> categories;
  const Home_Case({Key? key, required this.cases, required this.categories})
      : super(key: key);

  @override
  State<Home_Case> createState() => _Home_CaseState();
}

class _Home_CaseState extends State<Home_Case> {
  @override
  void initState() {
    super.initState();
  }
 int select=-1;
 bool expanded = true;
  bool isShow(Case_Sub_Model menu){
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
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return Column(
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
                              // select=widget.categories[i].id;
                              setState(() {
                                if(select==widget.categories[i].id)
                                  select=-1;
                                else
                                  select=widget.categories[i].id;
                              });
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
                  // menuAppBar(context),
                  Expanded(
                    child: LayoutBuilder(
                        builder: (context, BoxConstraints viewportConstraints) {
                      return
                      ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: widget.cases.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return isShow(widget.cases[index])?Container():Diary_Card(
                              onpress: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CaseDetail(index:  widget.cases[index].id)));
                                // Navigator.of(context).pushNamed("/CaseDetail");
                              },
                              buttoncolor: Helper.btnBgMainColor,
                              buttontext: "症例",
                              avator:
                                  widget.cases[index].clinic!.photo == null
                                      ? "http://error.png"
                                      : widget.cases[index].clinic!.photo!,
                              check: widget.cases[index].doctor == null
                                  ? ""
                                  : widget.cases[index].doctor!.name!,
                              image2:widget.cases[index].beforeimage!.isEmpty?"http://error.png":
                                  widget.cases[index].beforeimage![0].path,
                              image1:widget.cases[index].afterimage!.isEmpty?"http://error.png":
                                  widget.cases[index].afterimage![0].path,
                              eyes: widget.cases[index].views_count == null
                                  ? ""
                                  : widget.cases[index].views_count
                                      .toString(),
                              name: widget.cases[index].clinic!.name == null
                                  ? ""
                                  : widget.cases[index].clinic!.name!,
                              price:widget.cases[index].menus!.isEmpty?"":(widget.cases[index].menus![0].price==null?"": widget.cases[index].menus![0].price!.toString()),
                              sentence: widget.cases[index].treat_risk == null
                                  ? ""
                                  : widget.cases[index].treat_risk!,
                              type:
                                  widget.cases[index].case_description == null
                                      ? ""
                                      : widget.cases[index].case_description!,
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

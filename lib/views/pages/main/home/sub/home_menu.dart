import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/models/menu_model.dart';

class Home_Menu extends StatefulWidget {
  final bool? isScrollable,isdrawer;
  final VoidCallback? scrollTop;
  final bool issearch;
  final List? model,last;
  Home_Menu({Key? key, this.model, required this.issearch, this.isScrollable=true, this.scrollTop=null, this.isdrawer=true, this.last}) : super(key: key);

  @override
  State<Home_Menu> createState() => _Home_MenuState();
}

class _Home_MenuState extends State<Home_Menu> {
  bool expanded=true;
  int index=-1;
  List mid = [];
  late ScrollController scrollController;
  @override
  void initState() {
    if (!widget.issearch) {
      for (int i = 0; i < menu_list.length; i++)
        setState(() {
          mid.add(menu_list[i]);
        });
    } else {
      for (int i = 0; i < widget.model!.length; i++)
        setState(() {
          mid.add(widget.model![i]);
        });
    }
    scrollController=ScrollController();
      scrollController.addListener((){
        if (scrollController.offset <= scrollController.position.minScrollExtent &&
            !scrollController.position.outOfRange) {
          setState(() {
            widget.scrollTop!();
          });
        }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: TextButton_Drawer(
                        width: 123,
                        textname: "エリア選択",
                        onpress: () {
                          Navigator.of(context).pushNamed("/SelectPrefecture");
                        })), //SelectPrefecture
                Expanded(
                  flex: 3,
                  child: TextButton_Drawer(
                      width: 123,
                      textname: "悩み・目的",
                      onpress: () {
                        Navigator.of(context).pushNamed("/SelectSurgery");
                      }),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["日記数が多い順", "評価が高い順","値段が高い順","値段が安い順"],
                      hintText: "並び替え",
                      horizontal: 20),
                ),
              ],
            ),
          ):
          SizedBox(height: 0,),
          Expanded(
            child: SingleChildScrollView(
              physics: widget.isScrollable!?AlwaysScrollableScrollPhysics():NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  widget.isdrawer!?SizedBox(height: 0,):
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
                              InkWell(
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                expanded = !expanded;
                              });
                            },
                            child: Icon(
                                    expanded
                                        ? FontAwesomeIcons.angleDown
                                        : FontAwesomeIcons.angleUp,
                                    size: 24,
                                    color: Helper.titleColor,
                                  ),
                          ),
                      ],
                    ),
                  ),
                  ListView.builder(
                     padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: mid.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap:true,
                    itemBuilder: (BuildContext context, int index) {
                      return Menu_Card(
                        onpress: (){
                          Navigator.of(context).pushNamed("/Menu_Detail");
                        },
                          image: mid[index]["image"],
                          heading: mid[index]["heading"],
                          price: mid[index]["price"],
                          tax: mid[index]["tax"],
                          clinic: mid[index]["clinic"]);
                    }),
                ],
              ),
            ),
          ),
        ],
        
      ),
    );
  }
}

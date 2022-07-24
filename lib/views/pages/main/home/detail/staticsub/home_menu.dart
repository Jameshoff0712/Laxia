import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/models/menu/menu_Sub_Model.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:provider/provider.dart';

class Home_Menu extends StatefulWidget {
  final List<Menu_Sub_Model> menus;
  final List<Category> categories;
  Home_Menu({Key? key, required this.menus, required this.categories}) : super(key: key);

  @override
  State<Home_Menu> createState() => _Home_MenuState();
}

class _Home_MenuState extends State<Home_Menu> {
  bool expanded = true;
  // List<bool> willSelect = [];
  int select=-1;
  @override
  void initState() {
    // for (int i = 0; i < widget.categories.length; i++) {
    //     setState(() {
    //         willSelect.add(false);
    //     });
    //   }
    super.initState();
  }
  bool isShow(Menu_Sub_Model menu){
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
    SurGeryProvider surgeryprovider =
        Provider.of<SurGeryProvider>(context, listen: true);
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: LayoutBuilder(
                  builder: (context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    Expanded(
                      child: LayoutBuilder(builder:
                          (context, BoxConstraints viewportConstraints) {
                        return ListView.builder(
                            itemCount: widget.menus.length,
                          physics:AlwaysScrollableScrollPhysics(),
                          shrinkWrap:true,
                            // physics: const AlwaysScrollableScrollPhysics(),
                            // scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return isShow(widget.menus[index])?Container():Menu_Card(
                                onpress: (){
                                  //Navigator.of(context).pushNamed("/Menu_Detail");
                                  Navigator.of(context).push( MaterialPageRoute(builder: (_) => Menu_Detail(index: widget.menus[index].id)));
                                },
                                  image:  widget.menus[index].images!.isEmpty?"http://error.png":  widget.menus[index].images![0].path,
                                  heading:  widget.menus[index].description==null?"": widget.menus[index].description!,
                                  price:  widget.menus[index].price==0?"": widget.menus[index].price!.toString(),
                                  clinic:  widget.menus[index].name
                              );
                            });
                      }),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

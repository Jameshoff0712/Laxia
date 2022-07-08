import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/menu/menu_Sub_Model.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Menu extends StatefulWidget {
  final List<Menu_Sub_Model> menus;
  Home_Menu({Key? key, required this.menus}) : super(key: key);

  @override
  State<Home_Menu> createState() => _Home_MenuState();
}

class _Home_MenuState extends State<Home_Menu> {
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
                              return Menu_Card(
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

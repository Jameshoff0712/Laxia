import 'package:flutter/material.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/models/menu_model.dart';

class Home_Menu extends StatefulWidget {
  final bool  issearch;
  final List ? model;
  Home_Menu({Key? key, this.model, required this.issearch}) : super(key: key);

  @override
  State<Home_Menu> createState() => _Home_MenuState();
}

class _Home_MenuState extends State<Home_Menu> {
  List mid=[];
  @override
  void initState(){
    if(!widget.issearch){
      for(int i=0;i<menu_list.length;i++)
        setState((){
          mid.add(menu_list[i]);
        });
    }else{
      for(int i=0;i<widget.model!.length;i++)
      setState((){
        mid.add(widget.model![i]);
      });
    }
    super.initState();
  }
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
                    child: TextButton_Drawer(
                        width: 123,
                        textname: "エリア選択",
                        onpress: () {
                           Navigator.of(context).pushNamed("/SelectPrefecture");
                        })), //SelectPrefecture
                Expanded(
                  flex: 3,
                  child: TextButton_Drawer(
                      width: 123, textname: "悩み・目的", onpress: () {
                        Navigator.of(context).pushNamed("/SelectSurgery");
                      }),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["日記数が多い順", "評価が高い順", "値段が高い順", "値段が安い順"],
                      hintText: "並び替え",
                      horizontal: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: LayoutBuilder(
                  builder: (context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: mid.length,
                          // physics: const AlwaysScrollableScrollPhysics(),
                          // scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Menu_Card(
                                image: mid[index]["image"],
                                heading: mid[index]["heading"],
                                price: mid[index]["price"],
                                tax: mid[index]["tax"],
                                clinic: mid[index]["clinic"]);
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

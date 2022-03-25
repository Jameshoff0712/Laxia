import 'package:flutter/material.dart';
import 'package:laxia/views/pages/main/home/selectprefecture.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/models/menu_model.dart';

class Home_Menu extends StatefulWidget {
  const Home_Menu({Key? key}) : super(key: key);

  @override
  State<Home_Menu> createState() => _Home_MenuState();
}

class _Home_MenuState extends State<Home_Menu> {
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectPrefecture()));
                        })), //SelectPrefecture
                Expanded(
                  flex: 3,
                  child: TextButton_Drawer(
                      width: 123, textname: "悩み・目的", onpress: () {}),
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
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: menu_list.length,
                        // physics: const AlwaysScrollableScrollPhysics(),
                        // scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Menu_Card(
                              image: menu_list[index].image,
                              heading: menu_list[index].heading,
                              price: menu_list[index].price,
                              tax: menu_list[index].tax,
                              clinic: menu_list[index].clinic);
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

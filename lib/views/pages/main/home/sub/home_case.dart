import 'package:flutter/material.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Case extends StatefulWidget {
  const Home_Case({ Key? key }) : super(key: key);

  @override
  State<Home_Case> createState() => _Home_CaseState();
}

class _Home_CaseState extends State<Home_Case> {
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
                        width: 123, textname: "エリア選択", onpress: () {})),
                Expanded(
                  flex: 3,
                  child: TextButton_Drawer(
                      width: 123, textname: "絞り込み", onpress: () {}),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["人気投稿順","新着順"],
                      hintText: "並び替え",
                      horizontal: 20),
                ),
              ],
            ),
          ),
        ],
        
      ),
    );
  }
}
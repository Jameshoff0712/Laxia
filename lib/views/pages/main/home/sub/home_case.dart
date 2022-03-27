import 'package:flutter/material.dart';
import 'package:laxia/models/case_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
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
                        width: 123, textname: "エリア選択", onpress: () {
                           Navigator.of(context).pushNamed("/SelectPrefecture");
                        })),
                Expanded(
                  flex: 3,
                  child: TextButton_Drawer(
                      width: 123, textname: "絞り込み", onpress: () {
                         Navigator.of(context).pushNamed("/NarrowCase");
                      }),
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
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return Column(
                children: [
                  // menuAppBar(context),
                  Expanded(
                    child: ListView.builder(
                        padding:EdgeInsets.only(top:8,left:8,right:8),
                        itemCount: case_list.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Diary_Card(
                            buttoncolor: Color.fromARGB(255,110, 198, 210),
                            buttontext: case_list[index].buttontext,
                            hearts: case_list[index].hearts,
                            chats: case_list[index].chats,
                            avator: case_list[index].avator,
                            check: case_list[index].check,
                            image2:  case_list[index].image2,
                            image1:  case_list[index].image1,
                            eyes:  case_list[index].eyes,
                            name:  case_list[index].name,
                            onpress: () {},
                            price:  case_list[index].price,
                            sentence:  case_list[index].sentence,
                            type:  case_list[index].type,
                          );
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
import 'package:flutter/material.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Diary extends StatefulWidget {
  const Home_Diary({Key? key}) : super(key: key);

  @override
  State<Home_Diary> createState() => _Home_DiaryState();
}

class _Home_DiaryState extends State<Home_Diary> {
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
                        Navigator.of(context).pushNamed("/NarrowDiary");
                      }),
                ),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                      items: <String>["人気投稿順", "満足度が高い順", "新着順"],
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
                        padding:EdgeInsets.all(8),
                        itemCount: diary_list.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Diary_Card(
                            avator: diary_list[index].avator,
                            check: diary_list[index].check,
                            image2:  diary_list[index].image2,
                            image1:  diary_list[index].image1,
                            eyes:  diary_list[index].eyes,
                            clinic:  diary_list[index].clinic,
                            name:  diary_list[index].name,
                            onpress: () {},
                            price:  diary_list[index].price,
                            sentence:  diary_list[index].sentence,
                            type:  diary_list[index].type,
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

import 'package:flutter/material.dart';
import 'package:laxia/models/counseling_model%20.dart';
import 'package:laxia/views/pages/main/home/selectprefecture.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Counseling extends StatefulWidget {
  const Home_Counseling({ Key? key }) : super(key: key);

  @override
  State<Home_Counseling> createState() => _Home_CounselingState();
}

class _Home_CounselingState extends State<Home_Counseling> {
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
                           Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectPrefecture()));
                        })),
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
          Expanded(
            child: ListView.builder(
                padding:EdgeInsets.all(8),
                itemCount: counseling_list.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Counseling_Card(
                    hearts: counseling_list[index].hearts,
                    chats: counseling_list[index].chats,
                    avator: counseling_list[index].avator,
                    check: counseling_list[index].check,
                    image2:  counseling_list[index].image2,
                    image1:  counseling_list[index].image1,
                    image3:  counseling_list[index].image3,
                    image4:  counseling_list[index].image4,
                    eyes:  counseling_list[index].eyes,
                    name:  counseling_list[index].name,
                    onpress: () {},
                    sentence:  counseling_list[index].sentence,
                    type:  counseling_list[index].type,
                    clinic: counseling_list[index].clinic,
                  );
                }),
          ),
        ],
        
      ),
    );
  }
}
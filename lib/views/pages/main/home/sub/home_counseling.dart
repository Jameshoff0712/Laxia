import 'package:flutter/material.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Counseling extends StatefulWidget {
  final bool  issearch;
  final List ? model;
  const Home_Counseling({ Key? key, required this.issearch, this.model }) : super(key: key);

  @override
  State<Home_Counseling> createState() => _Home_CounselingState();
}

class _Home_CounselingState extends State<Home_Counseling> {
  List mid=[];
  @override
  void initState(){
    if(!widget.issearch){
      for(int i=0;i<counseling_list.length;i++)
        setState((){
          mid.add(counseling_list[i]);
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
                        width: 123, textname: "エリア選択", onpress: () {
                            Navigator.of(context).pushNamed("/SelectPrefecture");
                        })),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                     items: <String>["人気投稿順", "新着順"],
                      hintText: "並び替え",
                      horizontal: 60),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding:EdgeInsets.only(top:8,left:8,right:8),
                itemCount: mid.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Counseling_Card(
                    hearts: mid[index]["hearts"],
                    chats: mid[index]["chats"],
                    avator: mid[index]["avator"],
                    check: mid[index]["check"],
                    image2:  mid[index]["image2"],
                    image1:  mid[index]["image1"],
                    image3:  mid[index]["image3"],
                    image4:  mid[index]["image4"],
                    eyes:  mid[index]["eyes"],
                    name:  mid[index]["name"],
                    onpress: () {},
                    sentence:  mid[index]["sentence"],
                    type:  mid[index]["type"],
                    clinic: mid[index]["clinic"],
                  );
                }),
          ),
        ],
        
      ),
    );
  }
}
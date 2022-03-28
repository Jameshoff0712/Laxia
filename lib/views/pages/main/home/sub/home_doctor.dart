import 'package:flutter/material.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';


class Home_Doctor extends StatefulWidget {
  final bool  issearch;
  final List ? model;
  const Home_Doctor({Key? key, required this.issearch, this.model}) : super(key: key);

  @override
  State<Home_Doctor> createState() => _Home_DoctorState();
}

class _Home_DoctorState extends State<Home_Doctor> {
  List mid=[];
  @override
  void initState(){
    if(!widget.issearch){
      for(int i=0;i<doctor_list.length;i++)
        setState((){
          mid.add(doctor_list[i]);
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
                     items: <String>["評価が高い順", "日記の多い順"],
                      hintText: "並び替え",
                      horizontal: 60),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: LayoutBuilder(builder: (context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    // menuAppBar(context),
                    Expanded(
                      child: ListView.builder(
                          itemCount: mid.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Doctor_Card(
                                image: mid[index]["image"],
                                post: mid[index]["post"],
                                name: mid[index]["name"],
                                mark: mid[index]["mark"],
                                day: mid[index]["day"],
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

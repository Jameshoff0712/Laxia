import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';


class Home_Doctor extends StatefulWidget {
  final bool? isScrollable,isdrawer;
  final VoidCallback? scrollTop;
  final bool  issearch;
  final List ? model;
  const Home_Doctor({Key? key, required this.issearch, this.model, this.isScrollable=true, this.scrollTop=null, this.isdrawer=true}) : super(key: key);

  @override
  State<Home_Doctor> createState() => _Home_DoctorState();
}

class _Home_DoctorState extends State<Home_Doctor> {
  List mid=[];
  late ScrollController scrollController;
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
    scrollController=ScrollController();
      scrollController.addListener((){
        if (scrollController.offset <= scrollController.position.minScrollExtent &&
            !scrollController.position.outOfRange) {
          setState(() {
            widget.scrollTop!();
          });
        }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
           widget.isdrawer!? Container(
            color: Helper.whiteColor,
           child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: TextButton_Drawer(
                        width: 123, textname: "エリア選択", onpress: () {})),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                     items: <String>["評価が高い順", "日記の多い順"],
                      hintText: "並び替え",
                      horizontal: 60),
                ),
              ],
            ),
          ):SizedBox(height: 0,),
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
                          controller:scrollController,
                          physics: widget.isScrollable!?AlwaysScrollableScrollPhysics():NeverScrollableScrollPhysics(),
                          shrinkWrap:true,
                          itemBuilder: (BuildContext context, int index) {
                            return Doctor_Card(
                                onpress: (){
                                  Navigator.of(context).pushNamed("/Doctor_Detail");
                                },
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

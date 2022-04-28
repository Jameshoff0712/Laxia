import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/doctor/doctor_model.dart';
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
  int page=0;
  bool isend=false,isloading=true,isexpanding=true;
  late Doctor doctor_data;
  final _con = HomeController();
  Future<void> getData(
      {required String page}) async {
    try {
      if(!isend){
        if(!isloading)
            setState(() {
              isexpanding=false;
            });
        final mid = await _con.getDoctorData(
            page: page);
            if (mid.data.isEmpty) {
          setState(() {
            isexpanding = true;
            isend = true;
          });
        }
          setState(() {
          if (isloading) {
            doctor_data=mid;
            isloading = false;    
          } else {
            doctor_data.data.addAll(mid.data);
            isexpanding=true;
          }
        });
      }
    } catch (e) {
      setState(() {
        isexpanding=true;
        isend=true;
        print(e.toString());
      });
    }
  }
  @override
  void initState(){
    getData(page: page.toString());
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
          ):SizedBox(height: 0,),
          Expanded(
            child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==scrollInfo.metrics.maxScrollExtent) {
                              if(isexpanding&&!isend){
                                getData(page: (page+1).toString());
                                setState(() {
                                  page+=1;
                                }); 
                              }
                            }else  if (scrollInfo.metrics.pixels ==scrollInfo.metrics.minScrollExtent) {
                              //widget.scrollTop!();
                            }
                            return true;
                          },
                          child:
            LayoutBuilder(builder: (context, BoxConstraints viewportConstraints) {
              return Column(
                children: [
                  Expanded(
                    child: isloading?Container(
                            child: Container(
                            height: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Center(
                              child: new CircularProgressIndicator(),
                            ),
                          )): ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          itemCount: doctor_data.data.length,
                          physics: widget.isScrollable!?AlwaysScrollableScrollPhysics():NeverScrollableScrollPhysics(),
                          shrinkWrap:true,
                          itemBuilder: (BuildContext context, int index) {
                            return Doctor_Card(
                                onpress: (){
                                  Navigator.of(context).pushNamed("/Doctor_Detail");
                                },
                                image: doctor_data.data[index].photo==null?"http://error.png": doctor_data.data[index].photo!,
                                post: "院長", //doctor_data.data[index]["post"],
                                name: doctor_data.data[index].hira_name,
                                mark:4.8.toString(), //doctor_data.data[index]["mark"],
                                day:222.toString(), //doctor_data.data[index]["day"],
                                clinic: "湘南美容クリニック 新宿院" //doctor_data.data[index].clinic_id .toString()
                              );
                          }),
                    ),
                  Container(
                    height:isexpanding?0: 100,
                    color: Colors.transparent,
                    child: Center(
                      child: new CircularProgressIndicator(),
                    ),
                  )
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

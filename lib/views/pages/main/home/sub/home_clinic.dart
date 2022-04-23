import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/clinic_model.dart';
import 'package:laxia/models/home_modell.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Clinic extends StatefulWidget {
  final bool? isScrollable;
  final VoidCallback? scrollTop;
  final bool issearch;
  final List? model;
  const Home_Clinic(
      {Key? key,
      required this.issearch,
      this.model,
      this.isScrollable = true,
      this.scrollTop = null})
      : super(key: key);

  @override
  State<Home_Clinic> createState() => _Home_ClinicState();
}

class _Home_ClinicState extends State<Home_Clinic> {
  bool isLoading=true,isupdate=false;
  int page = 1;
  late int pref_id;
  late int city_id;
  List mid = [];
  late ScrollController scrollController;
  late Home clinic_data;
  final _con = HomeController();
  Future<void> getData(
      {required String page,
      String? pref_id = "",
      String? city_id = ""}) async {
    try {
      final mid = await _con.getclinicData(
          page: page, pref_id: pref_id!, city_id: city_id!);
      setState(() {
        if (isLoading) {
          setState(() {
            clinic_data = mid;
            isLoading=false;
          });
        } else {
          setState(() {
            clinic_data.data.addAll(mid.data);
            isupdate=false;
          });
        }
      });
    } catch (e) {
      setState(() {
        print("error occured");
      });
    }
  }

  @override
  void initState() {
    getData(page: page.toString());
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
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
    return isLoading?Container(
      child: Container(
            height: MediaQuery.of(context).size.width*0.5,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),),
    ): Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Container(
            color: Helper.whiteColor,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: TextButton_Drawer(
                        width: 123,
                        textname: "エリア選択",
                        onpress: () {
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
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return isLoading ?Container(): NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==scrollInfo.metrics.maxScrollExtent) {
                    if(!isupdate){
                      getData(page: (page+1).toString());
                      setState(() {
                        isupdate=true;
                        page+=1;
                      }); 
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: clinic_data.data.length,
                    controller: scrollController,
                    physics: widget.isScrollable!
                        ? AlwaysScrollableScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Clinic_Card(
                          onpress: () {
                            // print("object");
                            Navigator.of(context).pushNamed("/Clinic_Detail");
                          },
                          image: clinic_data.data[index]["photo"] == null
                              ? ""
                              : clinic_data.data[index]["photo"],
                          post:"",
                          name: clinic_data.data[index]["name"] == null
                              ? ""
                              : clinic_data.data[index]["name"],
                          mark: clinic_data.data[index]["diaries_count"] == null
                              ? ""
                              : clinic_data.data[index]["diaries_count"].toString(),
                          day: clinic_data.data[index]["diaries_count"] == null
                              ? ""
                              : clinic_data.data[index]["diaries_count"].toString(),
                          location: (clinic_data.data[index]["addr01"] == null
                                  ? ""
                                  : clinic_data.data[index]["addr01"]) +" "+
                              (clinic_data.data[index]["addr02"] == null
                                  ? ""
                                  : clinic_data.data[index]["addr02"]));
                    }),
              );
            }),
          ),
        ],
      ),
    );
  }
}

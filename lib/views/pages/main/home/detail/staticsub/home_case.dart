import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/case_model.dart';
import 'package:laxia/views/pages/main/contribution/case_detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Case extends StatefulWidget {
  final List<Case_Sub_Model> cases;
  const Home_Case({Key? key, required this.cases})
      : super(key: key);

  @override
  State<Home_Case> createState() => _Home_CaseState();
}

class _Home_CaseState extends State<Home_Case> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return Column(
                children: [
                  // menuAppBar(context),
                  Expanded(
                    child: LayoutBuilder(
                        builder: (context, BoxConstraints viewportConstraints) {
                      return
                      ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: widget.cases.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Diary_Card(
                              onpress: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CaseDetail(index:  widget.cases[index].id)));
                                // Navigator.of(context).pushNamed("/CaseDetail");
                              },
                              buttoncolor: Helper.btnBgMainColor,
                              buttontext: "症例",
                              avator:
                                  widget.cases[index].clinic!.photo == null
                                      ? "http://error.png"
                                      : widget.cases[index].clinic!.photo!,
                              check: widget.cases[index].doctor == null
                                  ? ""
                                  : widget.cases[index].doctor!.name!,
                              image2:widget.cases[index].beforeimage!.isEmpty?"http://error.png":
                                  widget.cases[index].beforeimage![0].path,
                              image1:widget.cases[index].afterimage!.isEmpty?"http://error.png":
                                  widget.cases[index].afterimage![0].path,
                              eyes: widget.cases[index].views_count == null
                                  ? ""
                                  : widget.cases[index].views_count
                                      .toString(),
                              name: widget.cases[index].clinic!.name == null
                                  ? ""
                                  : widget.cases[index].clinic!.name!,
                              price:widget.cases[index].menus!.isEmpty?"":(widget.cases[index].menus![0].price==null?"": widget.cases[index].menus![0].price!.toString()),
                              sentence: widget.cases[index].treat_risk == null
                                  ? ""
                                  : widget.cases[index].treat_risk!,
                              type:
                                  widget.cases[index].case_description == null
                                      ? ""
                                      : widget.cases[index].case_description!,
                            );
                          });
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

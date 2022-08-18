import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/case/case_sub_model.dart';
import 'package:laxia/models/case_model.dart';
import 'package:laxia/views/pages/main/contribution/case_detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Favorite_Case extends StatefulWidget {
  const Favorite_Case({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorite_Case> createState() => _Favorite_CaseState();
}

class _Favorite_CaseState extends State<Favorite_Case> {
  bool expanded = true;
  int index = -1;
  bool isloading = true;
  List<Case_Sub_Model> mid = [];
  @override
  
  void initState() {
    isloading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: isloading
                        ? Container(
                            child: Container(
                            height: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Center(
                              child: new CircularProgressIndicator(),
                            ),
                          ))
                        : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                itemCount: mid.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container();
                }),
          )),
        ],
      ),
    );
  }
}

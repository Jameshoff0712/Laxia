import 'package:flutter/material.dart';
import 'dart:async';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/static_controller.dart';
import 'package:laxia/models/static/areas_model.dart';
import 'package:laxia/views/widgets/multiselect_preference.dart';

class SelectPrefecture extends StatefulWidget {
  const SelectPrefecture({Key? key}) : super(key: key);

  @override
  State<SelectPrefecture> createState() => _SelectPrefectureState();
}

class _SelectPrefectureState extends State<SelectPrefecture> {
   final _con = StaticController();
  bool isloading = true;
  late List<Area_Model> areas;
  Future<void> getData() async {
    try {
      areas = await _con.getAreas();
      setState(() {
        isloading = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
      });
    }
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ))
        : Scaffold(
            backgroundColor: Helper.whiteColor,
            body: Column(
              children: [
                MultiSelectDart(
                  areas: areas,
                 width: 110, buttontxt: '結果を表示', title: 'エリア選択',
                ),
              ],
            ));
  }
}

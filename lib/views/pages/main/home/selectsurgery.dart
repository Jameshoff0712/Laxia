import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'dart:convert';
import 'package:laxia/views/widgets/multiselect.dart';

class SelectSurgery extends StatefulWidget {
  const SelectSurgery({Key? key}) : super(key: key);

  @override
  State<SelectSurgery> createState() => _SelectSurgeryState();
}

class _SelectSurgeryState extends State<SelectSurgery> {
  List countys = [];
  Future<void> initSettings() async {
    String countyText =
        await rootBundle.loadString("assets/cfg/treatment_location.json");
    setState(() {
      countys.addAll(json.decode(countyText));
    });
  }

  @override
  void initState() {
    initSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
        body: Column(
      children: [
        MultiSelectDart(
          menu_list: countys,
          width: 110,
         buttontxt: '結果を表示', title: 'エリア選択',
        ),
        
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'dart:convert';
import 'package:laxia/views/widgets/multiselect.dart';

class SelectPrefecture extends StatefulWidget {
  const SelectPrefecture({Key? key}) : super(key: key);

  @override
  State<SelectPrefecture> createState() => _SelectPrefectureState();
}

class _SelectPrefectureState extends State<SelectPrefecture> {
  List countys = [];
  Future<void> initSettings() async {
    String countyText =
        await rootBundle.loadString("assets/cfg/japanese-city-data.json");
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
          treatments:[],
          width: 110, buttontxt: '結果を表示', title: 'エリア選択',
        ),
      ],
    ));
  }
}

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
  int _selectedIndex = 0;
  List countys = [];
  Future<void> initSettings() async {
    String countyText =
        await rootBundle.loadString("assets/cfg/japanese-city-data.json");
    setState(() {
      countys = json.decode(countyText);
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
        body: Column(
      children: [
        SizedBox(
          height: 56,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 15,
                  )),
              Text("エリア選択",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              InkWell(
                onTap: (){},
                child: Text("クリア",
                    style: TextStyle(
                        color: Helper.unClickClearButtonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              )
            ],
          ),
        ),
        MultiSelectDart(
          menu_list: countys,
          width: 110,
        ),
        InkWell(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Helper.btnBgMainColor),
            width: 300,
            height: 45,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 114, vertical: 12),
              child: Text("結果を表示",style: TextStyle(color: Helper.whiteColor,fontSize: 12,fontWeight: FontWeight.w700),),
            ),
          ),
        ),
        SizedBox(height: 33,)
      ],
    ));
  }
}

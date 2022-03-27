import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:laxia/views/widgets/multiselect.dart';

class SelectSurgery extends StatefulWidget {
  const SelectSurgery({Key? key}) : super(key: key);

  @override
  State<SelectSurgery> createState() => _SelectSurgeryState();
}

class _SelectSurgeryState extends State<SelectSurgery> {
  int _selectedIndex = 0;
  List countys = [];
  Future<void> initSettings() async {
    String countyText =
        await rootBundle.loadString("assets/cfg/treatment_location.json");
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
                        color: Color.fromARGB(255, 102, 110, 110),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255,110, 198, 210)),
            width: 300,
            height: 45,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 114, vertical: 12),
              child: Text("結果を表示",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w700),),
            ),
          ),
        ),
        SizedBox(height: 33,)
      ],
    ));
  }
}
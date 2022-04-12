import 'dart:convert';
import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_datetime_picker_forked/flutter_datetime_picker_forked.dart';
import 'package:laxia/views/pages/main/mypage/selectbox_widget.dart';
class Signup_Two extends StatefulWidget {
  const Signup_Two({ Key? key }) : super(key: key);

  @override
  State<Signup_Two> createState() => _Signup_TwoState();
}

class _Signup_TwoState extends State<Signup_Two> {
  bool isDisable=true;
  DateTime _selectedDate = DateTime.now();
  List items=[];
  TextEditingController controller = TextEditingController(); 
   Future<void> initSettings() async {
    String countyText =
        await rootBundle.loadString("assets/cfg/japanese-city-data.json");
    setState(() {
      items.addAll(json.decode(countyText));
    });
  }
  String ? selectedValue;
  @override
  void initState(){
    initSettings();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty? SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Helper.whiteColor,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.only(left: 7),
            icon: const Icon(Icons.clear, color: Helper.titleColor),
            iconSize: 16,
          ),
          centerTitle: true,
          title: Text(
            "プロフィールの作成",
            style: TextStyle(
                color: Helper.titleColor, fontWeight: FontWeight.bold,fontSize: 20),
          ),
          shadowColor: Helper.whiteColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "ユーザーID",
                      style: TextStyle(
                          color: Helper.mainColor, fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    maxLength:40,
                    keyboardType: TextInputType.name,
                    validator: (input) {
                      // if (input!.contains(new RegExp(r'^[0-9]+$'))) {
                      //   if (input.length < 10) {
                      //     return null;
                      //   }
                      //   return null;
                      // }
                      // if (!input.contains(RegExp(
                      //     r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
                      //   return null;
                      // }
                      // return null;
                    },
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      hintText: "半角英数字のみ",
                      hintStyle: TextStyle(
                          color: Helper.maintxtColor, fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Helper.maintxtColor)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "ニックネーム",
                      style: TextStyle(
                          color: Helper.mainColor, fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    maxLength:40,
                    keyboardType: TextInputType.name,
                    validator: (input) {
                      // if (input!.contains(new RegExp(r'^[0-9]+$'))) {
                      //   if (input.length < 10) {
                      //     return null;
                      //   }
                      //   return null;
                      // }
                      // if (!input.contains(RegExp(
                      //     r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
                      //   return null;
                      // }
                      // return null;
                    },
                    onChanged:(value){
                      setState(() {
                        isDisable=false;
                      });
                    },
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      hintText: "ひらがな、絵文字なんでも利用できます",
                      hintStyle: TextStyle(
                          color: Helper.maintxtColor, fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Helper.maintxtColor)
                      ),
                    ),
                  ),
                   Text(
                    "ニックネームはプロフィールに表示されます。好きなお名前を自由におつけください。",
                    style: TextStyle(
                        color: Helper.maintxtColor, fontWeight: FontWeight.w400,fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "生年月日",
                      style: TextStyle(
                          color: Helper.mainColor, fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                          color: Helper.maintxtColor, fontSize: 14),
                    keyboardType: TextInputType.datetime,
                    onTap: ()  {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3, 5),
                              maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                          }, onConfirm: (date) {
                            controller.text=date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString(); 
                          }, currentTime: DateTime.now(), locale: LocaleType.jp);
    
                    },
                    validator: (input) {
                      // if (input!.contains(new RegExp(r'^[0-9]+$'))) {
                      //   if (input.length < 10) {
                      //     return null;
                      //   }
                      //   return null;
                      // }
                      // if (!input.contains(RegExp(
                      //     r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
                      //   return null;
                      // }
                      // return null;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "2020/12/12",
                      hintStyle: TextStyle(
                          color: Helper.maintxtColor, fontSize: 14),
                      
                      contentPadding:
                          EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Helper.maintxtColor)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "性別",
                        style: TextStyle(
                          color: Helper.mainColor, fontWeight: FontWeight.bold,fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Helper.unSelectSmallTabColor,
                          ),
                          items: ["女性", "男性"]
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        height: 1.5,
                                        color: Color.fromARGB(255, 18, 18, 18),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                            });
                          }),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "自己紹介",
                      style: TextStyle(
                          color: Helper.mainColor, fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (input) {
                      // if (input!.contains(new RegExp(r'^[0-9]+$'))) {
                      //   if (input.length < 10) {
                      //     return null;
                      //   }
                      //   return null;
                      // }
                      // if (!input.contains(RegExp(
                      //     r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'))) {
                      //   return null;
                      // }
                      // return null;
                    },
                    controller: TextEditingController(),
                    maxLines: 2,
                    maxLength: 200,
                    decoration: InputDecoration(
                      hintText: "自由にプロィールを書いてみましょう。(最大200文字)",
                      hintStyle: TextStyle(
                          color: Helper.maintxtColor, fontSize: 14),
                      contentPadding:
                          EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Helper.maintxtColor)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "施術を考えているエリア",
                      style: TextStyle(
                          color: Helper.mainColor, fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                  DropdownButton2(
                    hint: Text(
                      "あなたが住んでいる都道府県を選びましょう",
                      style: TextStyle(
                        fontSize: 12,
                        color: Helper.unSelectSmallTabColor,
                      ),
                    ),
                    value: selectedValue,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Helper.unSelectSmallTabColor,
                    ),
                    isExpanded: true,
                    underline: Container(),
                    offset: const Offset(-10, -10),
                    items: items
                        .map((item) => DropdownMenuItem(
                            value: item["label"],
                            child: Text(
                              item["label"],
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 51, 51, 51),
                              ),
                              overflow: TextOverflow.ellipsis,
                            )))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    }
                  ),
                  Text(
                    "住んでいるエリアはプロフィールには表示されません。エリアを選択することであなたにぴったりのクリニックが簡単に見つかります。",
                    style: TextStyle(
                        color: Helper.maintxtColor, fontWeight: FontWeight.w400,fontSize: 12),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "気になっている施術・部位",
                        style: TextStyle(
                          color: Helper.mainColor, fontWeight: FontWeight.bold,fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Helper.unSelectSmallTabColor,
                          ),
                          items: [
                                  '二重',
                                  '美容皮膚',
                                  'ボディ',
                                  '輪郭',
                                  'しわ・たるみ',
                                ]
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        height: 1.5,
                                        color: Color.fromARGB(255, 18, 18, 18),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                            });
                          }),
                    ],
                  ),
                  SizedBox(height:50),
                  Padding(
                    padding: const EdgeInsets.only(top: 17, left: 61, right: 61),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:isDisable?Helper.whiteColor: Helper.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14, bottom: 14),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "次へ進む",
                                style: TextStyle(color:isDisable?Helper.txtColor: Helper.whiteColor, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(height:50),
                ],
              ),
            )
          ),
        ),
      ),
    ):Scaffold();
  }
}
import 'dart:convert';
import 'dart:async';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_datetime_picker_forked/flutter_datetime_picker_forked.dart';
import 'package:laxia/views/pages/auth/_input_text_widget.dart';
import 'package:laxia/views/pages/auth/_selectbox_widget.dart';
import 'package:laxia/views/pages/main/mypage/selectbox_widget.dart';

class Signup_Two extends StatefulWidget {
  const Signup_Two({Key? key}) : super(key: key);

  @override
  State<Signup_Two> createState() => _Signup_TwoState();
}

class _Signup_TwoState extends State<Signup_Two> {
  bool isDisable = true;
  DateTime _selectedDate = DateTime.now();
  List items = [];
  List<String> cities = [];
  TextEditingController controller = TextEditingController();
  TextEditingController _conDate = TextEditingController();
  TextEditingController _conPrefecture = TextEditingController();
  Future<void> initSettings() async {
    String countyText =
        await rootBundle.loadString("assets/cfg/japanese-city-data.json");
    setState(() {
      items.addAll(json.decode(countyText));
      for (int i = 0; i < items.length; i++) {
        cities.add(items[i]["label"]);
      }
    });
  }

  String? selectedValue;
  @override
  void initState() {
    initSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Helper.whiteColor,
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.only(left: 7),
                icon: const Icon(Icons.clear, color: Helper.titleColor),
                iconSize: 25,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              centerTitle: true,
              title: Text(
                "プロフィールの作成",
                style: TextStyle(
                    color: Helper.titleColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.5),
              ),
              shadowColor: Helper.whiteColor,
            ),
            body: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        inputTextWidget(
                            labelName: "ユーザーID",
                            placeHolder: "半角英数字のみ",
                            maxLegnth: "40"),
                        inputTextWidget(
                            labelName: "ニックネーム",
                            placeHolder: "ひらがな、絵文字なんでも利用できます",
                            maxLegnth: "40"),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "ニックネームはプロフィールに表示されます。好きなお名前を自由におつけください。",
                          style: TextStyle(
                              color: Helper.titleColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 24, bottom: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "生年月日",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Helper.mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 18, 18, 18)),
                              keyboardType: TextInputType.datetime,
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2018, 3, 5),
                                    maxTime: DateTime(2200, 6, 7),
                                    onChanged: (date) {}, onConfirm: (date) {
                                  _conDate.text = date.year.toString() +
                                      "/" +
                                      date.month.toString() +
                                      "/" +
                                      date.day.toString();
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.jp);
                              },
                              controller: _conDate,
                              validator: (v) {
                                if (v!.isEmpty) return '日付を入力してください';
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 16),
                                hintText: "2020/12/12",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Helper.txtColor),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 240, 242, 245),
                                        width: 2.0)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 240, 242, 245),
                                        width: 2.0)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "プロフィールには生年月日は表示年代のみ表示されます。",
                          style: TextStyle(
                              color: Helper.titleColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5),
                        ),
                        selectBoxWidget(
                          name: "性別",
                          items: ["女性", "男性"],
                          chosenValue: "女性",
                        ),
                        inputTextWidget(
                            labelName: "自己紹介",
                            placeHolder: "自由にプロィールを書いてみましょう。(最大140文字)",
                            maxLegnth: "140"),
                        Container(
                          padding: EdgeInsets.only(top: 24, bottom: 12),
                          child: Text(
                            "施術を考えているエリア",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Helper.mainColor,
                            ),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color.fromARGB(255, 18, 18, 18)),
                          keyboardType: TextInputType.datetime,
                          onTap: () {
                            BottomPicker(
                              items: cities.map((val) => Text(val, textAlign: TextAlign.justify)).toList(),
                              title: 'Choose your country',
                              titleStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Helper.titleColor),
                              pickerTextStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Helper.titleColor),
                              dismissable: true,
                              backgroundColor: Colors.white,
                              bottomPickerTheme: BottomPickerTheme.morningSalad,
                              onSubmit: (index) {
                                setState(() {
                                  _conPrefecture.text = cities[index];
                                });
                              },
                              buttonAlignement: MainAxisAlignment.center,
                              displayButtonIcon: true,
                              displaySubmitButton: true,
                              buttonSingleColor: Helper.mainColor,
                              itemExtent: 50,
                              height: 300,
                            ).show(context);
                          },
                          controller: _conPrefecture,
                          validator: (v) {
                            if (v!.isEmpty) return '日付を入力してください';
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 16),
                            hintText: "あなたが住んでいる都道府県を選びましょう",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Helper.txtColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 240, 242, 245),
                                    width: 2.0)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 240, 242, 245),
                                    width: 2.0)),
                          ),
                        ),
                        // DropdownButtonFormField<String>(
                        //     hint: Text(
                        //       "あなたが住んでいる都道府県を選びましょう",
                        //       style: TextStyle(
                        //           fontSize: 14,

                        //           fontWeight: FontWeight.w400,
                        //           color: Color.fromARGB(255, 169, 169, 169)),
                        //     ),
                        //     value: selectedValue,
                        //     items: cities
                        //         .map((item) => DropdownMenuItem<String>(
                        //               value: item,
                        //               child: Text(
                        //                 item,
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.w400,
                        //                   fontSize: 14,

                        //                   color: Color.fromARGB(255, 18, 18, 18),
                        //                 ),
                        //               ),
                        //             ))
                        //         .toList(),
                        //     onChanged: (String? value) {
                        //       setState(() {
                        //         selectedValue = value!;
                        //       });
                        //     },
                        //     validator: (v) {
                        //       if (v!.isEmpty) return '選んでください';
                        //       return null;
                        //     },
                        //     icon: Icon(
                        //       Icons.keyboard_arrow_down,
                        //       color: Helper.titleColor,
                        //       size: 35,
                        //     )),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 24, bottom: 12),
                        //   child: Text(
                        //     "施術を考えているエリア",
                        //     style: TextStyle(
                        //         color: Helper.mainColor,
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 16),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 16),
                        //   child: DropdownButton2(
                        //       hint: Text(
                        //         "あなたが住んでいる都道府県を選びましょう",
                        //         style: TextStyle(
                        //           fontSize: 14,
                        //
                        //           fontWeight: FontWeight.w400,
                        //           color: Helper.unSelectSmallTabColor,
                        //         ),
                        //       ),
                        //       value: selectedValue,
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //
                        //         fontWeight: FontWeight.w400,
                        //         color: Helper.titleColor,
                        //       ),
                        //       icon: Icon(
                        //         Icons.keyboard_arrow_down,
                        //         color: Helper.unSelectSmallTabColor,
                        //       ),
                        //       isExpanded: true,
                        //       underline: Container(),
                        //       offset: const Offset(-10, -10),
                        //       items: items
                        //           .map((item) => DropdownMenuItem(
                        //               value: item["label"],
                        //               child: Text(
                        //                 item["label"],
                        //                 style: const TextStyle(
                        //                   fontSize: 16,
                        //
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Color.fromARGB(255, 51, 51, 51),
                        //                 ),
                        //                 overflow: TextOverflow.ellipsis,
                        //               )))
                        //           .toList(),
                        //       onChanged: (value) {
                        //         setState(() {
                        //           selectedValue = value as String;
                        //         });
                        //       }),
                        // ),
                        // Container(
                        //   height: 1,
                        //   color: Color.fromARGB(255, 200, 199, 204),
                        // ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "住んでいるエリアはプロフィールには表示されません。エリアを選択することであなたにぴったりのクリニックが簡単に見つかります。",
                          style: TextStyle(
                              color: Helper.titleColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5),
                        ),
                        selectBoxWidget(
                          name: "気になっている施術・部位",
                          items: [
                            '二重',
                            '美容皮膚',
                            'ボディ',
                            '輪郭',
                            'しわ・たるみ',
                          ],
                          chosenValue: "二重",
                        ),

                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 74, right: 74),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: isDisable
                                  ? Helper.whiteColor
                                  : Helper.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: const BorderSide(
                                    color: Helper.txtColor,
                                    width: 1,
                                    style: BorderStyle.solid),
                              ),
                              splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "ラシアの利用を始める",
                                      style: TextStyle(
                                          color: isDisable
                                              ? Helper.txtColor
                                              : Helper.whiteColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
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
                        SizedBox(height: 50),
                      ],
                    ),
                  )),
            ),
          )
        : Scaffold();
  }
}

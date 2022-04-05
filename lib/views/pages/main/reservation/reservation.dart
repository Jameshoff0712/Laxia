import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/reservation/confirmation.dart';
import 'package:laxia/views/widgets/calendar.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  String? selectedValue; //for dropdown
  bool checkBoxValue = false;
  List<String> items = [
    '希望ドクターはなし',
    '希望ドクタ',
    '希望ド',
  ];
  double progress = 1;
  int sexId = -1;
  List<bool> selectedTime = List<bool>.filled(4, false);
  List<bool> statusReservation = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            '来院のご予約',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              height: 1.5,
              color: Helper.titleColor,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: Container(
                        height: 180,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'ご予約を途中で終了しますか？',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'まだご予約が完了しておりません。\n戻ると入力内容が消えてしまいます。',
                                style: TextStyle(
                                  fontFamily: 'Hiragino Kaku Gothic Pro',
                                  fontSize: 14,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // color: Color.fromARGB(
                                        //     255, 0, 184, 169),
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      child: Text(
                                        'いいえ',
                                        style: TextStyle(
                                          fontFamily:
                                              'Hiragino Kaku Gothic Pro',
                                          fontSize: 16,
                                          height: 1.5,
                                          fontWeight: FontWeight.w400,
                                          // color: Colors.white,
                                          color:
                                              Color.fromARGB(255, 0, 184, 169),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onHover: (value) {
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 184, 169),
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      child: Text(
                                        'はい',
                                        style: TextStyle(
                                          fontFamily:
                                              'Hiragino Kaku Gothic Pro',
                                          fontSize: 16,
                                          height: 1.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              icon: Icon(
                Icons.close,
                color: Helper.titleColor,
                size: 30,
              )),
          SizedBox(
            width: 18,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Container(
            height: 25,
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
            child: LinearProgressIndicator(
              backgroundColor: Color.fromARGB(255, 196, 196, 196),
              color: Color.fromARGB(255, 0, 184, 169),
              value: progress,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 25,
            //   padding: EdgeInsets.symmetric(vertical: 11, horizontal: 18),
            //   child: LinearProgressIndicator(
            //     backgroundColor: Color.fromARGB(255, 196, 196, 196),
            //     color: Color.fromARGB(255, 0, 184, 169),
            //     value: progress,
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ご予約クリニック',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      Text('湘南美容クリニック 新宿院',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                    ],
                  )),
                  SizedBox(
                    height: 34,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ご予約の施術',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      Text('クイックコスメティーク･ダブルNeo',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                    ],
                  )),
                  SizedBox(
                    height: 34,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ご希望のドクター',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      _buildDropDownButton(items)
                    ],
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ご希望の施術やご相談したいことは？',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          errorStyle: TextStyle(color: Colors.red),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Helper.whiteColor.withOpacity(0.2))),
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 210, 210, 212),
                              fontSize: 14,
                              height: 1.8,
                              fontWeight: FontWeight.w400),
                          hintText:
                              '例1)二重埋没\n例2)ニキビ跡や肌荒れで悩んでいます。どういった施術が適していますでしょうか？',
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 184, 169),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 184, 169),
                              )),
                        ),
                        maxLines: 4,
                        style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 14,
                            height: 1.8,
                            fontWeight: FontWeight.w400),
                        validator: (v) {
                          if (v!.isEmpty) return 'input please';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        children: [
                          Text(
                            '施術一覧から選択する',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 184, 169),
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromARGB(255, 0, 184, 169),
                          ),
                        ],
                      )
                    ],
                  )),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('当日は施術を希望しますか？',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      _buildDropDownButton(items)
                    ],
                  )),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ご来院希望日の選択',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 21,
                      ),
                      Calendar(),
                    ],
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('来院時間帯を選択',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 14,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildTimeButton(0, '12:30'),
                              _buildTimeButton(1, '13:00'),
                              _buildTimeButton(2, '13:30'),
                              _buildTimeButton(3, '14:00'),
                            ],
                          )),
                    ],
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('選択した候補日',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          statusReservation.add(true);
                          return _buildReservationItem(index);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                        itemCount: 3,
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242, 242, 242),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('お名前(カタカナフルネーム)',
                              style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                decoration: TextDecoration.none,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 14,
                                        bottom: 8,
                                        left: 10,
                                        right: 10),
                                    errorStyle: TextStyle(color: Colors.red),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Helper.whiteColor
                                                .withOpacity(0.2))),
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 210, 210, 212),
                                        fontSize: 16,
                                        height: 1.5,
                                        fontWeight: FontWeight.w400),
                                    hintText: 'セイ',
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 0, 184, 169),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 0, 184, 169),
                                        )),
                                  ),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 16,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400),
                                  validator: (v) {
                                    if (v!.isEmpty) return 'input please';
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        top: 14,
                                        bottom: 8,
                                        left: 10,
                                        right: 10),
                                    errorStyle: TextStyle(color: Colors.red),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Helper.whiteColor
                                                .withOpacity(0.2))),
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 210, 210, 212),
                                        fontSize: 16,
                                        height: 1.5,
                                        fontWeight: FontWeight.w400),
                                    hintText: 'メイ',
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 0, 184, 169),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 0, 184, 169),
                                        )),
                                  ),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 16,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400),
                                  validator: (v) {
                                    if (v!.isEmpty) return 'input please';
                                    return null;
                                  },
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('生年月日',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      _buildDropDownButton(items)
                    ],
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('性別',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  sexId = 0;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 46,
                                padding: EdgeInsets.only(top: 14, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 0, 184, 169)),
                                  color: sexId == 0
                                      ? Color.fromARGB(255, 240, 253, 255)
                                      : Colors.white,
                                ),
                                child: Text('女性',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                      decoration: TextDecoration.none,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  sexId = 1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 46,
                                padding: EdgeInsets.only(top: 14, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 0, 184, 169)),
                                  color: sexId == 1
                                      ? Color.fromARGB(255, 240, 253, 255)
                                      : Colors.white,
                                ),
                                child: Text('男性',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 51, 51, 51),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                      decoration: TextDecoration.none,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ご連絡先の携帯番号',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 14, bottom: 8, left: 10, right: 10),
                          errorStyle: TextStyle(color: Colors.red),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Helper.whiteColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 184, 169),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 184, 169),
                              )),
                        ),
                        style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.w400),
                        validator: (v) {
                          if (v!.isEmpty) return 'input please';
                          return null;
                        },
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ご利用ポイント',
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 51, 51),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                      SizedBox(
                        height: 6,
                      ),
                      RichText(
                        text: TextSpan(
                            text: '保有ポイント：',
                            style: TextStyle(
                              color: Color.fromARGB(255, 51, 51, 51),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              decoration: TextDecoration.none,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: '2400',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 184, 169),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    height: 1.5,
                                    decoration: TextDecoration.none,
                                  ),
                                  children: const <TextSpan>[]),
                            ]),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 14, bottom: 8, left: 10, right: 10),
                                errorStyle: TextStyle(color: Colors.red),
                                errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Helper.whiteColor
                                            .withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 184, 169),
                                    )),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 184, 169),
                                    )),
                              ),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontSize: 16,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400),
                              validator: (v) {
                                if (v!.isEmpty) return 'input please';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('ポイント',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                                decoration: TextDecoration.none,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('1ポイント1円として利用できます',
                            style: TextStyle(
                              color: Color.fromARGB(255, 156, 161, 161),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            child: Checkbox(
                              value: this.checkBoxValue,
                              onChanged: (value) {
                                setState(() {
                                  this.checkBoxValue = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text('全てのポイントを利用する',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 51, 51, 51),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                  height: 1.5)),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: progress == 1
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Confirmation()),
                            );
                          }
                        : null,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 58,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: progress != 1
                            ? Color.fromARGB(255, 210, 210, 212)
                            : Color.fromARGB(255, 0, 184, 169),
                      ),
                      child: Text('ご予約の確認画面へ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReservationItem(int index) {
    return !statusReservation[index]
        ? Container()
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: EdgeInsets.only(top: 16, left: 9, bottom: 10, right: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color.fromARGB(255, 102, 110, 110)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('希望日1',
                    style: TextStyle(
                      color: Color.fromARGB(255, 102, 110, 110),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      decoration: TextDecoration.none,
                    )),
                Text('2021年5月24日(木) 11:30',
                    style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      decoration: TextDecoration.none,
                    )),
                InkWell(
                  onTap: () {
                    setState(() {
                      statusReservation[index] = false;
                    });
                  },
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 102, 110, 110),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget _buildTimeButton(int index, String time) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTime = List<bool>.filled(4, false);
          selectedTime[index] = true;
        });
      },
      child: Container(
        width: 100,
        height: 34,
        padding: EdgeInsets.only(top: 8, left: 28, right: 28, bottom: 2),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Color.fromARGB(255, 210, 210, 212)),
          color: selectedTime[index]
              ? Color.fromARGB(255, 240, 253, 255)
              : Colors.white,
        ),
        child: Text(time,
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              decoration: TextDecoration.none,
            )),
      ),
    );
  }

  Widget _buildDropDownButton(List<String> items) {
    return Container(
      height: 46,
      padding: EdgeInsets.only(top: 14, left: 10, bottom: 8, right: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color.fromARGB(255, 0, 184, 169),
        ),
      ),
      child: DropdownButton2(
          value: selectedValue,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromARGB(255, 0, 184, 169),
          ),
          isExpanded: true,
          underline: Container(),
          offset: const Offset(-10, -10),
          items: items
              .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
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
              selectedValue = value as String?;
            });
          }),
    );
  }
}

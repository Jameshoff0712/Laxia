import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/reservation/confirmation.dart';
import 'package:laxia/views/widgets/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  double progress = 0.1;
  final _formKey = GlobalKey<FormState>();
  String? doctorValue;
  bool selectedDoctor = false;
  List<String> doctors = [
    'eva',
    'com',
    'key',
  ];
  String? wantedValue;
  bool? isWantedValue;
  String? todayValue;
  bool selectedToday = false;
  List<String> options_Today = [
    'カウンセリングのみ',
    '施術',
    'カウンセリング・施術',
  ];
  late CalendarController _controller;
  List<bool> selectedTime = List<bool>.filled(4, false);
  List<String> list_ReservedTime = [];
  List<Map> list_ReservedRealTime = [];
  List<String> stringWeekDay = ['月', '火', '水', '木', '金', '土', '日'];
  late int year, month, day, index_weekday;
  late String weekday;
  bool? isReservedTime;
  String? firstName;
  bool? isFirstName;
  String? secondName;
  bool? isSecondName;
  final _birthController = TextEditingController();
  bool isBirth = false;
  int? birthYear;
  int? birthMonth;
  int? birthDay;
  int sexId = -1;
  bool selectedSex = false;
  String? mobile;
  bool? isMobile;
  String? usedPoints;
  bool? isUsedPoints;
  bool checkBoxValue = false;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

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
                                color: Helper.titleColor,
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      child: Text(
                                        'いいえ',
                                        style: TextStyle(
                                          fontFamily:
                                              'Hiragino Kaku Gothic Pro',
                                          fontSize: 16,
                                          
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromARGB(255, 0, 184, 169),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
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
          preferredSize: Size.fromHeight(15),
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
        child: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                
                                decoration: TextDecoration.none,
                              )),
                        ],
                      )),
                      SizedBox(
                        height: 34,
                      ),
                      // wanted doctor list
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ご希望のドクター',
                              style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                
                                decoration: TextDecoration.none,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: 46,
                            padding: EdgeInsets.only(left: 10, right: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color.fromARGB(255, 0, 184, 169),
                              ),
                            ),
                            child: DropdownButton2(
                                value: doctorValue,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromARGB(255, 0, 184, 169),
                                  size: 40,
                                ),
                                isExpanded: true,
                                underline: Container(),
                                offset: const Offset(-10, 0),
                                items: doctors
                                    .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromARGB(255, 51, 51, 51),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    doctorValue = value as String?;
                                    if (!selectedDoctor) progress += 0.1;
                                    if (doctorValue != null)
                                      selectedDoctor = true;
                                  });
                                }),
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 40,
                      ),
                      // what do you want?
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ご希望の施術やご相談したいことは？',
                              style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                
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
                            onChanged: (value) {
                              setState(() {
                                wantedValue = value as String?;
                                if (value.isNotEmpty && isWantedValue != true)
                                  progress += 0.1;
                                if (value.isEmpty && isWantedValue == true)
                                  progress -= 0.1;
                                if (value.isNotEmpty)
                                  isWantedValue = true;
                                else
                                  isWantedValue = false;
                              });
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
                      // what's for today?
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('当日は施術を希望しますか？',
                              style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                
                                decoration: TextDecoration.none,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: 46,
                            padding: EdgeInsets.only(left: 10, right: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color.fromARGB(255, 0, 184, 169),
                              ),
                            ),
                            child: DropdownButton2(
                                value: todayValue,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color.fromARGB(255, 0, 184, 169),
                                  size: 40,
                                ),
                                isExpanded: true,
                                underline: Container(),
                                offset: const Offset(-10, 0),
                                items: options_Today
                                    .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Color.fromARGB(255, 51, 51, 51),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    todayValue = value as String?;
                                    if (!selectedToday) progress += 0.1;
                                    if (todayValue != null) selectedToday = true;
                                  });
                                }),
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
                                
                                decoration: TextDecoration.none,
                              )),
                          SizedBox(
                            height: 21,
                          ),
                          TableCalendar(
                            initialCalendarFormat: CalendarFormat.month,
                            calendarStyle: CalendarStyle(
                                weekendStyle: TextStyle(),
                                unavailableStyle: const TextStyle(
                                    color: Color.fromARGB(255, 210, 210, 212)),
                                outsideDaysVisible: false,
                                todayColor: Colors
                                    .white, //Color.fromARGB(255, 0, 184, 169),
                                selectedColor: Color.fromARGB(255, 0, 184, 169),
                                todayStyle: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    // fontSize: 22.0,
                                    color: Colors.black)
                            ),
                            headerStyle: HeaderStyle(
                                centerHeaderTitle: true,
                                formatButtonVisible: false,
                                titleTextStyle: TextStyle(
                                  fontSize: 14,
                                  
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 51, 51, 51),
                                )),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekendStyle:
                                  TextStyle(color: const Color(0xFF616161)),
                            ),
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            onDaySelected: (date, events, e) {
                              print(date.toUtc());
                              setState(() {
                                selectedTime = List<bool>.filled(4, false);
                                year = date.year;
                                month = date.month;
                                day = date.day;
                                index_weekday = date.weekday;
                                weekday = stringWeekDay[index_weekday - 1];
                              });
                            },
                            builders: CalendarBuilders(
                              selectedDayBuilder: (context, date, events) =>
                                  Container(
                                      margin: const EdgeInsets.all(5.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 0, 184, 169),
                                          borderRadius:
                                              BorderRadius.circular(80.0)),
                                      child: Text(
                                        date.day.toString(),
                                        style:
                                            TextStyle(color: Helper.whiteColor),
                                      )),
                              outsideWeekendDayBuilder: (context, date, events) =>
                                  Container(
                                      margin: const EdgeInsets.all(5.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        date.day.toString(),
                                        style: TextStyle(color: Colors.grey),
                                      )),
                            ),
                            calendarController: _controller,
                          )
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
                                
                                decoration: TextDecoration.none,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _buildReservationItem(index);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                            itemCount: list_ReservedTime.length,
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
                                            color: Color.fromARGB(
                                                255, 210, 210, 212),
                                            fontSize: 16,
                                            
                                            fontWeight: FontWeight.w400),
                                        hintText: 'セイ',
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 184, 169),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 184, 169),
                                            )),
                                      ),
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 51, 51, 51),
                                          fontSize: 16,
                                          
                                          fontWeight: FontWeight.w400),
                                      validator: (v) {
                                        if (v!.isEmpty) return 'input please';
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          firstName = value as String?;
                                          if (value.isNotEmpty &&
                                              isFirstName != true) {
                                            progress += 0.05;
                                            isFirstName = true;
                                          }
                                          if (value.isEmpty &&
                                              isFirstName == true) {
                                            progress -= 0.05;
                                            isFirstName = false;
                                          }
                                        });
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
                                            color: Color.fromARGB(
                                                255, 210, 210, 212),
                                            fontSize: 16,
                                            
                                            fontWeight: FontWeight.w400),
                                        hintText: 'メイ',
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 184, 169),
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 0, 184, 169),
                                            )),
                                      ),
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 51, 51, 51),
                                          fontSize: 16,
                                          
                                          fontWeight: FontWeight.w400),
                                      validator: (v) {
                                        if (v!.isEmpty) return 'input please';
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          secondName = value as String?;
                                          if (value.isNotEmpty &&
                                              isSecondName != true) {
                                            progress += 0.05;
                                            isSecondName = true;
                                          }
                                          if (value.isEmpty &&
                                              isSecondName == true) {
                                            progress -= 0.05;
                                            isSecondName = false;
                                          }
                                        });
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
                                
                                decoration: TextDecoration.none,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            controller: _birthController,
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
                                
                                fontWeight: FontWeight.w400),
                            validator: (v) {
                              if (v!.isEmpty) return 'input please';
                              return null;
                            },
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2400),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _birthController.text =
                                      '${pickedDate.year}年${pickedDate.month}月${pickedDate.day}日';
                                  birthYear = pickedDate.year;
                                  birthMonth = pickedDate.month;
                                  birthDay = pickedDate.day;
                                  if (!isBirth) progress += 0.1;
                                  isBirth = true;
                                });
                              }
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
                          Text('性別',
                              style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                
                                decoration: TextDecoration.none,
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sexId = 0;
                                      if (!selectedSex) {
                                        progress += 0.1;
                                        selectedSex = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 0, 184, 169)),
                                      color: sexId == 0
                                          ? Color.fromARGB(255, 240, 253, 255)
                                          : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text('女性',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 51, 51, 51),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            
                                            decoration: TextDecoration.none,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sexId = 1;
                                      if (!selectedSex) {
                                        progress += 0.1;
                                        selectedSex = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 0, 184, 169)),
                                      color: sexId == 1
                                          ? Color.fromARGB(255, 240, 253, 255)
                                          : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text('男性',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 51, 51, 51),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            
                                            decoration: TextDecoration.none,
                                          )),
                                    ),
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
                                
                                fontWeight: FontWeight.w400),
                            validator: (v) {
                              if (v!.isEmpty) return 'input please';
                              final regex = RegExp('^[0-9]+');
                              if (!regex.hasMatch(v))
                                return 'Enter a valid mobile number';
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                mobile = value;
                                if (value.isNotEmpty && isMobile != true) {
                                  progress += 0.1;
                                  isMobile = true;
                                }
                                if (value.isEmpty && isMobile == true) {
                                  progress -= 0.1;
                                  isMobile = false;
                                }
                              });
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
                                  fontWeight: FontWeight.w700,
                                  
                                  decoration: TextDecoration.none,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: '2400',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 184, 169),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        
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
                                      
                                      fontWeight: FontWeight.w400),
                                  validator: (v) {
                                    if (v!.isEmpty) return 'input please';
                                    final regex = RegExp('^[1-9]+[0-9]*');
                                    if (!regex.hasMatch(v))
                                      return 'Enter a valid point value';
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      usedPoints = value;
                                      if (value.isNotEmpty &&
                                          isUsedPoints != true) {
                                        progress += 0.1;
                                        isUsedPoints = true;
                                      }
                                      if (value.isEmpty && isUsedPoints == true) {
                                        progress -= 0.1;
                                        isUsedPoints = false;
                                      }
                                    });
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
                                    fontWeight: FontWeight.w400,
                                    
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
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity(horizontal: -4),
                                ),
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
                          // SizedBox(
                          //   height: 20,
                          // ),
                        ],
                      )),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: progress == 1 ? _validate : null,
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
        ),
      ),
    );
  }

  void _validate() {
    final form = _formKey.currentState;
    if (!form!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Confirmation(
                doctor: doctorValue!,
                wantedValue: wantedValue!,
                todayValue: todayValue!,
                list_ReservedTime: list_ReservedTime,
                list_ReservedRealTime: list_ReservedRealTime,
                firstName: firstName!,
                secondName: secondName!,
                birth: _birthController.text,
                birthYear: birthYear!,
                birthMonth: birthMonth!,
                birthDay: birthDay!,
                sexId: sexId,
                mobile: mobile!,
                usedPoints: int.parse(usedPoints!),
              )),
    );
  }

  Widget _buildReservationItem(int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: EdgeInsets.only(top: 13, left: 9, bottom: 13, right: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color.fromARGB(255, 102, 110, 110)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('希望日${index + 1}',
              style: TextStyle(
                color: Color.fromARGB(255, 102, 110, 110),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                
                decoration: TextDecoration.none,
              )),
          Text(list_ReservedTime[index],
              style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                
                decoration: TextDecoration.none,
              )),
          GestureDetector(
            onTap: () {
              setState(() {
                list_ReservedTime.removeAt(index);
                list_ReservedRealTime.removeAt(index);
                if (list_ReservedTime.length == 0 && isReservedTime == true) {
                  progress -= 0.1;
                  isReservedTime = false;
                }
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
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < 4; i++) {
            if (i == index)
              selectedTime[i] = !selectedTime[i];
            else
              selectedTime[i] = false;
          }
          if (selectedTime[index] == true && list_ReservedTime.length < 6) {
            list_ReservedTime.add('$year年$month月$day日($weekday) $time');
            var item = new Map();
            item['year'] = year;
            item['month'] = month;
            item['day'] = day;
            item['time'] = time;
            list_ReservedRealTime.add(item);
          }
          if (list_ReservedTime.length != 0 && isReservedTime != true) {
            progress += 0.1;
            isReservedTime = true;
          }
        });
        print(list_ReservedTime);
        print(list_ReservedRealTime);
      },
      child: Container(
        height: 34,
        padding: EdgeInsets.only(top: 5, left: 28, right: 28, bottom: 5),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: selectedTime[index] 
            ? Border.all(color: Helper.mainColor)
            : Border.all(color: Color.fromARGB(255, 210, 210, 212)),
          color: selectedTime[index]
              ? Color.fromARGB(255, 240, 253, 255)
              : Colors.white
        ),
        child: Text(time,
            style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              
              decoration: TextDecoration.none,
            )),
      ),
    );
  }

  // Widget _buildDropDownButton(List<String> items) {
  //   return Container(
  //     height: 46,
  //     padding: EdgeInsets.only(top: 14, left: 10, bottom: 8, right: 18),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(5),
  //       border: Border.all(
  //         color: Color.fromARGB(255, 0, 184, 169),
  //       ),
  //     ),
  //     child: DropdownButton2(
  //         value: selectedValue,
  //         icon: Icon(
  //           Icons.keyboard_arrow_down,
  //           color: Color.fromARGB(255, 0, 184, 169),
  //         ),
  //         isExpanded: true,
  //         underline: Container(),
  //         offset: const Offset(-10, -10),
  //         items: items
  //             .map((item) => DropdownMenuItem(
  //                 value: item,
  //                 child: Text(
  //                   item,
  //                   style: const TextStyle(
  //                     fontSize: 16,
  //                     
  //                     fontWeight: FontWeight.bold,
  //                     color: Color.fromARGB(255, 51, 51, 51),
  //                   ),
  //                   overflow: TextOverflow.ellipsis,
  //                 )))
  //             .toList(),
  //         onChanged: (value) {
  //           setState(() {
  //             selectedValue = value as String?;
  //           });
  //         }),
  //   );
  // }
}

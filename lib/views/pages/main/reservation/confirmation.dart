import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/reserve_controller.dart';
import 'package:laxia/models/reserve_post_model.dart';

class Confirmation extends StatefulWidget {
  final String doctor;
  final String wantedValue;
  final String todayValue;
  final List<String> list_ReservedTime;
  final List<Map> list_ReservedRealTime;
  final String firstName;
  final String secondName;
  final String birth;
  final int birthYear;
  final int birthMonth;
  final int birthDay;
  final int sexId;
  final String mobile;
  final int usedPoints;
  const Confirmation({
    Key? key,
    required this.doctor,
    required this.wantedValue,
    required this.todayValue,
    required this.list_ReservedTime,
    required this.list_ReservedRealTime,
    required this.firstName,
    required this.secondName,
    required this.birth,
    required this.birthYear,
    required this.birthMonth,
    required this.birthDay,
    required this.sexId,
    required this.mobile,
    required this.usedPoints,
  }) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final _con = ReserveController();
  String _errorMsg = "";
  late ReservePost rsv;
  @override
  initState() {
    rsv = new ReservePost(
      clinic_id: 1, //widget.clinic_id
      opertion_type: 0, //widget.operation_type
      doctor_id: 0, //widget.doctor_id
      question_content: widget.wantedValue,
      decision_type_today: 0, //widget.todayValue,
      list_visitDates: widget.list_ReservedRealTime,
      firstName: widget.firstName,
      secondName: widget.secondName,
      birthday: widget.birthYear.toString() + "/" + widget.birthMonth.toString() + "/" + widget.birthDay.toString(),
      gender_id: widget.sexId,
      mobileNumber: widget.mobile,
      usedPoint: widget.usedPoints);
    super.initState();
  }

  Future<void> confirm(BuildContext context) async {
    try {
      await _con.reserve(rsv);
      Navigator.of(context).pushNamed("/Completion");
      // Navigator.pushNamedAndRemoveUntil(context, "/Pages", (route) => false);
      // }
    } catch (e) {
      setState(() {
        _errorMsg = "メールアドレスもしくはパスワードが間違っています。";
      });
      print(_errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'ご予約内容の確認',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Helper.titleColor,
              size: 30,
            )),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 243, 243, 243)))),
            ),
          ),
          _buildConfirmRow('クリニック', '湘南美容クリニック 銀座院'),
          _buildConfirmRow('施術', 'クイックコスメティーク･ダブルNeo'),
          _buildConfirmRow('ご希望のドクター', widget.doctor),
          _buildConfirmRow('ご相談・ご要望', widget.wantedValue),
          _buildConfirmRow('当日施術', widget.todayValue),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: Color.fromARGB(255, 243, 243, 243)))),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 15, left: 15, bottom: 15, right: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 243, 243, 243),
                      ),
                      child: Text(
                        '来院希望日',
                        style: TextStyle(
                            color: Color.fromARGB(255, 18, 18, 18),
                            fontSize: 12,
                            
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < widget.list_ReservedTime.length;
                              i++)
                            _buildReservationItem(
                                i,
                                widget.list_ReservedTime.length,
                                widget.list_ReservedTime)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          _buildConfirmRow(
              'お名前(カタカナ)', '${widget.firstName} ${widget.secondName}'),
          _buildConfirmRow('生年月日', '${widget.birth}'),
          _buildConfirmRow('性別', widget.sexId == 0 ? '女性' : '男性'),
          _buildConfirmRow('電話番号', '${widget.mobile}'),
          _buildConfirmRow('ご利用ポイント', '${widget.usedPoints} ポイント'),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                confirm(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 58,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 249, 161, 56)),
                child: Text('ご予約を申し込む',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      
                      decoration: TextDecoration.none,
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 58,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 156, 161, 161)),
                child: Text('ご予約内容を修正する',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      
                      decoration: TextDecoration.none,
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      )),
    );
  }

  Widget _buildConfirmRow(String confirmTopic, confirmContent) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromARGB(255, 243, 243, 243)))),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding:
                    EdgeInsets.only(top: 15, left: 15, bottom: 15, right: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                ),
                child: Text(
                  confirmTopic,
                  style: TextStyle(
                      color: Color.fromARGB(255, 18, 18, 18),
                      fontSize: 12,
                      
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  confirmContent,
                  style: TextStyle(
                      color: Color.fromARGB(255, 18, 18, 18),
                      fontSize: 12,
                      
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildReservationItem(int index, int length, List reservedTimes) {
  return Container(
    margin: index != length - 1
        ? EdgeInsets.only(bottom: 10)
        : EdgeInsets.only(bottom: 0),
    child: Text('第${index + 1}希望：${reservedTimes[index]}',
        style: TextStyle(
          color: Color.fromARGB(255, 51, 51, 51),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          
          decoration: TextDecoration.none,
        )),
  );
}

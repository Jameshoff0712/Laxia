import 'package:flutter/material.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 44,
          ),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('ご予約内容の確認',
                        style: TextStyle(
                          color: Color.fromARGB(255, 51, 51, 51),
                          fontFamily: 'Hiragino Kaku Gothic Pro',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                          decoration: TextDecoration.none,
                        )),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 27,
                    color: Color.fromARGB(255, 51, 51, 51),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
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
          _buildConfirmRow('ご希望のドクター', '田中圭'),
          _buildConfirmRow('ご相談・ご要望', 'ニキビ跡や肌荒れで悩んでいます。どういった施術が適していますでしょうか？'),
          _buildConfirmRow('当日施術', '当日相談して決めたい'),
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
                            fontFamily: 'Hiragino Kaku Gothic Pro',
                            fontSize: 12,
                            height: 1.5,
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
                          _buildReservationItem(),
                          _buildReservationItem(),
                          _buildReservationItem(),
                          _buildReservationItem(),
                        ],
                      ),

                      // child: ListView.separated(
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index) {
                      //     return _buildReservationItem();
                      //   },
                      //   separatorBuilder: (context, index) => SizedBox(
                      //     height: 10,
                      //   ),
                      //   itemCount: 4,
                      // ),
                    ),
                  )
                ],
              ),
            ),
          ),
          _buildConfirmRow('お名前(カタカナ)', 'タナカ ケイ'),
          _buildConfirmRow('生年月日', '1994年2月11日'),
          _buildConfirmRow('性別', '男性'),
          _buildConfirmRow('電話番号', '09000000012'),
          _buildConfirmRow('ご利用ポイント', '2000 ポイント'),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 58,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 240, 154, 55)),
                child: Text('ご予約を申し込む',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Hiragino Kaku Gothic Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
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
            child: InkWell(
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
                      fontFamily: 'Hiragino Kaku Gothic Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
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
                      fontFamily: 'Hiragino Kaku Gothic Pro',
                      fontSize: 12,
                      height: 1.5,
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
                      fontFamily: 'Hiragino Kaku Gothic Pro',
                      fontSize: 12,
                      height: 1.5,
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

Widget _buildReservationItem() {
  return Text('第1希望：2020/04/08(水) 18:00',
      style: TextStyle(
        color: Color.fromARGB(255, 51, 51, 51),
        fontFamily: 'Hiragino Kaku Gothic Pro',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        decoration: TextDecoration.none,
      ));
}

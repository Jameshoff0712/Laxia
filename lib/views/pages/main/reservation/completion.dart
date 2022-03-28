import 'package:flutter/material.dart';

class Completion extends StatefulWidget {
  const Completion({Key? key}) : super(key: key);

  @override
  State<Completion> createState() => _CompletionState();
}

class _CompletionState extends State<Completion> {
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
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('予約完了',
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
                      Icons.close,
                      size: 27,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    color: Color.fromARGB(255, 110, 198, 210),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('予約申し込みを受け付けました',
                  style: TextStyle(
                    color: Color.fromARGB(255, 110, 198, 210),
                    fontFamily: 'Hiragino Kaku Gothic Pro',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    decoration: TextDecoration.none,
                  )),
            ),
            SizedBox(height: 3),
            Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              alignment: Alignment.center,
              child: Text('空き状況を確認中でございますので、\n予約が確定するまでお待ちください。\nチャットにてご連絡させていただきます。',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontFamily: 'Hiragino Kaku Gothic Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.8,
                    decoration: TextDecoration.none,
                  )),
            ),
            SizedBox(height: 70),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color.fromARGB(255, 110, 198, 210))),
                  child: Text('ページトップに戻る',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontFamily: 'Hiragino Kaku Gothic Pro',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

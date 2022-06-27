import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class Completion extends StatefulWidget {
  const Completion({Key? key}) : super(key: key);

  @override
  State<Completion> createState() => _CompletionState();
}

class _CompletionState extends State<Completion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          '予約完了',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent, 
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Helper.titleColor,
              size: 25,
            )),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    color: Helper.mainColor,
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
                    color: Helper.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    
                    decoration: TextDecoration.none,
                  )),
            ),
            SizedBox(height: 3),
            Container(
              alignment: Alignment.center,
              child: Text(
                  '空き状況を確認中でございますので、\n予約が確定するまでお待ちください。\nチャットにてご連絡させていただきます。',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.8,
                    decoration: TextDecoration.none,
                  )),
            ),
            SizedBox(height: 70),
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 43),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Helper.mainColor,
                      )),
                  child: Text('ページトップに戻る',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Helper.mainColor,
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

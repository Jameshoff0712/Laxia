import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/mypage/following_list_page.dart';

class InputCodePage extends StatefulWidget {
  const InputCodePage({Key? key}) : super(key: key);

  @override
  State<InputCodePage> createState() => _InputCodePageState();
}

class _InputCodePageState extends State<InputCodePage> {
  String content = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height - 54,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Helper.whiteColor,
          shadowColor: Helper.whiteColor,
          title: Text(
            '招待コードを入力',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.5,
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
        ),
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'お友達の紹介コードを\n入力してください。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  height: 1.5,
                  color: Helper.titleColor,
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Helper.mainColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Helper.mainColor),
                  ),
                  hintText: '紹介コードを入力',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.8,
                    color: Color.fromARGB(255, 194, 194, 194),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
                onChanged: (text) {
                  setState(() {
                    content = text;
                  });
                },
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 46, vertical: 9),
              decoration: BoxDecoration(
                color: content.isEmpty
                    ? Color.fromARGB(255, 194, 194, 194)
                    : Helper.mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  if (content.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => new AlertDialog(
                              title: new Text('成功'),
                              content:
                                  new Text('ポイント＊＊＊＊が追加されました。'),
                              actions: <Widget>[
                                new IconButton(
                                    icon: new Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ));
                  }
                },
                child: Text(
                  '登録',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5,
                    color: Helper.whiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

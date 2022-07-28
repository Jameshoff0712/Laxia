import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/views/pages/main/mypage/following_list_page.dart';

class InputCodePage extends StatefulWidget {
  const InputCodePage({Key? key}) : super(key: key);

  @override
  State<InputCodePage> createState() => _InputCodePageState();
}

class _InputCodePageState extends State<InputCodePage> {
  String content = '';
  final _con = MyController();
  Future<void> getinvitation(String code) async {
    try {
      final res=await _con.getinvitation(code);
      if(res==1){
        showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
                title: new Text('成功'),
                content:
                    new Text('ポイント 3000が追加されました。'),
                actions: <Widget>[
                  new IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,  
                      icon: new Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
            ));
      }else if(res==0){
        showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
                title: new Text('成功'),
                content:
                    new Text('すでに進んでいます。'),
                actions: <Widget>[
                  new IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,  
                      icon: new Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
            ));
      }else{
        showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
                title: new Text('成功'),
                content:
                    new Text('招待コードを確認してください。'),
                actions: <Widget>[
                  new IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,  
                      icon: new Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
            ));
      }
      
    } catch (e) {
    }
  }
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
                Icons.keyboard_arrow_left,
                color: Helper.titleColor,
                size: 30,
              )),
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'お友達の紹介コードを\n入力してください。',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    
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
                  cursorColor: Helper.mainColor,
                  cursorHeight: 21,
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
                child: GestureDetector(
                  onTap: () {
                    if(content.isNotEmpty){}
                      getinvitation(content);
                    },
                  child: Text(
                    '登録',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      
                      color: Helper.whiteColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

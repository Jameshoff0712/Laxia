import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/mypage/input_text_widget.dart';
import 'package:laxia/views/pages/main/mypage/selectbox_widget.dart';

class FixProfilePage extends StatefulWidget {
  @override
  State<FixProfilePage> createState() => _FixProfilePageState();
}

class _FixProfilePageState extends State<FixProfilePage> {
  String _enteredText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, "");
            },
            icon: const Icon(
              Icons.close,
              color: Helper.appTxtColor,
            )),
        centerTitle: true,
        title: Center(
          child: Text(
            'プロフィールを編集',
            style: TextStyle(color: Helper.appTxtColor, fontSize: 16.0),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => print("[Account Screen] Notification button clicked!"),
            child: Center(
              child: Container(
                child: Text(
                  "保存",
                  style: TextStyle(color: Helper.mainColor),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: Image.asset('assets/images/user/user1.jpg',
                            width: 80, height: 80, fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                        height: 20,
                        width: 24,
                        decoration: BoxDecoration(color: Colors.black45),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "プロフィール写真を変更",
                style: TextStyle(color: Helper.mainColor, fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Column(
                  children: [
                    InputTextWidget(
                        labelName: "ニックネーム",
                        placeHolder: "あやか",
                        maxLegnth: "40"),
                    SizedBox(
                      height: 10,
                    ),
                    InputTextWidget(
                        labelName: "ユーザーID",
                        placeHolder: "Ayaka",
                        maxLegnth: "40"),
                    SizedBox(
                      height: 10,
                    ),
                    InputTextWidget(
                        labelName: "生年月日",
                        placeHolder: "生年月日は非公開です。年代のみ公開されます。",
                        maxLegnth: ""),
                    SizedBox(
                      height: 10.0,
                    ),
                    SelectBoxWidget(
                      name: "性別",
                      items: ["女性", "男性"],
                      chosenValue: "女性",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    InputTextWidget(
                        labelName: "自己紹介",
                        placeHolder: "プロフィールに自己紹介を追加する",
                        maxLegnth: "140"),
                    SizedBox(
                      height: 10.0,
                    ),
                    SelectBoxWidget(
                      name: "施術希望エリア",
                      items: [],
                      chosenValue: "",
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SelectBoxWidget(
                      name: "気になっている施術・部位",
                      items: [],
                      chosenValue: "",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/mypage/contact_page.dart';
import 'package:laxia/views/pages/main/mypage/deletion_guide_web.dart';
import 'package:laxia/views/pages/main/mypage/fix_profile_page.dart';
import 'package:laxia/views/pages/main/mypage/privacy_policy_web.dart';
import 'package:laxia/views/pages/main/mypage/terms_of_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String appVersion = '1.1.0';
  List setting_itmes = [
    {
      'item_text': '運営ポリシー',
      'item_right': Icon(
        Icons.keyboard_arrow_right,
        color: Helper.txtColor,
        size: 25,
      ),
      'item_taped': (BuildContext context) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TermsOfServicePage()));
      }
    },
    {
      'item_text': 'プライバシーポリシー',
      'item_right': Icon(
        Icons.keyboard_arrow_right,
        color: Helper.txtColor,
        size: 25,
      ),
      'item_taped': (BuildContext context) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PrivacyPolicyWeb()));
      }
    },
    {
      'item_text': '利用規約',
      'item_right': Icon(
        Icons.keyboard_arrow_right,
        color: Helper.txtColor,
        size: 25,
      ),
      'item_taped': (BuildContext context) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TermsOfServicePage()));
      }
    },
    {
      'item_text': 'ポイント利用規約',
      'item_right': Icon(
        Icons.keyboard_arrow_right,
        color: Helper.txtColor,
        size: 25,
      ),
      'item_taped': (BuildContext context) {}
    },
    {
      'item_text': '削除ガイドライン',
      'item_right': Icon(
        Icons.keyboard_arrow_right,
        color: Helper.txtColor,
        size: 25,
      ),
      'item_taped': (BuildContext context) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DeletionGuideWeb()));
      }
    },
    {
      'item_text': 'よくある質問',
      'item_right': Icon(
        Icons.keyboard_arrow_right,
        color: Helper.txtColor,
        size: 25,
      ),
      'item_taped': (BuildContext context) {}
    },
    {
      'item_text': 'お問い合わせ',
      'item_right': Icon(
        Icons.keyboard_arrow_right,
        color: Helper.txtColor,
        size: 25,
      ),
      'item_taped': (BuildContext context) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContactPage()));
      }
    },
    {
      'item_text': 'アプリのバージョン',
      'item_right': Text(
        '1.1.0',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.14,
          color: Color.fromARGB(255, 102, 110, 110),
        ),
      ),
      'item_taped': (BuildContext context) {}
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          '設定',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.all(16),
              height: 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 200, 199, 204),
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 200, 199, 204),
                      ))),
              child: _buildSettingItem(
                  'プロフィールを編集',
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Helper.txtColor,
                    size: 25,
                  ), (context) {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                  ),
                  context: context,
                  builder: (context) {
                    return FixProfilePage();
                  },
                  isScrollControlled: true,
                );
              }),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 200, 199, 204),
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 200, 199, 204),
                      ))),
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: setting_itmes.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: _buildSettingItem(
                          setting_itmes[index]['item_text'],
                          setting_itmes[index]['item_right'],
                          setting_itmes[index]['item_taped']),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                        height: 1,
                        margin: EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 200, 199, 204),
                        ),
                      )),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 200, 199, 204),
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 200, 199, 204),
                      ))),
              child: Text(
                'ログアウト',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.2,
                  color: Color.fromARGB(255, 18, 18, 18),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 200, 199, 204),
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 200, 199, 204),
                      ))),
              child: Text(
                'アカウント削除',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.2,
                  color: Color.fromARGB(255, 237, 95, 89),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildSettingItem(String text, Widget Right, Function taped) {
    return GestureDetector(
      onTap: () {
        taped(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.14,
              color: Color.fromARGB(255, 18, 18, 18),
            ),
          ),
          Right,
        ],
      ),
    );
  }
}

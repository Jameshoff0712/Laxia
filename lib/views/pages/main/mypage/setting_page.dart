import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
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
              child: _buildSettingItem(),
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
                  itemCount: 8,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: _buildSettingItem(),
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
                      ))
              ),
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
                      ))
              ),
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

  InkWell _buildSettingItem() {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'プロフィールを編集',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.2,
              color: Color.fromARGB(255, 18, 18, 18),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: Helper.txtColor,
            size: 20,
          )
        ],
      ),
    );
  }
}

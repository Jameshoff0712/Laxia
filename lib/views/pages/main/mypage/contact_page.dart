import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'お問い合わせ',
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'お問い合わせ',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Helper.titleColor,
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(color: Helper.whiteColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ユーザーID',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        height: 1.5,
                        color: Helper.titleColor,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'メールアドレス',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        height: 1.5,
                        color: Helper.titleColor,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'ご意見・お問い合わせの内容',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        height: 1.5,
                        color: Helper.titleColor,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    TextField(
                      maxLines: 6,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '【カスタマーサポートについて】\n営業時間：平日10時〜17時\n※営業時間外のお問いあわせは返信に時間がかかる場合がございます\n※土日祝日にいただいたお問い合わせにつきまして、翌営業日以降のご返信となりますのであらかじめご了承ください。\n※弊社では電話対応を行っていないため、申し訳ございませんがメールでのサポートのみとさせていただきます。\n※お問い合わせいただきました内容によっては、お答えできない場合やお時間がかかる場合がございます。',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Helper.maintxtColor,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 36),
                          decoration: BoxDecoration(
                              color: Helper.mainColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'お問い合わせ内容を送信する',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              height: 1.5,
                              color: Helper.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class TermsOfServicePage extends StatefulWidget {
  const TermsOfServicePage({Key? key}) : super(key: key);

  @override
  State<TermsOfServicePage> createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          '利用規約',
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
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '利用規約',
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
                    '美容医療の口コミ・予約サービスのLAXIA（以下「本サイト」といいます）の運営・保守を行う株式会社ラシア（以下「当社」といいます）は、LAXIA利用規約（以下「本規約」といいます）を以下の通り定めるものとします。本規約は、当社が提供する本サービス（第１条第１項で規定）及び個別サービスガイドラインに規定する各サービスの利用に関する条件を、利用者（第１条第５項で規定）と当社との間で定めるものです。',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      
                      color: Helper.titleColor,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _buildChapterText(),
                  ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildSectionContent();
                    },
                  ),
                  Text(
                    '2020年11月20日制定',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      
                      color: Helper.blackColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildSectionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1.本サービス',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            
            color: Helper.blackColor,
          ),
        ),
        Text(
          '本規約に従って当社により運営管理され、利用者に提供される本サイトにおけるサービスの総称',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            
            color: Helper.titleColor,
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  Container _buildChapterText() {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        '第1条 定義',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          
          color: Helper.blackColor,
        ),
      ),
    );
  }
}

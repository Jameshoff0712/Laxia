import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/notice_card.dart';

class NoticeListPage extends StatefulWidget {
  const NoticeListPage({Key? key}) : super(key: key);

  @override
  State<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage> {
  List notice_details = [];
  Future<void> get_Notice_Datails() async {
    String txt_notice_details =
        await rootBundle.loadString("cfg/detail_notice.json");
    setState(() {
      notice_details.addAll(json.decode(txt_notice_details));
    });
  }

  @override
  void initState() {
    get_Notice_Datails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'お知らせ',
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
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated(
              itemCount: notice_details.length,
              itemBuilder: (BuildContext context, int index) {
                return NoticeCardWidget(
                  title: notice_details[index]["title"],
                  content: notice_details[index]["content"],
                  time: notice_details[index]["time"],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class NoticeDetailPage extends StatefulWidget {
  final String title, content, time;
  const NoticeDetailPage(
      {Key? key,
      required this.title,
      required this.content,
      required this.time})
      : super(key: key);

  @override
  State<NoticeDetailPage> createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 1.5,
                color: Helper.titleColor,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.time,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.5,
                  color: Helper.txtColor,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.content,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.5,
                color: Helper.titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

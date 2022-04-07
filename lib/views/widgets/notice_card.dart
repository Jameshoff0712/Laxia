import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/mypage/notice_detail_page.dart';

class NoticeCardWidget extends StatefulWidget {
  final String title, content, time;
  const NoticeCardWidget(
      {Key? key,
      required this.title,
      required this.content,
      required this.time})
      : super(key: key);

  @override
  State<NoticeCardWidget> createState() => _NoticeCardWidgetState();
}

class _NoticeCardWidgetState extends State<NoticeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoticeDetailPage(
                      title: widget.title,
                      content: widget.content,
                      time: widget.time,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Helper.whiteColor,
        ),
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
            SizedBox(
              height: 8,
            ),
            Text(
              widget.content,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.5,
                color: Helper.titleColor,
              ),
              maxLines: 2,
            ),
            SizedBox(
              height: 8,
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
          ],
        ),
      ),
    );
  }
}

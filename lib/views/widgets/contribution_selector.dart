import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ModalBottomSheet extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet>
    with SingleTickerProviderStateMixin {
  bool selected = false;
  int? selectedIndex;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: SizedBox(
        height: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 14.0, 18.0, 8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: defaultTextStyle(Colors.black, FontWeight.w700,
                          size: 22),
                    ),
                    Text(
                      "作成",
                      style: defaultTextStyle(Colors.black, FontWeight.w700,
                          size: 22),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    )
                  ]),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/AddDiaryList");
              },
              child: ListTile(
                leading: SvgPicture.asset(
                  "icons/diary.svg",
                  width: 36,
                  height: 36,
                ),
                minVerticalPadding: 20,
                title: Text('日記を投稿する'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/AddCounselList");
              },
              child: ListTile(
                leading: SvgPicture.asset(
                  "icons/counsel.svg",
                  width: 36,
                  height: 36,
                ),
                minVerticalPadding: 20,
                title: Text('カウセレポを投稿する'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/AddQuestion");
              },
              child: ListTile(
                leading: SvgPicture.asset(
                  "icons/question.svg",
                  width: 36,
                  height: 36,
                ),
                minVerticalPadding: 20,
                title: Text('質問を投稿する'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

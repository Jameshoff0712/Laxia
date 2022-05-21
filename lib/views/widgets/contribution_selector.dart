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
                      style: TextStyle(
                          color: Helper.titleColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          height: 1.5),
                    ),
                    Text(
                      "作成",
                      style: TextStyle(
                          color: Helper.titleColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          height: 1.5),
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
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(children: [
                  SvgPicture.asset(
                    "assets/icons/diary.svg",
                    width: 44,
                    height: 44,
                  ),
                  SizedBox(width: 16,),
                  Padding(padding: EdgeInsets.only(top: 13, bottom: 7),
                    child: Text("日記を投稿する",
                    style: TextStyle(
                      color: Helper.titleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5
                    ),),
                  )
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/AddCounselList");
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(children: [
                  SvgPicture.asset(
                    "assets/icons/counsel.svg",
                    width: 44,
                    height: 44,
                  ),
                  SizedBox(width: 16,),
                  Padding(padding: EdgeInsets.only(top: 13, bottom: 7),
                    child: Text("カウセレポを投稿する",
                    style: TextStyle(
                      color: Helper.titleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5
                    ),),
                  )
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/AddQuestion");
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(children: [
                  SvgPicture.asset(
                    "assets/icons/question.svg",
                    width: 44,
                    height: 44,
                    color: Helper.mainColor,
                  ),
                  SizedBox(width: 16,),
                  Padding(padding: EdgeInsets.only(top: 13, bottom: 7),
                    child: Text("質問を投稿する",
                    style: TextStyle(
                      color: Helper.titleColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 1.5
                    ),),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

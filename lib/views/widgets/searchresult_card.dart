import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/contribution/case_detail.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_detail.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';

class SearchResult extends StatefulWidget {
  final int index;
  final List<int> count;
  const SearchResult(
      {Key? key,
      required this.index,
      required this.count})
      : super(key: key);
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final List<String> tabMenus = [
    'メニュー',
    'クリニック',
    'ドクター',
    '日記',
    '症例',
    'カウセレポ',
    '質問',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Helper.whiteColor),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            child: Text(
              tabMenus[widget.index],
              style: TextStyle(
                  fontFamily: Helper.headFontFamily,
                  
                  color: Helper.titleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
          for (int i = 0; i < widget.count.length; i++)
            GestureDetector(
              onTap: (){
                switch(widget.index){
                  case 1:  Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Menu_Detail(
                                                index:
                                                    widget.count[i]))); break;
                  case 2: Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Clinic_Detail(
                                                index:
                                                    widget.count[i]))); break;
                  case 3: Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Doctor_Detail(
                                                index:
                                                    widget.count[i]))); break;
                  case 4: Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Diary_Detail(
                                                index:
                                                    widget.count[i]))); break;
                  case 5: Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => CaseDetail(
                                                index:
                                                    widget.count[i]))); break;
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "検索結果" + (i + 1).toString(),
                      style: TextStyle(
                          color: Helper.selectTabColor,
                          fontSize: 12,
                          
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: 28,
                      color: Helper.maintxtColor,
                    )
                  ],
                ),
              ),
            )
        ]),
      ),
    );
  }
}

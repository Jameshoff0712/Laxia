import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class SearchResult extends StatefulWidget {
  final int index, count;
  final VoidCallback onpress;
  const SearchResult(
      {Key? key,
      required this.index,
      required this.count,
      required this.onpress})
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
                  height: 1.5,
                  color: Helper.titleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
          for (int i = 0; i < widget.count; i++)
            InkWell(
              onTap: widget.onpress,
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
                          height: 1.5,
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

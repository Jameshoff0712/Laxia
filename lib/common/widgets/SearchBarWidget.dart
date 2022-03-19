import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../helper.dart';
import 'SearchWidget.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged? onClickFilter;

  const SearchBarWidget({Key? key, this.onClickFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(SearchModal());
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 8, bottom: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // width: 16,
              // height: 16,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  child: Icon(Icons.search, color: Color.fromARGB(255, 156, 161, 161)),
                ),
              ),
            ),
            SizedBox(
              width: 11,
            ),
            Expanded(
              child: Text(
                '施術名やクリニック名で検索',//Trans.of(context).search,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 14, 
                  color: Color.fromARGB(255, 156, 161, 161), 
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Hiragino Kaku Gothic Pro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

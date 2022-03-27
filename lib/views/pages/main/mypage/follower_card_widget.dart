import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_user.dart';

class FollowerCardWidget extends StatefulWidget {
  @override
  State<FollowerCardWidget> createState() => _FollowerCardWidget();
}

class _FollowerCardWidget extends State<FollowerCardWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            height: 36,
            width: 36,
            child: CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage(
                "${currentUser.imageUrl}",
              ),
            ),
          ),
          SizedBox(
            width: 7,
          ),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  children: [
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          "りりこ",
                          style: defaultTextStyle(
                              Helper.appTxtColor, FontWeight.w700,
                              size: 20),
                        )),
                    SizedBox(
                      height: 2.0,
                    ),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          "@tanaka_kei",
                          style: defaultTextStyle(
                              Helper.lightGrey, FontWeight.w700,
                              size: 20),
                        )),
                  ],
                ),
              ),
              OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      shape: StadiumBorder(),
                      side: BorderSide(width: 1, color: Helper.mainColor)),
                  child: Text(
                    "フォロー中",
                    style: defaultTextStyle(Helper.mainColor, FontWeight.w100,
                        size: 16),
                  )),
            ],
          ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_user.dart';

class FollowingCardWidget extends StatefulWidget {
  const FollowingCardWidget({Key? key}) : super(key: key);

  @override
  State<FollowingCardWidget> createState() => _FollowingCardWidgetState();
}

class _FollowingCardWidgetState extends State<FollowingCardWidget> {
  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "りりこ",
                      style: defaultTextStyle(
                          Helper.appTxtColor, FontWeight.w700,
                          size: 20),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      "@tanaka_kei",
                      style: defaultTextStyle(Helper.lightGrey, FontWeight.w700,
                          size: 20),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Helper.mainColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "フォロー中",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Helper.mainColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                        height: 1.5),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}

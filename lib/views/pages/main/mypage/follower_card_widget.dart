import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_user.dart';

class FollowerCardWidget extends StatefulWidget {
  final String photo, name, nickname;
  const FollowerCardWidget(
      {Key? key,
      required this.photo,
      required this.name,
      required this.nickname})
      : super(key: key);

  @override
  State<FollowerCardWidget> createState() => _FollowerCardWidgetState();
}

class _FollowerCardWidgetState extends State<FollowerCardWidget> {
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
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 18, 18),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.5),
                    ),
                    Text(
                      "@tanaka_kei",
                      style: TextStyle(
                          color: Color.fromARGB(255, 102, 110, 110),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Helper.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "フォローする",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Helper.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
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

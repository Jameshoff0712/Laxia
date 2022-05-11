import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_user.dart';

class FollowingCardWidget extends StatefulWidget {
  final String photo, name, nickname;
  const FollowingCardWidget(
      {Key? key,
      required this.photo,
      required this.name,
      required this.nickname})
      : super(key: key);

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.photo,
                placeholder: (context, url) => Image.asset(
                  'assets/images/loading.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
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
                      widget.name,
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 18, 18),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          height: 1.5),
                    ),
                    Text(
                      widget.nickname,
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
                  margin: EdgeInsets.only(right: 4),
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

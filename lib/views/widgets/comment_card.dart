import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Comment_Card extends StatefulWidget {
  final String name, ename, avatar, comment, date;
  final VoidCallback onpress;
  const Comment_Card({
    Key? key,
    required this.name,
    required this.ename,
    required this.avatar,
    required this.comment,
    required this.date, 
    required this.onpress,
  }) : super(key: key);

  @override
  State<Comment_Card> createState() => _Comment_CardState();
}

class _Comment_CardState extends State<Comment_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      // color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  // Navigator.of(context).pushNamed("/Mypage");
                },
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.avatar,
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
              ),
              SizedBox(width: 7),
              Text(
                widget.name,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Helper.titleColor),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "@"+widget.ename,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Helper.mainColor),
                ),
                Text(
                  '  ' + widget.comment,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Helper.titleColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.date,
                  style: TextStyle( fontWeight: FontWeight.w400,fontSize: 12, color: Color.fromARGB(255, 197, 199, 199)),
                ),
                GestureDetector(
                  onTap:widget.onpress,
                  child: Text(
                    '返信',
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12, color: Helper.mainColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

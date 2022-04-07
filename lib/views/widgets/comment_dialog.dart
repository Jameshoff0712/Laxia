import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/widgets/comment_card.dart';

class CommentDialogSheet extends StatefulWidget {
  @override
  _CommentDialogSheetState createState() => _CommentDialogSheetState();
}

class _CommentDialogSheetState extends State<CommentDialogSheet>
    with SingleTickerProviderStateMixin {
  List comment_list = [];
  bool bSend = false;

  @override
  void initState() {
    get_comment_info();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> get_comment_info() async {
    String mid = await rootBundle.loadString("assets/cfg/comment_info.json");
    setState(() {
      comment_list.addAll(json.decode(mid));
    });
  }

  Widget build(BuildContext context) {
    return comment_list.isNotEmpty? Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
                    "14件のコメント",
                    style: defaultTextStyle(Colors.black, FontWeight.w700,
                        size: 22),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  )
                ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                for (int i = 0; i < comment_list.length; i++)
                  Comment_Card(
                      name: comment_list[i]['name'],
                      ename: comment_list[i]['ename'],
                      avatar: comment_list[i]["avatar"],
                      comment: comment_list[i]["comment"],
                      date: comment_list[i]["date"]),
                Divider(color: Helper.lightGrey),
                Container(
                  //height: 42,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  bSend = true;
                                });
                              } else {
                                setState(() {
                                  bSend = false;
                                });
                              }
                            },
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 4,
                            decoration: InputDecoration(
                              fillColor: Helper.lightGrey,
                              filled: true,
                              hintText: "素敵なコメントを書く",
                              contentPadding: EdgeInsets.only(
                                  top: 3, left: 15, right: 15, bottom: 3),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(color: Helper.lightGrey),
                              ),
                            ),
                          ),
                        ),
                        SvgPicture.asset("assets/icons/send.svg",
                            width: 30,
                            height: 30,
                            color: bSend ? Helper.mainColor : Helper.extraGrey),
                      ]),
                ),
              ]),
            ),
          )
        ],
      ),
    ):Container();
  }
}

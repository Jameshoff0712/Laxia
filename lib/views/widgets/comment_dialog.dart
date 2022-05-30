import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/question/comment_model.dart';
import 'package:laxia/views/widgets/comment_card.dart';

class CommentDialogSheet extends StatefulWidget {
  final String domain;
  final int index;
  final int count;
  const CommentDialogSheet(
      {Key? key,
      required this.index,
      required this.count,
      required this.domain})
      : super(key: key);
  @override
  State<CommentDialogSheet> createState() => _CommentDialogSheetState();
}

class _CommentDialogSheetState extends State<CommentDialogSheet>
    with SingleTickerProviderStateMixin {
  TextEditingController sender = new TextEditingController();
  int page = 1;
  bool bSend = false, isloading = true, isexpanding = true, isend = false;
  final _con = HomeController();
  late Comment comment;
  Future<void> getData() async {
    try {
      final mid = await _con.getCommentList(
          index: widget.index, domain: widget.domain, page: page.toString());
      if (isloading) {
        setState(() {
          comment = mid;
          isloading = false;
        });
      } else {
        setState(() {
          comment.data.addAll(mid.data);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(String addcomment) async {
    try {
      final mid = await _con.postComment(
          index: widget.index, domain: widget.domain, comment: addcomment);
      setState(() {
        comment.data.add(mid);
      });
      sender.text = "";
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Helper.whiteColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Helper.whiteColor.withOpacity(0),
    ));
    return isloading
        ? Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ))
        : Container(
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
                          widget.count.toString() + "件のコメント",
                          style: defaultTextStyle(Colors.black, FontWeight.w400,
                              size: 16),
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
                      for (int i = 0; i < comment.data.length; i++)
                        Comment_Card(
                            name: comment.data[i].patient_nickname == null
                                ? ""
                                : comment.data[i].patient_nickname!,
                            ename: comment.data[i].patient_nickname == null
                                ? ""
                                : comment.data[i].patient_nickname!,
                            avatar: comment.data[i].patient_photo == null
                                ? "http:/error.png"
                                : comment.data[i].patient_photo!,
                            comment: comment.data[i].comment!,
                            date: comment.data[i].created_at!.split('T')[0]),
                      Divider(color: Helper.lightGrey),
                    ]),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: MediaQuery.of(context).viewInsets,
                      decoration: BoxDecoration(
                        color: Helper.whiteColor,
                      
                      ),
                      //height: 42,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 30,
                              child: TextField(
                                controller: sender,
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
                                  hintStyle: TextStyle(fontSize: 10),
                                  fillColor: Color.fromARGB(255, 243, 243, 243),
                                  filled: true,
                                  hintText: "",
                                  contentPadding: EdgeInsets.only(
                                      top: 3, left: 15, right: 15, bottom: 3),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 243, 243, 243),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 243, 243, 243),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 243, 243, 243),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                postComment(sender.text);
                              },
                              child: SvgPicture.asset("assets/icons/send.svg",
                                  width: 30,
                                  height: 30,
                                  color: bSend
                                      ? Helper.mainColor
                                      : Helper.extraGrey),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

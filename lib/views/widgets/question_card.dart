import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:nb_utils/nb_utils.dart';

class Question_Card extends StatefulWidget {
  final VoidCallback onpress;
  final Color? buttoncolor, fontcolor;
  final String avator,
      name,
      image1,
      image2,
      sentence,
      type,
      eyes,
      hearts,
      chats;
  final String? buttontext;
  const Question_Card({
    Key? key,
    required this.onpress,
    required this.avator,
    required this.name,
    required this.image1,
    required this.image2,
    required this.sentence,
    required this.type,
    required this.hearts,
    required this.chats,
    required this.eyes,
    this.buttoncolor,
    this.fontcolor,
    this.buttontext="",
  }) : super(key: key);

  @override
  State<Question_Card> createState() => _Question_CardState();
}

class _Question_CardState extends State<Question_Card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Helper.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: widget.onpress,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 29,
                      width: 29,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.avator,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/ProDoctor.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Helper.titleColor),
                    ),
                    widget.buttontext!.isEmpty
                        ? SizedBox(
                            width: 1,
                          )
                        : Expanded(
                            child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: widget.buttoncolor,),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Text(
                                  widget.buttontext!,
                                  style: TextStyle(
                                      color: widget.fontcolor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ))
                  ],
                ),
                Text(
                  widget.sentence,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Helper.titleColor),
                ),
                Container(
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        crossAxisCount: 4,
                        childAspectRatio: 1),
                    children: [
                      SizedBox(
                        height: 78,
                        width: 78,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.image1,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/ProDoctor.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 78,
                        width: 78,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.image2,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/ProDoctor.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 78,
                        width: 78,
                      ),
                      SizedBox(
                        height: 78,
                        width: 78,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "icons/menubar/ping.svg",
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        widget.type,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Helper.maintxtColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              "icons/menubar/eye.svg",
                              width: 13,
                              height: 13,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.eyes,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Helper.txtColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              "icons/menubar/heart.svg",
                              width: 13,
                              height: 13,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.hearts,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Helper.txtColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              "icons/menubar/comment.svg",
                              width: 13,
                              height: 13,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.chats,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: Helper.txtColor),
                            )
                          ]),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:nb_utils/nb_utils.dart';

class Diary_Card extends StatefulWidget {
  final VoidCallback onpress;
  final Color? buttoncolor, fontcolor;
  final String avator,
      name,
      image1,
      image2,
      sentence,
      type,
      check,
      price,
      eyes;
  final String? buttontext, hearts, chats,clinic;
  const Diary_Card(
      {Key? key,
      required this.onpress,
      required this.avator,
      required this.name,
      this.buttontext="",
      required this.image1,
      required this.image2,
      required this.sentence,
      required this.type,
      this.clinic="",
      required this.check,
      required this.price,
      this.buttoncolor,
      this.fontcolor,
      this.hearts="",
      this.chats="",
      required this.eyes})
      : super(key: key);

  @override
  State<Diary_Card> createState() => _Diary_CardState();
}

class _Diary_CardState extends State<Diary_Card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Helper.whiteColor,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: widget.onpress,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                Container(
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 3.5,
                        crossAxisSpacing: 7,
                        crossAxisCount: 2,
                        childAspectRatio: 1),
                    children: [
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Stack(
                          alignment : AlignmentDirectional.bottomStart,
                          children: [
                            Container(
                              width: 426,
                              height: 426,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: widget.image1,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/images/loading.gif',
                                    fit: BoxFit.fill,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/ProDoctor.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Helper.blackColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30))),
                                child: Center(
                                  child: Text(
                                    "Before",
                                    style: TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.w600),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Stack(
                          alignment : AlignmentDirectional.bottomStart,
                          children: [
                            Container(
                              width: 426,
                              height: 426,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: widget.image2,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/images/loading.gif',
                                    fit: BoxFit.fill,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/images/ProDoctor.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Helper.blackColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30))),
                                child: Center(
                                  child: Text(
                                    "After",
                                    style: TextStyle(color: white,fontSize: 20,fontWeight: FontWeight.w600),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.sentence,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Helper.titleColor),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/menubar/ping.svg",
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
                widget.clinic!.isEmpty
                    ? SizedBox(
                        height: 0,
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/menubar/clinic.svg",
                                  width: 12,
                                  height: 12,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  widget.clinic!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Helper.maintxtColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/menubar/part.svg",
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        widget.check,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Helper.maintxtColor),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/menubar/money.svg",
                        width: 10,
                        height: 9,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        widget.price,
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
                              "assets/icons/menubar/eye.svg",
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
                            widget.chats!.isEmpty
                                ? SizedBox(
                                    width: 0,
                                  )
                                : Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/menubar/heart.svg",
                                        width: 13,
                                        height: 13,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        widget.hearts!,
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Helper.txtColor),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/menubar/comment.svg",
                                        width: 13,
                                        height: 13,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        widget.chats!,
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Helper.txtColor),
                                      ),
                                    ],
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

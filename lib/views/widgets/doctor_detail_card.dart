import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';

class Doctor_DetailCard extends StatefulWidget {
  final String image, post, name, mark, clinic, experience_year;
  final List items, profile;

  const Doctor_DetailCard(
      {Key? key,
      required this.image,
      required this.post,
      required this.name,
      required this.mark,
      required this.items,
      required this.profile,
      required this.clinic,
      required this.experience_year})
      : super(key: key);

  @override
  State<Doctor_DetailCard> createState() => _Doctor_DetailCardState();
}

class _Doctor_DetailCardState extends State<Doctor_DetailCard> {
  bool isVisible = false;
  final _whiteColor = Helper.whiteColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => Doctor_Detail()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(color: _whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                          width: 24,
                        ),
                        SizedBox(
                          height: 72,
                          width: 72,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.image,
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
                          height: 20,
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: _whiteColor),
                  child: SizedBox(
                    width: 12,
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: _whiteColor,
                    height: 90,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.name.length > 5
                                  ? widget.name.substring(0, 5) + "..."
                                  : widget.name,
                              style: defaultTextStyle(
                                  Helper.titleColor, FontWeight.w700,
                                  size: 18.0),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.post,
                              style: TextStyle(
                                  color: Helper.maintxtColor,
                                  fontWeight: FontWeight.w400,
                                  
                                  fontSize: 12.0),
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Text(
                              "医師歴" + widget.experience_year + "年",
                              style: TextStyle(
                                  color: Helper.maintxtColor,
                                  fontWeight: FontWeight.w400,
                                  
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                Icons.star_rounded,
                                color: Color.fromARGB(255, 206, 176, 88),
                                size: 18,
                              ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.mark,
                              style: defaultTextStyle(
                                  Helper.titleColor, FontWeight.w700,
                                  size: 12.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              color: Helper.whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.items[0].toString(),
                        style: TextStyle(
                            color: Helper.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "日記",
                        style: TextStyle(
                            color: Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.items[1].toString(),
                        style: TextStyle(
                            color: Helper.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "カウセレポ",
                        style: TextStyle(
                            color: Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.items[2].toString(),
                        style: TextStyle(
                            color: Helper.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "症例",
                        style: TextStyle(
                            color: Helper.titleColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 10, top: 25, right: 10, bottom: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/doctor.svg",
                          width: 10,
                          height: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.profile[0]['title'],
                          style: defaultTextStyle(
                              Helper.titleColor, FontWeight.w700,
                              size: 12.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.profile[0]['content'],
                      style: TextStyle(
                          color: Helper.titleColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 500),
              child: Container(
                height: isVisible ? null : 0.0,
                padding:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/history.svg",
                            width: 15,
                            height: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.profile[1]['title'],
                            style: defaultTextStyle(
                                Helper.titleColor, FontWeight.w700,
                                size: 13.0),
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
                        widget.profile[1]['content'],
                        style: defaultTextStyle(
                            Helper.titleColor, FontWeight.normal,
                            size: 11.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 500),
              child: Container(
                height: isVisible ? null : 0.0,
                padding:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/qualify.svg",
                            width: 15,
                            height: 15,
                          ),
                          SizedBox(width: 5),
                          Text(
                            widget.profile[2]['title'],
                            style: defaultTextStyle(
                                Helper.titleColor, FontWeight.w700,
                                size: 13.0),
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
                        widget.profile[2]['content'],
                        style: defaultTextStyle(
                            Helper.titleColor, FontWeight.normal,
                            size: 11.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: isVisible
                  ? InkWell(
                      onTap: () => setState(() {
                        isVisible = !isVisible;
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('閉じる',
                                style: TextStyle(color: Helper.mainColor)),
                            SizedBox(width: 10),
                            Icon(Icons.keyboard_arrow_up,
                                color: Helper.mainColor),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () => setState(() {
                        isVisible = !isVisible;
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 8, bottom: 10),
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('さらに詳しい情報',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Helper.mainColor,
                                    fontSize: 14)),
                            SizedBox(width: 10),
                            Icon(Icons.keyboard_arrow_down,
                                color: Helper.mainColor),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CounselShort_Card extends StatefulWidget {
  final String clinic, doctor;
  const CounselShort_Card(
      {Key? key, required this.clinic, required this.doctor})
      : super(key: key);

  @override
  State<CounselShort_Card> createState() => _CounselShort_CardState();
}

class _CounselShort_CardState extends State<CounselShort_Card> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => MessageScreen(user: favorites[index])));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 5)
          ], color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "icons/menubar/clinic.svg",
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.clinic,
                        style: defaultTextStyle(
                            Helper.mainColor, FontWeight.w500,
                            size: 12.0),
                      ),
                      Expanded(
                        child: SizedBox(width: double.infinity),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Helper.mainColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 246, 246, 246),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "icons/menubar/part.svg",
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.doctor,
                        style: defaultTextStyle(
                            Helper.mainColor, FontWeight.w500,
                            size: 12.0),
                      ),
                      Expanded(
                        child: SizedBox(width: double.infinity),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Helper.mainColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

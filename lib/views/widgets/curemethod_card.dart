import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CureMethod_Card extends StatefulWidget {
  final String image, heading, price, tax, clinic, doctor;
  const CureMethod_Card(
      {Key? key,
      required this.image,
      required this.heading,
      required this.price,
      required this.tax,
      required this.clinic,
      required this.doctor})
      : super(key: key);

  @override
  State<CureMethod_Card> createState() => _CureMethod_CardState();
}

class _CureMethod_CardState extends State<CureMethod_Card> {
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
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Helper.whiteColor),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 7, bottom: 10),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
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
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Helper.whiteColor),
                    child: SizedBox(
                      width: 10,
                      height: 70,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Helper.whiteColor,
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 21,
                                    child: Text(
                                      widget.heading,
                                      style: defaultTextStyle(
                                          Helper.titleColor, FontWeight.w700,
                                          size: 14.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.price,
                                      style: defaultTextStyle(
                                          Helper.priceColor, FontWeight.w700,
                                          size: 16.0),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      widget.tax,
                                      style: defaultTextStyle(
                                          Helper.titleColor, FontWeight.w500,
                                          size: 10.0),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Helper.btnBgYellowColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "予約",
                                        style: defaultTextStyle(
                                            Helper.whiteColor,
                                            FontWeight.normal,
                                            size: 10),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
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

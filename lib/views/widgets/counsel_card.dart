import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:laxia/common/helper.dart';

class CounselAddPage_Card extends StatefulWidget {
  final VoidCallback onpress;
  final Color? buttoncolor, fontcolor;
  final String avator, name, image1, image2, sentence, type, check, price, eyes;
  final String? buttontext, hearts, chats, clinic;
  const CounselAddPage_Card(
      {Key? key,
      required this.onpress,
      required this.avator,
      required this.name,
      this.buttontext = "",
      required this.image1,
      required this.image2,
      required this.sentence,
      required this.type,
      this.clinic = "",
      required this.check,
      required this.price,
      this.buttoncolor,
      this.fontcolor,
      this.hearts = "",
      this.chats = "",
      required this.eyes})
      : super(key: key);

  @override
  State<CounselAddPage_Card> createState() => _CounselAddPage_CardState();
}

class _CounselAddPage_CardState extends State<CounselAddPage_Card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: widget.onpress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.type,
                  style: TextStyle(
                      fontSize: 16,
                      
                      fontWeight: FontWeight.w700,
                      color: Helper.maintxtColor),
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/menubar/clinic.svg",
                                      width: 12,
                                      height: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.clinic!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        
                                        fontWeight: FontWeight.w400,
                                        color: Helper.mainColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/menubar/part.svg",
                                      width: 12,
                                      height: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.check,
                                    style: TextStyle(
                                        fontSize: 12,
                                        
                                        fontWeight: FontWeight.w400,
                                        color: Helper.mainColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 42,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/AddCounselStep1");
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        side: const BorderSide(
                            color: Helper.mainColor,
                            width: 2,
                            style: BorderStyle.solid),
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        onSurface: Helper.mainColor,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'レポートを編集',
                              style: TextStyle(
                                  fontSize: 12,
                                  
                                  fontWeight: FontWeight.w700,
                                  color: Helper.mainColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

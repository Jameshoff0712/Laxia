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
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: widget.onpress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.type,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 51, 51, 51)),
                ),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "icons/menubar/clinic.svg",
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
                                            color: Color.fromARGB(
                                                255, 110, 198, 210)),
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
                                    "icons/menubar/part.svg",
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
                                        color:
                                            Color.fromARGB(255, 110, 198, 210)),
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
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 76,
                    padding: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/AddCounselStep1");
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 110, 198, 210),
                            width: 2,
                            style: BorderStyle.solid),
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        onSurface: Color.fromARGB(255, 110, 198, 210),
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'レポートを編集',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 110, 198, 210)),
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

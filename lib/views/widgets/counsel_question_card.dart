import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:laxia/common/helper.dart';

class CounselQuestion_Card extends StatefulWidget {
  final VoidCallback onpress;
  final int index;
  final String question, answer;
  const CounselQuestion_Card({
    Key? key,
    required this.onpress,
    required this.index,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  State<CounselQuestion_Card> createState() => _CounselQuestion_CardState();
}

class _CounselQuestion_CardState extends State<CounselQuestion_Card> {
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
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: widget.onpress,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Q' + widget.index.toString() + " ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 110, 198, 210)),
                    ),
                    Text(widget.question),
                  ],
                ),
                Container(
                  child: Text(
                    widget.answer,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
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

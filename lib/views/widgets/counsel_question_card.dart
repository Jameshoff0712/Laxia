import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                          fontSize: 14,
                          
                          fontWeight: FontWeight.w700,
                          color: Helper.mainColor),
                    ),
                    Text(
                      widget.question,
                      style: TextStyle(
                          fontSize: 14,
                          
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 51, 51, 51)),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Container(
                  child: Text(
                    widget.answer,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.8,
                        color: Helper.maintxtColor,
                        fontWeight: FontWeight.w400),
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

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextButton_Drawer extends StatefulWidget {
  final double width;
  final String textname;
  final VoidCallback onpress;
  final double? horizontal;
  const TextButton_Drawer(
      {Key? key,
      required this.onpress,
      required this.textname,
      required this.width,
      this.horizontal = 10})
      : super(key: key);

  @override
  State<TextButton_Drawer> createState() => _TextButton_DrawerState();
}

class _TextButton_DrawerState extends State<TextButton_Drawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 36,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.horizontal!),
        child: TextButton(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.textname,
                  style: TextStyle(
                      color: Helper.unSelectSmallTabColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
                SizedBox(
                  width: 8.41,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/icons/arrowdown.svg",
                    fit: BoxFit.cover,
                    width: 7.2,
                    height: 4.7,
                    color: Helper.maintxtColor,
                  ),
                ),
              ]),
          onPressed: widget.onpress,
        ),
      ),
    );
  }
}

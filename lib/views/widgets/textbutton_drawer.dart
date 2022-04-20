import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class TextButton_Drawer extends StatefulWidget {
  final double width;
  final String textname;
  final VoidCallback onpress;
  const TextButton_Drawer(
      {Key? key,
      required this.onpress,
      required this.textname,
      required this.width})
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
              Icon(
                Icons.arrow_drop_down,
                size: 24,
                color: Helper.unSelectSmallTabColor,
              ),
            ]),
        onPressed: widget.onpress,
      ),
    );
  }
}

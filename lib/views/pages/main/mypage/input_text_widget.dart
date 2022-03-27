import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class InputTextWidget extends StatefulWidget {
  String labelName = '';
  String placeHolder = '';
  String maxLegnth = '';

  InputTextWidget(
      {required this.labelName,
      required this.placeHolder,
      required this.maxLegnth});
  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  late String _enteredText = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.labelName,
              style: TextStyle(color: Helper.appTxtColor),
            ),
            Text(
              "${_enteredText.length}/${widget.maxLegnth}",
              style: TextStyle(color: Helper.darkGrey),
            )
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          onChanged: (value) {
            setState(() {
              _enteredText = value;
            });
          },
          decoration: InputDecoration(
            hintText: widget.placeHolder,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Helper.darkGrey, width: 2.0)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Helper.darkGrey, width: 2.0)),
          ),
        ),
      ],
    );
  }
}

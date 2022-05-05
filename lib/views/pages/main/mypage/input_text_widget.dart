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
        Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelName,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.5,
                  color: Color.fromARGB(255, 18, 18, 18),
                ),
              ),
              if (widget.maxLegnth != '')
                Text(
                  "${_enteredText.length}/${widget.maxLegnth}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.5,
                    color: Helper.maintxtColor,
                  ),
                )
            ],
          ),
        ),
        TextFormField(
          onChanged: (value) {
            setState(() {
              _enteredText = value;
            });
          },
          validator: (v) {
            if (v!.isEmpty) return '入力してください';
            // final regex = RegExp('^[1-9]+[0-9]*');
            // if (!regex.hasMatch(v)) return 'Enter a valid point value';
            return null;
          },
          maxLength: int.parse(widget.maxLegnth),
          decoration: InputDecoration(
            hintText: widget.placeHolder,
            counterText: "",
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.5,
                color: Helper.txtColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 240, 242, 245), width: 2.0)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 240, 242, 245), width: 2.0)),
          ),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              color: Color.fromARGB(255, 18, 18, 18)
          ),
        ),
      ],
    );
  }
}

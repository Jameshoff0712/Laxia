import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class inputTextWidget extends StatefulWidget {
  String labelName = '';
  String placeHolder = '';
  String maxLegnth = '';

  inputTextWidget(
      {required this.labelName,
      required this.placeHolder,
      required this.maxLegnth});
  @override
  State<inputTextWidget> createState() => _inputTextWidgetState();
}

class _inputTextWidgetState extends State<inputTextWidget> {
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
          padding: EdgeInsets.only(top: 24, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelName,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.5,
                  color: Helper.mainColor,
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
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            hintText: widget.placeHolder,
            counterText: "",
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.5,
                color: Color.fromARGB(255, 169, 169, 169)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 200, 199, 204), width: 2.0)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 200, 199, 204), width: 2.0)),
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

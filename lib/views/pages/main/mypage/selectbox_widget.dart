import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class SelectBoxWidget extends StatefulWidget {
  String name = '';
  List<String> items = [];
  String? chosenValue;
  SelectBoxWidget(
      {required this.name, required this.items, required this.chosenValue});
  @override
  State<SelectBoxWidget> createState() => _SelectBoxWidgetState();
}

class _SelectBoxWidgetState extends State<SelectBoxWidget> {
  String _chosenValue = '';
  @override
  void initState() {
    super.initState();
    _chosenValue = widget.chosenValue!;
    setState(() {
      _chosenValue = widget.chosenValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              
              color: Color.fromARGB(255, 18, 18, 18),
            ),
          ),
          DropdownButtonFormField<String>(
              items: widget.items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            
                            color: Color.fromARGB(255, 18, 18, 18),
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  _chosenValue = value!;
                });
              },
              validator: (v) {
                if (v!.isEmpty) return '選んでください';
                return null;
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Helper.titleColor,
              ),
              decoration: InputDecoration(
                // filled: true,
                // fillColor: Helper.whiteColor.withOpacity(0.2),
                // contentPadding: EdgeInsets.symmetric(vertical: 12),
                // counterText: "",
                // hintStyle: TextStyle(
                //     fontWeight: FontWeight.w400,
                //     fontSize: 14,
                    
                //     color: Helper.txtColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      // color: Colors.black,
                        color: Helper.authHintColor,
                        width: 1.0)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      // color: Colors.black,
                        color: Helper.authHintColor,
                        width: 1.0)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      // color: Colors.black,
                        color: Helper.authHintColor,
                        width: 1.0)),
              ),
            ),
        ],
      ),
    );
  }
}

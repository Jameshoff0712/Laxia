import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class selectBoxWidget extends StatefulWidget {
  String name = '';
  List<String> items = [];
  String? chosenValue;
  selectBoxWidget(
      {required this.name, required this.items, required this.chosenValue});
  @override
  State<selectBoxWidget> createState() => _selectBoxWidgetState();
}

class _selectBoxWidgetState extends State<selectBoxWidget> {
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
          Container(
            padding: EdgeInsets.only(top: 24, bottom: 12),
            child: Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                
                color: Helper.mainColor,
              ),
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
                size: 35,
              )),
        ],
      ),
    );
  }
}

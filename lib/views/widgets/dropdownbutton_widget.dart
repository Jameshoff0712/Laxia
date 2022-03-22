import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Dropdownbutton extends StatefulWidget {
  final List<String> items;
  final double horizontal;
  final String hintText;
  const Dropdownbutton(
      {Key? key,
      required this.items,
      required this.horizontal,
      required this.hintText})
      : super(key: key);

  @override
  State<Dropdownbutton> createState() => _DropdownbuttonState();
}

class _DropdownbuttonState extends State<Dropdownbutton> {
  final Color unselectedColor = Color.fromARGB(255, 102, 110, 110);
  final Color selectedColor = Color.fromARGB(255, 110, 198, 210);

  String? selectedValue;
  String? mid;
  bool drop = true;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        selectedItemHighlightColor:Color.fromARGB(255,110, 198, 210),
        buttonPadding: EdgeInsets.symmetric(horizontal: widget.horizontal, vertical: 9),
        enableFeedback: true,
        onTap: () {
          setState(() {
            drop = !drop;
          });
        },
        onMenuClose: () {
          setState(() {
            drop = !drop;
          });
        },
        hint: drop
            ? Text(
                widget.hintText,
                style: TextStyle(
                  fontSize: 14,
                  color: unselectedColor,
                ),
              )
            : Text(
                widget.hintText,
                style: TextStyle(fontSize: 14, color: selectedColor),
              ),
        icon: drop
            ? Icon(
                Icons.arrow_drop_down,
                color: unselectedColor,
              )
            : Icon(
                Icons.arrow_drop_up,
                color: selectedColor,
              ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      color: Color.fromARGB(255,51, 51, 51),
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        isExpanded: true,
        value: mid,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        buttonHeight: 36,
        itemHeight: 48,
        itemPadding: EdgeInsets.fromLTRB(16, 15, 2, 12),
        dropdownWidth: MediaQuery.of(context).size.width,
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight:Radius.circular(10)),
            color: Colors.white,
          ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/generated/l10n.dart';

class SearchbarWidget extends StatefulWidget {
  final bool state;
  final String searchtext;
  final TextEditingController filter;
  const SearchbarWidget(
      {Key? key, 
      required this.searchtext, 
      required this.state,
      required this.filter})
      : super(key: key);

  @override
  State<SearchbarWidget> createState() => _SearchbarWidgetState();
}

class _SearchbarWidgetState extends State<SearchbarWidget> {
  final _hintColor = Color.fromARGB(255, 156, 161, 161);
  final _whiteColor = Colors.white;

  String hinttext="";
  @override
  void dispose(){
    widget.filter.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: (){
        if(widget.state){
          //navigator
        }
      },
      controller: widget.filter,
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Color.fromARGB(255, 245, 245, 245),
        filled: true,
        prefixIcon: Icon(
          Icons.search,
          color: _hintColor,
          size: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        hintText:'施術名やクリニック名で検索',
        hintStyle: TextStyle(
          color: _hintColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class SearchbarWidget extends StatefulWidget {
  final bool state;
  final VoidCallback? onchange,oncompleted;
  final TextEditingController filter;
  const SearchbarWidget(
      {Key? key, 
      required this.state,
      required this.filter, this.onchange, this.oncompleted})
      : super(key: key);

  @override
  State<SearchbarWidget> createState() => _SearchbarWidgetState();
}

class _SearchbarWidgetState extends State<SearchbarWidget> {
  String hinttext="";
  @override
  void dispose(){
    widget.filter.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus:false,
      onTap: (){
        if(widget.state){
          Navigator.of(context).pushNamed("/SearchView");     
        }
      },
      onChanged: (value){
        if(widget.state==false){
          widget.onchange!();
        }
      },
      onEditingComplete: (){
        if(widget.state==false){
          widget.oncompleted!();
        }
      },
      controller: widget.filter,
      //Display the keyboard when TextField is displayed
      cursorColor: Helper.whiteColor,
      style: TextStyle(
        color: Helper.blackColor,
        fontSize: 14,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Color.fromARGB(255, 245, 245, 245),
        filled: true,
        prefixIcon: Icon(
          Icons.search,
          color: Helper.searchBartxtColor,
          size: 16,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Helper.whiteColor),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Helper.whiteColor),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        hintText:'施術名やクリニック名で検索',
        hintStyle: TextStyle(
          color: Helper.searchBartxtColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
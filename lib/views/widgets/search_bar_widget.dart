import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';

class SearchbarWidget extends StatefulWidget {
  final String? hinttext;
  final bool state;
  final bool? issuffixicon;
  final VoidCallback? onchange, oncompleted, onpress;
  final TextEditingController filter;
  const SearchbarWidget(
      {Key? key,
      required this.state,
      required this.filter,
      this.onchange,
      this.oncompleted,
      this.issuffixicon = false,
      this.onpress,
      this.hinttext = "施術名やクリニック名で検索"})
      : super(key: key);

  @override
  State<SearchbarWidget> createState() => _SearchbarWidgetState();
}

class _SearchbarWidgetState extends State<SearchbarWidget> {
  String hinttext = "";
  @override
  void dispose() {
    widget.filter.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Helper.mainColor,
      readOnly: widget.state ? true : false,
      autofocus: false,
      onTap: () {
        FocusScope.of(context).unfocus();
        if (widget.state) {
          Navigator.of(context).pushNamed("/SearchView");
        }
      },
      onChanged: (value) {
        if (widget.state == false) {
          widget.onchange!();
        }
      },
      onEditingComplete: () {
        if (widget.state == false) {
          widget.oncompleted!();
        }
      },
      controller: widget.filter,
      //Display the keyboard when TextField is displayed
      style: TextStyle(
        color: Helper.blackColor,
        fontSize: 14,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        suffixIcon: widget.issuffixicon!
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    widget.onpress!();
                  },
                  child: Container(
                    width: 13,
                    height: 13,
                    child: SvgPicture.asset(
                      "assets/icons/close.svg",
                      width: 3,
                      height: 3,
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: 0,
              ),
        fillColor: Helper.searchBarBgColor,
        filled: true,
        prefixIconConstraints: BoxConstraints(maxHeight: 30),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 11),
          child: Icon(
            Icons.search,
            color: Helper.searchBartxtColor,
            size: 23,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: Helper.whiteColor),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: Helper.whiteColor),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        isDense: true,
        contentPadding: EdgeInsets.only(left: 12, top: 9, bottom: 6),
        hintText: widget.hinttext!,
        hintStyle: TextStyle(
          color: Helper.searchBartxtColor,
          fontSize: 14,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}

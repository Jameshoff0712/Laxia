import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';

class SearchbarWidget extends StatefulWidget {
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
      this.onpress})
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
      autofocus: false,
      onTap: () {
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
      cursorColor: Helper.whiteColor,
      style: TextStyle(
        color: Helper.blackColor,
        fontSize: 14,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        suffixIcon: widget.issuffixicon!
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    widget.onpress!();
                  },
                  child: Container(
                    width:10,
                    height:10,
                    child: SvgPicture.asset(
                      "assets/icons/close.svg",
                      width: 5,
                      height: 5,
                    ),
                  ),
                ),
            )
            : SizedBox(
                width: 0,
              ),
        fillColor: Helper.searchBarBgColor,
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
        hintText: '施術名やクリニック名で検索',
        hintStyle: TextStyle(
          color: Helper.searchBartxtColor,
          fontSize: 14,
        ),
      ),
    );
  }
}

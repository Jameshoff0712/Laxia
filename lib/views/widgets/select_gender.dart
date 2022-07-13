import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';

class SelectGender extends StatefulWidget {
  final TextEditingController controller;
  const SelectGender({ Key? key, required this.controller }) : super(key: key);

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  int genderId = -1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 246.5,
        padding: EdgeInsets.only(top: 10),
        // color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Helper.whiteColor,
            shadowColor: Helper.whiteColor,
            title: Text(
              '性別を選択',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Helper.titleColor,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              splashColor: Colors.transparent,
                highlightColor: Colors.transparent,  
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Helper.titleColor,
                  size: 30,
                )),
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(53, 30, 53, 30),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      genderId = 0;
                      widget.controller.text = '女性';
                    });
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: EdgeInsets.symmetric(vertical: 23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: genderId == 0 ? Color.fromARGB(255, 251, 215, 215) : Color.fromARGB(255, 240, 242, 245),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                            "assets/icons/female.svg",
                        ),
                        SizedBox(height: 10),
                        Text(
                          '女性',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Helper.titleColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      genderId = 1;
                      widget.controller.text = '男性';
                    });
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: EdgeInsets.symmetric(vertical: 23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: genderId == 1 ? Color.fromARGB(255, 215, 238, 251) : Color.fromARGB(255, 240, 242, 245),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                            "assets/icons/male.svg",
                        ),
                        SizedBox(height: 12.5),
                        Text(
                          '男性',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Helper.titleColor,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';


class Menu_Sub_Detail_Three extends StatefulWidget {
  final dynamic detailList;
  const Menu_Sub_Detail_Three({ Key? key, required this.detailList }) : super(key: key);

  @override
  State<Menu_Sub_Detail_Three> createState() => _Menu_Sub_Detail_ThreeState();
}

class _Menu_Sub_Detail_ThreeState extends State<Menu_Sub_Detail_Three> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-70,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: Container(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "施術の保証",
                  style: defaultTextStyle(
                      Helper.titleColor, FontWeight.w700,
                      size: 18),
                ),
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.close,size: 20,))
            ]),
            Text(
                  widget.detailList,
                  style: TextStyle(color:Helper.titleColor, fontWeight:FontWeight.w400,fontSize: 14, height: 2.1),
                ),
           Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 219,
                        height: 44,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Helper.mainColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "閉じる",
                                  style: defaultTextStyle(
                                      Helper.whiteColor, FontWeight.w700,
                                      size: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 40,)
          ],),
        ),
      ),
    );
  }
}
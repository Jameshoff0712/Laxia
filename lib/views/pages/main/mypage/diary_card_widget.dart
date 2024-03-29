import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_user.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail_default.dart';
import 'package:laxia/views/pages/main/mypage/diary_fix_page.dart';

class DiaryCardWidget extends StatefulWidget {
  final bool isMe;
  const DiaryCardWidget({Key? key, required this.isMe}) : super(key: key);
  @override
  State<DiaryCardWidget> createState() => _DiaryCardWidgetState();
}

class _DiaryCardWidgetState extends State<DiaryCardWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Diary_Detail(
                      isMyDiary: true, index: 1,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Card(
          // borderOnForeground: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(
                          "${currentUser.imageUrl}",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                "Yuka111",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  
                                  color: Helper.titleColor,
                                ),
                              )),
                        ),
                        widget.isMe
                            ? GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  color: Color.fromARGB(51, 240, 154, 55),
                                  child: Text(
                                    "未公開",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 249, 161, 56),
                                    ),
                                  ),
                                ))
                            : Container(),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 70) / 2,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/user/eyebefore.jpg',
                                ),
                              )),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.zero,
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.zero),
                              color: Color.fromARGB(128, 0, 0, 0).withOpacity(0.8),
                            ),
                            alignment: AlignmentDirectional.bottomStart,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Before",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    
                                    color: Helper.whiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 70) / 2,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/user/eyeafter.jpg',
                                ),
                              )),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.zero,
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.zero),
                              color: Color.fromARGB(128, 0, 0, 0).withOpacity(0.8),
                            ),
                            alignment: AlignmentDirectional.bottomStart,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "After",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    
                                    color: Helper.whiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "2日目、起床直後の様子です。腫れは昨日とくくら腫れは昨日とくくら...",
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.3,
                      color: Helper.titleColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    _buildInfoTile(
                        Text(
                          "二重切開",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            
                            color: Helper.maintxtColor,
                          ),
                        ),
                        FaIcon(FontAwesomeIcons.tags,
                            color: Helper.maintxtColor, size: 10)),
                    SizedBox(
                      height: 10,
                    ),
                    _buildInfoTile(
                        Text(
                          "ラシア美容クリニック　DEF院",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            
                            color: Helper.maintxtColor,
                          ),
                        ),
                        FaIcon(FontAwesomeIcons.hospital,
                            color: Helper.maintxtColor, size: 10)),
                    SizedBox(
                      height: 10,
                    ),
                    _buildInfoTile(
                        Text(
                          "田中圭 医師",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            
                            color: Helper.maintxtColor,
                          ),
                        ),
                        FaIcon(FontAwesomeIcons.userNurse,
                            color: Helper.maintxtColor, size: 10)),
                    SizedBox(
                      height: 10,
                    ),
                    _buildInfoTile(
                        Text(
                          "2万8000円",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            
                            color: Helper.maintxtColor,
                          ),
                        ),
                        FaIcon(FontAwesomeIcons.moneyBill,
                            color: Helper.maintxtColor, size: 10)),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.remove_red_eye_sharp,
                      color: Helper.maintxtColor,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "11",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        
                        color: Helper.maintxtColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FaIcon(
                      FontAwesomeIcons.heart,
                      color: Helper.maintxtColor,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "88",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        
                        color: Helper.maintxtColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FaIcon(
                      FontAwesomeIcons.comment,
                      color: Helper.maintxtColor,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "4",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        
                        color: Helper.maintxtColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoTile(Text label, FaIcon icon) {
  return GestureDetector(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: icon,
          width: 12,
          height: 12,
        ),
        SizedBox(
          width: 9,
        ),
        label,
      ],
    ),
    onTap: () {},
  );
}

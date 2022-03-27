import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/m_user.dart';

class DiaryCardWidget extends StatefulWidget {
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
    return Card(
      // borderOnForeground: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
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
                  width: 9,
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
                            style: defaultTextStyle(
                                Helper.appTxtColor, FontWeight.w700,
                                size: 14),
                          )),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          color: Helper.lightGrey,
                          child: Text(
                            "未公開",
                            style: defaultTextStyle(
                                Helper.darkGrey, FontWeight.w100,
                                size: 10),
                          ),
                        )),
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
                  width: (MediaQuery.of(context).size.width - 60) / 2,
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
                        padding: EdgeInsets.all(2.0),
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.zero,
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.zero),
                            color: Colors.black45),
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          "Before",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width - 60) / 2,
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
                        padding: EdgeInsets.all(2.0),
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.zero,
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.zero),
                            color: Colors.black45),
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          "After",
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
              child: Text("2日目、起床直後の様子です。腫れは昨日とくくら腫れは昨日とくくら...",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                  maxLines: 1),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                _buildInfoTile(
                    Text(
                      "二重切開",
                      style: TextStyle(color: Helper.darkGrey),
                    ),
                    FaIcon(FontAwesomeIcons.tags,
                        color: Helper.darkGrey, size: 16)),
                SizedBox(
                  height: 10,
                ),
                _buildInfoTile(
                    Text(
                      "ラシア美容クリニック　DEF院",
                      style: TextStyle(color: Helper.darkGrey),
                    ),
                    FaIcon(FontAwesomeIcons.hospital,
                        color: Helper.darkGrey, size: 16)),
                SizedBox(
                  height: 10,
                ),
                _buildInfoTile(
                    Text(
                      "田中圭 医師",
                      style: TextStyle(color: Helper.darkGrey),
                    ),
                    FaIcon(FontAwesomeIcons.userNurse,
                        color: Helper.darkGrey, size: 16)),
                SizedBox(
                  height: 10,
                ),
                _buildInfoTile(
                    Text(
                      "2万8000円",
                      style: TextStyle(color: Helper.darkGrey),
                    ),
                    FaIcon(FontAwesomeIcons.moneyBill,
                        color: Helper.darkGrey, size: 16)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.remove_red_eye_sharp,
                  color: Helper.darkGrey,
                  size: 16,
                ),
                Text(
                  "11",
                  style: TextStyle(color: Helper.darkGrey),
                ),
                SizedBox(
                  width: 20,
                ),
                FaIcon(
                  FontAwesomeIcons.heart,
                  color: Helper.darkGrey,
                  size: 16,
                ),
                Text(
                  "88",
                  style: TextStyle(color: Helper.darkGrey),
                ),
                SizedBox(
                  width: 20,
                ),
                FaIcon(
                  FontAwesomeIcons.comment,
                  color: Helper.darkGrey,
                  size: 16,
                ),
                Text(
                  "4",
                  style: TextStyle(color: Helper.darkGrey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoTile(Text label, FaIcon icon) {
  return InkWell(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: icon,
          width: 16,
          height: 16,
        ),
        SizedBox(
          width: 15,
        ),
        label,
      ],
    ),
    onTap: () {},
  );
}

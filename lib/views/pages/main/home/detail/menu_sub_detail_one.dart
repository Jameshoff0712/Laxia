import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class Menu_Sub_Detail_One extends StatefulWidget {
  final List detailList;
  const Menu_Sub_Detail_One({Key? key, required this.detailList})
      : super(key: key);

  @override
  State<Menu_Sub_Detail_One> createState() => _Menu_Sub_Detail_OneState();
}

class _Menu_Sub_Detail_OneState extends State<Menu_Sub_Detail_One> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 70,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "施術の詳細",
                  style: defaultTextStyle(Helper.titleColor, FontWeight.w700,
                      size: 18),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 20,
                    ))
              ]),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                    dataRowHeight: 38,
                    horizontalMargin: 0,
                    dataTextStyle: TextStyle(),
                    showBottomBorder: true,
                    showCheckboxColumn: false,
                    columnSpacing: 0,
                    columns: [
                      DataColumn(
                          label: Text('施術時間',
                              style: TextStyle(
                                  fontFamily: Helper.headFontFamily,
                                  fontSize: 14,
                                  color: Helper.titleColor,
                                  fontWeight: FontWeight.w700))),
                      DataColumn(
                          label: Text(widget.detailList[0],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Helper.maintxtColor,
                                  fontWeight: FontWeight.w400))),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(
                          Text('抜糸',
                              style: TextStyle(
                                  fontFamily: Helper.headFontFamily,
                                  fontSize: 14,
                                  color: Helper.titleColor,
                                  fontWeight: FontWeight.w700)),
                        ),
                        DataCell(Text(widget.detailList[1],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('施術後の通院',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(widget.detailList[2],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('腫れ',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(widget.detailList[3],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text('痛み',
                              style: TextStyle(
                                  fontFamily: Helper.headFontFamily,
                                  fontSize: 14,
                                  color: Helper.titleColor,
                                  fontWeight: FontWeight.w700)),
                        ),
                        DataCell(Text(widget.detailList[4],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('内出血',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(widget.detailList[5],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('入院の必要性',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(widget.detailList[6],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text('麻酔',
                              style: TextStyle(
                                  fontFamily: Helper.headFontFamily,
                                  fontSize: 14,
                                  color: Helper.titleColor,
                                  fontWeight: FontWeight.w700)),
                        ),
                        DataCell(Text(widget.detailList[7],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('メイク/洗顔',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(widget.detailList[8],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('シャワー/洗髪/入浴',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(widget.detailList[9],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('強いマッサージ',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(widget.detailList[10],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('激しいスポーツ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(widget.detailList[11],
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400))),
                      ])
                    ]),
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
                        child: InkWell(
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
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

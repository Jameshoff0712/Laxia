import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';

class Menu_Sub_Detail_One extends StatefulWidget {
  final Menu_Sub_Model menu;
  const Menu_Sub_Detail_One({Key? key, required this.menu})
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
                    ),
                    splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
                    )
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
                          label: Text(Helper.TreatTime(widget.menu.treat_time!),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Helper.titleColor,
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
                        DataCell(Text(Helper.Basshi(widget.menu.basshi!),
                            style: TextStyle(
                                fontSize: 14,
                              color: Helper.titleColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('施術後の通院',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(Helper.HospitalVisit(widget.menu.hospital_visit!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('腫れ',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(Helper.Hare(widget.menu.hare!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
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
                        DataCell(Text(Helper.Pain(widget.menu.pain!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('内出血',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(Helper.Bleeding(widget.menu.bleeding!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('入院の必要性',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(Helper.HospitalNeed(widget.menu.hospital_need!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
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
                        DataCell(Text(Helper.Masui(widget.menu.masui!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('メイク/洗顔',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(Helper.Makeup(widget.menu.makeup!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('シャワー/洗髪/入浴',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(Helper.Shower(widget.menu.shower!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('強いマッサージ',
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(Helper.Massage(widget.menu.massage!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('激しいスポーツ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700))),
                        DataCell(Text(Helper.SportImpossible(widget.menu.sport_impossible!),
                            style: TextStyle(
                                fontSize: 14,
                               color: Helper.titleColor,
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

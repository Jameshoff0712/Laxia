import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/search_provider.dart';
import 'package:laxia/views/widgets/select_age.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class NarrowDownn extends StatefulWidget {
  final bool isStar;
  const NarrowDownn({Key? key, required this.isStar}) : super(key: key);

  @override
  State<NarrowDownn> createState() => _NarrowDownnState();
}

class _NarrowDownnState extends State<NarrowDownn> {
  SfRangeValues _currentRangeValues = SfRangeValues(0, 100);
  List<int> selectstar = [
    6,
    6,
    6,
    6,
    6,
  ];
  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 25,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text("絞り込み",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 28,
                        )),
                    GestureDetector(
                      onTap: () {},
                      child: Text("クリア",
                          style: TextStyle(
                              color: Helper.mainColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            widget.isStar
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("施術の満足度",
                          style: TextStyle(
                              fontFamily: Helper.headFontFamily,
                              color: Helper.titleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int i = 0; i < 5; i++)
                            Star(
                                i,
                                selectstar[i] == i+1
                                    ? Helper.starColor
                                    : Helper.blackColor,()=>{
                                      if(selectstar[i]==6){
                                        setState(() {
                                          selectstar[i]= i+1;
                                        })
                                      }else {
                                        setState(() {
                                          selectstar[i]= 6;
                                        })
                                      }
                                    }),
                        ],
                      ),
                    ],
                  )
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(
              height: 26,
            ),
            Text("価格帯",
                style: TextStyle(
                    fontFamily: Helper.headFontFamily,
                    color: Helper.titleColor,
                    fontSize: 16,
                    
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                    _currentRangeValues.start.round() == 0
                        ? "下限なし"
                        : (_currentRangeValues.start.round() * 4).toString() +
                            "万円以上",
                    style: TextStyle(
                        color: Helper.titleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  width: 8,
                ),
                
                Text("-",
                    style: TextStyle(
                        color: Helper.titleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  width: 8,
                ),
                Text(
                    _currentRangeValues.end.round() == 100
                        ? "上限なし"
                        : (_currentRangeValues.end.round() * 4).toString() +
                            "万円以下",
                    style: TextStyle(
                        color: Helper.titleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                  child: SfRangeSliderTheme(
                data: SfRangeSliderThemeData(
                  activeTrackHeight: 4,
                  activeTrackColor: Helper.mainColor,
                  inactiveTrackColor: Color.fromARGB(255, 155, 155, 155),
                  thumbColor: Colors.white,
                ),
                child: SfRangeSlider(
                  values: _currentRangeValues,
                  min: 0,
                  max: 100,
                  onChanged: (SfRangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
              )),
            ),
            SizedBox(
              height: 14,
            ),
            Text("年代",
                style: TextStyle(
                    fontFamily: Helper.headFontFamily,
                    
                    color: Helper.titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 35,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("年代",
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 18, 18),
                              fontSize: 16,
                              
                              fontWeight: FontWeight.w400)),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("指定しない",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 156, 161, 161),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                ),
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) {
                                  return SelectAge();
                                },
                                isScrollControlled: true,
                              );
                            },
                            child: Icon(
                              Icons.navigate_next,
                              color: Color.fromARGB(255, 156, 161, 161),
                              size: 25,
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 222, 222)),
                    child: SizedBox(
                      height: 2,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  searchProvider.setminprice(_currentRangeValues.start.round());
                  searchProvider.setmaxprice(_currentRangeValues.end.round());
                  searchProvider.setMark(selectstar);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Helper.btnBgMainColor),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 114, vertical: 12),
                    child: Text(
                      "結果を表示",
                      style: TextStyle(
                          fontFamily: Helper.headFontFamily,
                          color: Helper.whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            )
          ]),
        ),
      ),
    );
  }

  Widget Star(
    int index,
    Color color,
    VoidCallback onpress
  ) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 245, 245, 245)),
        width: 60,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              (index + 1).toString(),
              style: TextStyle(
                  color: Helper.unstarColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 4,
            ),
            Icon(
              Icons.star,
              color: color,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

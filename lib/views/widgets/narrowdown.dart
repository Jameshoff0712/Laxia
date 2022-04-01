import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class NarrowDownn extends StatefulWidget {
  final bool isStar;
  const NarrowDownn({Key? key, required this.isStar}) : super(key: key);

  @override
  State<NarrowDownn> createState() => _NarrowDownnState();
}

class _NarrowDownnState extends State<NarrowDownn> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  List<bool> selectstar = [
    false,
    false,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 56,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 15,
                  )),
              Text("絞り込み",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              InkWell(
                onTap: () {},
                child: Text("クリア",
                    style: TextStyle(
                        color: Helper.maintxtColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              )
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
                            color: Helper.titleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Star(
                              i,
                              selectstar[i] == true
                                  ? Helper.starColor
                                  : Helper.blackColor),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                width: 8,
              ),
              Text("-",
                  style: TextStyle(
                      color: Helper.titleColor,
                      fontSize: 16,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
                child: RangeSlider(
              activeColor: Helper.mainColor,
              values: _currentRangeValues,
              min: 0,
              max: 100,
              divisions: 100,
              // labels: RangeLabels(
              //   _currentRangeValues.start.round().toString(),
              //   _currentRangeValues.end.round().toString(),
              // ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            )),
          ),
          SizedBox(
            height: 32,
          ),
          Text("年代",
              style: TextStyle(
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
                      children: [
                        Text("指定しない",
                            style: TextStyle(
                                color: Color.fromARGB(255, 156, 161, 161),
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                        Icon(
                          Icons.navigate_next,
                          color: Color.fromARGB(255, 156, 161, 161),
                          size: 18,
                        ),
                      ],
                    ))
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  decoration:
                      BoxDecoration(color: Helper.maintxtColor),
                  child: SizedBox(
                    height: 2,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Helper.btnBgMainColor),
                width: 300,
                height: 45,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 114, vertical: 12),
                  child: Text(
                    "結果を表示",
                    style: TextStyle(
                        color: Helper.whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 33,
          )
        ]),
      ),
    );
  }

  Widget Star(
    int index,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          selectstar[index] = !selectstar[index];
        });
      },
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

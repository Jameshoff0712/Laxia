import 'package:flutter/material.dart';

class NarrowDownn extends StatefulWidget {
  final bool isStar;
  const NarrowDownn({Key? key, required this.isStar}) : super(key: key);

  @override
  State<NarrowDownn> createState() => _NarrowDownnState();
}

class _NarrowDownnState extends State<NarrowDownn> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  int selectstar = 0;
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
                        color: Color.fromARGB(255, 102, 110, 110),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),
          widget.isStar?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("施術の満足度",
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < 5; i++)
                    Star(
                        i,
                        selectstar > i
                            ? Colors.yellow
                            : Color.fromARGB(255, 0, 0, 0)),
                ],
              ),
            ],
          ):SizedBox(height: 0,),
          SizedBox(
            height: 26,
          ),
          Text("価格帯",
              style: TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text("下限なし",
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                width: 8,
              ),
              Text("-",
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                width: 8,
              ),
              Text("上限なし",
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
                child: RangeSlider(
              activeColor: Color.fromARGB(255, 110, 198, 210),
              values: _currentRangeValues,
              min: 0,
              max: 100,
              divisions: 10,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
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
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          Expanded(
            child: Row(
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
          ),
          Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 110, 198, 210)),
                width: 300,
                height: 45,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 114, vertical: 12),
                  child: Text(
                    "結果を表示",
                    style: TextStyle(
                        color: Colors.white,
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

  Widget Star(int index, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          selectstar = index + 1;
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
                  color: Colors.black,
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

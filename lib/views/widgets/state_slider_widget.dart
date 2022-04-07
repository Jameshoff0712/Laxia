import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class StateSliderWidget extends StatefulWidget {
  final String state_str;
  final int state_val;
  final bool? bBorder;
  const StateSliderWidget(
      {Key? key,
      required this.state_str,
      required this.state_val,
      this.bBorder = false})
      : super(key: key);

  @override
  State<StateSliderWidget> createState() => _StateSliderWidgetState();
}

class _StateSliderWidgetState extends State<StateSliderWidget> {
  bool isBorder = false;
  List<double> stateval = [];
  @override
  void initState() {
    super.initState();

    setState(() {
      isBorder = widget.bBorder! ? true : false;

      if (widget.state_val == 0) {
        stateval.add(0);
      } else if (widget.state_val == 1) {
        stateval.add(33);
      } else if (widget.state_val == 2) {
        stateval.add(66);
      } else {
        stateval.add(100);
      }
      //print(stateval);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 0.0, top: 10, right: 0, bottom: 10),
      child: Container(
        padding: const EdgeInsets.only(right: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          border: isBorder
              ? Border(bottom: BorderSide(color: Colors.grey))
              : Border(
                  bottom: BorderSide.none,
                ),
        ),
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(widget.state_str)),
            Expanded(
              //height: 80,
              //padding: EdgeInsets.symmetric(horizontal: 10),
              child: FlutterSlider(
                jump: true,
                values: stateval,
                min: 0,
                max: 100,
                fixedValues: [
                  FlutterSliderFixedValue(percent: 0, value: ""),
                  FlutterSliderFixedValue(percent: 33, value: ""),
                  FlutterSliderFixedValue(percent: 66, value: ""),
                  FlutterSliderFixedValue(percent: 100, value: ""),
                ],
                // ignoreSteps: [
                //   FlutterSliderIgnoreSteps(from: 1, to: 32),
                //   FlutterSliderIgnoreSteps(from: 33, to: 65),
                //   FlutterSliderIgnoreSteps(from: 67, to: 99),
                // ],
                step: FlutterSliderStep(step: 33),
                handlerWidth: 25,
                hatchMark: FlutterSliderHatchMark(
                  linesDistanceFromTrackBar: -12,
                  labelsDistanceFromTrackBar: -50,
                  density: 0.15,
                  displayLines: true,
                  bigLine: FlutterSliderSizedBox(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20))),
                  smallLine: FlutterSliderSizedBox(height: 1, width: 1),
                  labels: [
                    FlutterSliderHatchMarkLabel(
                        percent: 0,
                        label: Text('なし', style: TextStyle(fontSize: 10))),
                    FlutterSliderHatchMarkLabel(
                        percent: 33,
                        label: Text('少しある', style: TextStyle(fontSize: 10))),
                    FlutterSliderHatchMarkLabel(
                        percent: 66,
                        label: Text('ある', style: TextStyle(fontSize: 10))),
                    FlutterSliderHatchMarkLabel(
                        percent: 100,
                        label: Text('かなりある', style: TextStyle(fontSize: 10))),
                  ],
                ),
                //rangeSlider: true,
                //visibleTouchArea: true,
                trackBar: FlutterSliderTrackBar(
                  inactiveTrackBarHeight: 5,
                  activeTrackBarHeight: 5,
                  activeTrackBarDraggable: true,
                  inactiveTrackBar: BoxDecoration(color: Colors.black12),
                  activeTrackBar: BoxDecoration(color: Colors.black12),
                ),
                handler: FlutterSliderHandler(
                  decoration: BoxDecoration(),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Helper.mainColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                selectByTap: true,
                onDragging: (handlerIndex, lowerValue, upperValue) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

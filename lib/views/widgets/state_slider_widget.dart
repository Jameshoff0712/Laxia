import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class StateSliderWidget extends StatefulWidget {
  final String state_str;
  final int state_val;
  final bool? bBorder;
  final bool? isenable;
  Function? onChanged;
  StateSliderWidget(
      {Key? key,
      required this.state_str,
      required this.state_val,
      this.bBorder = false, 
      this.isenable=true,
      this.onChanged})
      : super(key: key);

  @override
  State<StateSliderWidget> createState() => _StateSliderWidgetState();
}

class _StateSliderWidgetState extends State<StateSliderWidget> {
  bool isBorder = false;
  List<double> stateval = [];
  double _value = 0;
  @override
  void initState() {
    super.initState();

    setState(() {
      isBorder = widget.bBorder! ? true : false;
      if (widget.state_val == 0) {
        _value=0;
        stateval.add(0);
      } else if (widget.state_val == 1) {
        _value=1;
        stateval.add(33);
      } else if (widget.state_val == 2) {
        _value=2;
        stateval.add(66);
      } else {
        _value=3;
        stateval.add(100);
      }
      //print(stateval);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 74,
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.only(right: 25),
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
                width: 62,
                padding: EdgeInsets.only(top: 13, bottom: 10),
                child: Text(
                  widget.state_str,
                  style: TextStyle(
                    fontSize: 14,
                    
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 18, 18, 18),
                  ),
                )),
            Expanded(
                child: SfSliderTheme(
                    data: SfSliderThemeData(
                      activeDividerRadius: 5,
                      inactiveDividerRadius: 5,
                      activeTrackHeight: 2,
                      inactiveTrackHeight: 2,
                      activeDividerColor: Color.fromARGB(255, 225, 227, 227),
                      inactiveDividerColor: Color.fromARGB(255, 225, 227, 227),
                      activeTrackColor: Color.fromARGB(255, 225, 227, 227),
                      inactiveTrackColor: Color.fromARGB(255, 225, 227, 227),
                      thumbColor: Helper.mainColor,
                      labelOffset: Offset(0, -35),
                      activeLabelStyle: TextStyle(color: Helper.mainColor, fontSize: 12, fontWeight: FontWeight.w700, height: 1.5),
                      inactiveLabelStyle: TextStyle(color: Color.fromARGB(255, 18, 18, 18), fontSize: 12, fontWeight: FontWeight.w700, height: 1.5),
                    ),
                    child: SfSlider(
                      min: 0.0,
                      max: 3.0,
                      interval: 1,
                      stepSize: 1,
                      showDividers: true,
                      showLabels: true,
                      labelPlacement: LabelPlacement.onTicks,
                      labelFormatterCallback:
                          (dynamic actualValue, String formattedText) {
                        String strLabel;
                        if (actualValue == 0)
                          strLabel = "なし";
                        else if (actualValue == 1)
                          strLabel = "少しある";
                        else if (actualValue == 2)
                          strLabel = "ある";
                        else
                          strLabel = "かなりある";
                        return strLabel;
                      },
                      value: _value,
                      onChanged: (dynamic newValue) {
                        if(widget.isenable!)
                        {
                            setState(() {
                              _value = newValue;
                            });
                            widget.onChanged!(newValue);
                        }
                      },
                    ))),
          ],
        ),
      ),
    );
  }
}

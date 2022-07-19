import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class SelectAge extends StatefulWidget {
  const SelectAge({Key? key}) : super(key: key);

  @override
  State<SelectAge> createState() => _SelectAgeState();
}

class _SelectAgeState extends State<SelectAge> {
  List<bool> age_state_list = [false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 250,
          child: Column(
            children: [
              Container(
                height: 44,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: Helper.titleColor,
                          size: 30,
                        )),
                    Text(
                      '年代を絞る',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Helper.titleColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          for(int i = 0; i < 6; i++)
                            age_state_list[i] = false;
                        });
                      },
                      child: Text(
                        'クリア',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Helper.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 12,
                  children: [
                    for (int i = 0; i < 6; i++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            age_state_list[i] = !age_state_list[i];
                          });
                        },
                        child: Container(
                          width: 160,
                          height: 40,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: age_state_list[i] ? Helper.mainColor : Color.fromARGB(255, 240, 242, 245),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              ((i + 1) * 10).toString() + '代',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: age_state_list[i] ? Helper.whiteColor : Helper.titleColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

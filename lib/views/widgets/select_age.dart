import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SelectAge extends StatefulWidget {
  const SelectAge({Key? key}) : super(key: key);

  @override
  State<SelectAge> createState() => _SelectAgeState();
}

class _SelectAgeState extends State<SelectAge> {
  List<int> age_state_list = [0, 0, 0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);
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
                            age_state_list[i] = 0;
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
                            if(age_state_list[i]==0){
                              age_state_list[i]=i+1;
                            }else{
                              age_state_list[i]=0;
                            }
                          });
                          searchProvider.setYear(age_state_list);
                        },
                        child: Container(
                          width: 160,
                          height: 40,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: age_state_list[i]!=0 ? Helper.mainColor : Color.fromARGB(255, 240, 242, 245),
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              ((i + 1) * 10).toString() + '代',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: age_state_list[i]!=0 ? Helper.whiteColor : Helper.titleColor,
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

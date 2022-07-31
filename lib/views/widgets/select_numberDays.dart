import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SelectNumberDays extends StatefulWidget {
  const SelectNumberDays({Key? key}) : super(key: key);

  @override
  State<SelectNumberDays> createState() => _SelectNumberDaysState();
}

class _SelectNumberDaysState extends State<SelectNumberDays> {
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
                      '施術日からの経過日数',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Helper.titleColor,
                      ),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
              ),
              SizedBox(height: 12,),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 100,
                 physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ryu',
                          style: TextStyle(
                            color: Helper.titleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                }
              )
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              //   child: Wrap(
              //     spacing: 20,
              //     runSpacing: 12,
              //     children: [
              //       for (int i = 0; i < 6; i++)
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               if(age_state_list[i]==0){
              //                 age_state_list[i]=i+1;
              //               }else{
              //                 age_state_list[i]=0;
              //               }
              //             });
              //             searchProvider.setYear(age_state_list);
              //           },
              //           child: Container(
              //             width: 160,
              //             height: 40,
              //             padding: EdgeInsets.symmetric(vertical: 8),
              //             decoration: BoxDecoration(
              //               color: age_state_list[i]!=0 ? Helper.mainColor : Color.fromARGB(255, 240, 242, 245),
              //               borderRadius: BorderRadius.all(Radius.circular(3)),
              //             ),
              //             child: Align(
              //               alignment: Alignment.center,
              //               child: Text(
              //                 ((i + 1) * 10).toString() + '代',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.w300,
              //                   fontSize: 16,
              //                   color: age_state_list[i]!=0 ? Helper.whiteColor : Helper.titleColor,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
            ],
          )),
    );
  }
}

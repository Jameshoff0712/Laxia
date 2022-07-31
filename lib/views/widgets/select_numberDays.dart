import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/diary/diary/diarydetail_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SelectNumberDays extends StatefulWidget {
  final String diary_id;
  const SelectNumberDays({Key? key, required this.diary_id}) : super(key: key);

  @override
  State<SelectNumberDays> createState() => _SelectNumberDaysState();
}

class _SelectNumberDaysState extends State<SelectNumberDays> {
  bool isloading = true;
   HomeController _conHome = HomeController();
  late DiaryDetail_Model info;
  late DiaryDetail_Model mid;
  late String treat_date;
  late DateTime treat;
  Future<void> getData() async {
    mid = await _conHome.getDiaryDetail(index: int.parse(widget.diary_id));
    print(mid.diary.treat_date!);
    setState(() {
      info = mid;
      treat_date = mid.diary.treat_date!;
      treat = DateTime.parse(treat_date);
      isloading = false;
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    return SafeArea(
      child: Container(
        height: 300,
        padding: EdgeInsets.only(top: 10),
        // color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Helper.whiteColor,
            shadowColor: Helper.whiteColor,
            title: Text(
              '施術日からの経過日数',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Helper.titleColor,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              splashColor: Colors.transparent,
                highlightColor: Colors.transparent,  
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Helper.titleColor,
                  size: 30,
                )),
            elevation: 0,
          ),
          body: isloading
      ? Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          )
      :SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 12,),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 100,
                   physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        diaryProperties.setNumbersDate((index + 1).toString());
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateInfo(index),
                              style: TextStyle(
                                color: Helper.titleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                            Text( '術後 ' + (index + 1).toString() + '日目',
                              style: TextStyle(
                                color: Helper.titleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String DateInfo(int i) {
    DateTime date = treat.add(Duration(hours: 24 * (i + 1)));
    String date_number = formatDate(date, [yyyy, '/', mm, '/', dd]);
    String weekday = '';
    switch(date.weekday){
      case 1:
        weekday = '（月）';
        break;
      case 2:
        weekday = '（火）';
        break;
      case 3:
        weekday = '（水）';
        break;
      case 4:
        weekday = '（木）';
        break;
      case 5:
        weekday = '（金）';
        break;
      case 6:
        weekday = '（土）';
        break;
      case 7:
        weekday = '（日）';
        break;
    }
    return date_number + weekday;
  }
}

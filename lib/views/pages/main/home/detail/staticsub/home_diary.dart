import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Diary extends StatefulWidget {
  final List<Diary_Sub_Model> diaries;
  const Home_Diary({Key? key, required this.diaries,})
      : super(key: key);

  @override
  State<Home_Diary> createState() => _Home_DiaryState();
}

class _Home_DiaryState extends State<Home_Diary> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return Column(
                children: [
                  // menuAppBar(context),
                  Expanded(
                    child: LayoutBuilder(
                        builder: (context, BoxConstraints viewportConstraints) {
                      return ListView.builder(
                          padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                          itemCount: widget.diaries.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap:true,
                          itemBuilder: (BuildContext context, int index) {
                            return Diary_Card(
                              avator:
                                  widget.diaries[index].patient_photo == null
                                      ? "http://error.png"
                                      : widget.diaries[index].patient_photo!,
                              check: widget.diaries[index].doctor_name == null
                                  ? ""
                                  : widget.diaries[index].doctor_name!,
                              image2: widget.diaries[index].after_image == null
                                  ? "http://error.png"
                                  : widget.diaries[index].after_image!,
                              image1:
                                  widget.diaries[index].before_image == null
                                      ? "http://error.png"
                                      : widget.diaries[index].before_image!,
                              eyes: widget.diaries[index].views_count == null
                                  ? ""
                                  : widget.diaries[index].views_count!
                                      .toString(),
                              clinic: widget.diaries[index].clinic_name == null
                                  ? ""
                                  : widget.diaries[index].clinic_name!,
                              name: widget.diaries[index].patient_nickname ==
                                      null
                                  ? ""
                                  : widget.diaries[index].patient_nickname!,
                              onpress: () {
                                Navigator.of(context).push( MaterialPageRoute(builder: (_) => Diary_Detail(index:widget.diaries[index].id)));
                              },
                              price: widget.diaries[index].price == null
                                  ? ""
                                  : widget.diaries[index].price.toString(),
                              sentence:
                                  widget.diaries[index].doctor_name == null
                                      ? ""
                                      : widget.diaries[index].doctor_name!,
                              type: widget.diaries[index].doctor_name == null
                                  ? ""
                                  : widget.diaries[index].doctor_name!,
                            );
                          });
                    }),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

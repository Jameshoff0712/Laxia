import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/views/pages/main/contribution/counsel_detail.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Counseling extends StatefulWidget {
  final List<Counceling_Sub_Model> councelings;
  const Home_Counseling({Key? key, required this.councelings, })
      : super(key: key);

  @override
  State<Home_Counseling> createState() => _Home_CounselingState();
}

class _Home_CounselingState extends State<Home_Counseling> {
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
              return ListView.builder(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  itemCount: widget.councelings.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Counseling_Card(
                        hearts: widget.councelings[index].likes_count==null?"":widget.councelings[index].likes_count!.toString(),
                        chats: widget.councelings[index].comments_count==null?"":widget.councelings[index].comments_count.toString(),
                        avator:widget.councelings[index].patient_photo==null?"http://error.png": widget.councelings[index].patient_photo!,
                        check: widget.councelings[index].doctor_name==null?"":widget.councelings[index].doctor_name!,
                        images:widget.councelings[index].media_self!,
                        eyes: widget.councelings[index].views_count==null?"":widget.councelings[index].views_count!.toString(),
                        name: widget.councelings[index].patient_nickname==null?"":widget.councelings[index].patient_nickname!,
                         onpress: (){
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CounselDetail(index:  widget.councelings[index].id)));
                          },
                        sentence:widget.councelings[index].content==null?"": widget.councelings[index].content!,
                        type:widget.councelings[index].categories!,
                        clinic:widget.councelings[index].clinic_name==null?"": widget.councelings[index].clinic_name!,
                      );
                  });
            }),
          ),
        ],
      ),
    );
  }
}

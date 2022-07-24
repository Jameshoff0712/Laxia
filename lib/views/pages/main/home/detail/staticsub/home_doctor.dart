import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';


class Home_Doctor extends StatefulWidget {
  final List<Doctor_Sub_Model> doctors;
  const Home_Doctor({Key? key, required this.doctors}) : super(key: key);

  @override
  State<Home_Doctor> createState() => _Home_DoctorState();
}

class _Home_DoctorState extends State<Home_Doctor> {
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: LayoutBuilder(builder: (context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: widget.doctors.length,
                          physics:AlwaysScrollableScrollPhysics(),
                          shrinkWrap:true,
                          itemBuilder: (BuildContext context, int index) {
                            return Doctor_Card(
                                onpress: (){
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Doctor_Detail(index:  widget.doctors[index].id)));
                                  // Navigator.of(context).pushNamed("/Doctor_Detail");
                                },
                                image: widget.doctors[index].photo==null?"http://error.png": widget.doctors[index].photo!,
                                name: widget.doctors[index].hira_name,
                                mark:4.8.toString(), //widget.doctors[index]["mark"],
                                day:222.toString(), //widget.doctors[index]["day"],
                                clinic: "湘南美容クリニック 新宿院" //widget.doctors[index].clinic_id .toString()
                              );
                          }),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

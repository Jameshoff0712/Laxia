import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Favorite_Doctor extends StatefulWidget {
  const Favorite_Doctor({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorite_Doctor> createState() => _Favorite_DoctorState();
}

class _Favorite_DoctorState extends State<Favorite_Doctor> {
  List mid = [];
  late ScrollController scrollController;
  @override
  void initState() {
    for (int i = 0; i < doctor_list.length; i++)
      setState(() {
        mid.add(doctor_list[i]);
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: mid.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Doctor_Card(
                      onpress: () {
                        Navigator.of(context).pushNamed("/Doctor_Detail");
                      },
                      image: mid[index]["image"],
                      post: mid[index]["post"],
                      name: mid[index]["name"],
                      mark: mid[index]["mark"],
                      day: mid[index]["day"],
                      clinic: mid[index]["clinic"]);
                }),
          )),
        ],
      ),
    );
  }
}

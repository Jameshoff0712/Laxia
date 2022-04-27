import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/clinic_model.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Favorite_Clinic extends StatefulWidget {
  const Favorite_Clinic({Key? key}) : super(key: key);

  @override
  State<Favorite_Clinic> createState() => _Favorite_ClinicState();
}

class _Favorite_ClinicState extends State<Favorite_Clinic> {
  List mid = [];
  late ScrollController scrollController;
  @override
  void initState() {
    for (int i = 0; i < clinic_list.length; i++)
      setState(() {
        mid.add(clinic_list[i]);
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
                  return Clinic_Card(
                      onpress: () {
                        Navigator.of(context).pushNamed("/Clinic_Detail");
                      },
                      image: mid[index]["image"],
                      post: mid[index]["post"],
                      name: mid[index]["name"],
                      mark: mid[index]["mark"],
                      day: mid[index]["day"],
                      location: mid[index]["location"]);
                }),
          )),
        ],
      ),
    );
  }
}

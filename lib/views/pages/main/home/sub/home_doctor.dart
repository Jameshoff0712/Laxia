import 'package:flutter/material.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/views/pages/main/home/selectprefecture.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';


class Home_Doctor extends StatefulWidget {
  const Home_Doctor({Key? key}) : super(key: key);

  @override
  State<Home_Doctor> createState() => _Home_DoctorState();
}

class _Home_DoctorState extends State<Home_Doctor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(250, 240, 242, 245),
      child: Column(
        children: [
           Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: TextButton_Drawer(
                        width: 123, textname: "エリア選択", onpress: () {
                           Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectPrefecture()));
                        })),
                Expanded(
                  flex: 3,
                  child: Dropdownbutton(
                     items: <String>["評価が高い順", "日記の多い順"],
                      hintText: "並び替え",
                      horizontal: 60),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, BoxConstraints viewportConstraints) {
              return Column(
                children: [
                  // menuAppBar(context),
                  Expanded(
                    child: ListView.builder(
                        itemCount: doctor_list.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Doctor_Card(
                              image: doctor_list[index].image,
                              post: doctor_list[index].post,
                              name: doctor_list[index].name,
                              mark: doctor_list[index].mark,
                              day: doctor_list[index].day,
                              clinic: doctor_list[index].clinic);
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

import 'package:flutter/material.dart';
import 'package:laxia/models/clinic_model.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';


class Home_Clinic extends StatefulWidget {
  const Home_Clinic({ Key? key }) : super(key: key);

  @override
  State<Home_Clinic> createState() => _Home_ClinicState();
}

class _Home_ClinicState extends State<Home_Clinic> {
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
                           Navigator.of(context).pushNamed("/SelectPrefecture");
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: LayoutBuilder(builder: (context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    // menuAppBar(context),
                    Expanded(
                      child: ListView.builder(
                          itemCount: clinic_list.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Clinic_Card(
                                image: clinic_list[index].image,
                                post: clinic_list[index].post,
                                name: clinic_list[index].name,
                                mark: clinic_list[index].mark,
                                day: clinic_list[index].day,
                                clinic: clinic_list[index].clinic);
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
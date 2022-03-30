import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/clinic_model.dart';
import 'package:laxia/views/widgets/clinic_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Home_Clinic extends StatefulWidget {
  final bool issearch;
  final List? model;
  const Home_Clinic({Key? key, required this.issearch, this.model})
      : super(key: key);

  @override
  State<Home_Clinic> createState() => _Home_ClinicState();
}

class _Home_ClinicState extends State<Home_Clinic> {
  List mid = [];
  @override
  void initState() {
    if (!widget.issearch) {
      for (int i = 0; i < clinic_list.length; i++)
        setState(() {
          mid.add(clinic_list[i]);
        });
    } else {
      for (int i = 0; i < widget.model!.length; i++)
        setState(() {
          mid.add(widget.model![i]);
        });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Container(
            color: Helper.whiteColor,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: TextButton_Drawer(
                        width: 123,
                        textname: "エリア選択",
                        onpress: () {
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
              child: LayoutBuilder(
                  builder: (context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    // menuAppBar(context),
                    Expanded(
                      child: LayoutBuilder(builder:
                          (context, BoxConstraints viewportConstraints) {
                        return ListView.builder(
                            itemCount: mid.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Clinic_Card(
                                  image: mid[index]["image"],
                                  post: mid[index]["post"],
                                  name: mid[index]["name"],
                                  mark: mid[index]["mark"],
                                  day: mid[index]["day"],
                                  clinic: mid[index]["clinic"]);
                            });
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

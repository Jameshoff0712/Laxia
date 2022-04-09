import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/menu_card.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';
import 'package:laxia/models/menu_model.dart';

class Favorite_Menu extends StatefulWidget {
  Favorite_Menu({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorite_Menu> createState() => _Favorite_MenuState();
}

class _Favorite_MenuState extends State<Favorite_Menu> {
  List mid = [];
  @override
  void initState() {
    for (int i = 0; i < menu_list.length; i++)
      setState(() {
        mid.add(menu_list[i]);
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
                    return Menu_Card(
                        onpress: () {
                          Navigator.of(context).pushNamed("/Menu_Detail");
                        },
                        image: mid[index]["image"],
                        heading: mid[index]["heading"],
                        price: mid[index]["price"],
                        tax: mid[index]["tax"],
                        clinic: mid[index]["clinic"]);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

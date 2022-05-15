import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/favorite_controller.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';
import 'package:laxia/views/pages/main/home/detail/menu_detail.dart';
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
  List<Menu_Sub_Model> mid = [];
  FavoriteController _con = FavoriteController();

  Future<void> getFavMenu() async {
    final listFavMenu = await _con.getFavMenu();
    setState(() {
      for (int i = 0; i < listFavMenu.length; i++) mid.add(listFavMenu[i]);
    });
  }

  @override
  initState() {
    getFavMenu();
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  Menu_Detail(index: mid[index].id)));
                        },
                        image: mid[index].photo!,
                        heading: mid[index].name,
                        price: mid[index].price.toString(),
                        tax: mid[index].risk,
                        clinic: mid[index].description!);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

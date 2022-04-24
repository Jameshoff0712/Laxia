import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/favorite_controller.dart';
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
  FavoriteController _con = FavoriteController();

  Future<void> getFavClinic() async {
    final listFavClinic = await _con.getFavClinic();
    setState(() {
      for(int i=0; i< listFavClinic.length; i++)
        mid.add(listFavClinic[i]);
    });
    print(mid[0].photo);
  }
  @override
  initState(){
    getFavClinic();
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
                        // print("object");
                        Navigator.of(context).pushNamed("/Clinic_Detail");
                      },
                      image: mid[index].photo,
                      post: mid[index].user_name,
                      name: mid[index].name,
                      mark: "0",
                      day: "0",
                      location: mid[index].address);
                }),
          )),
        ],
      ),
    );
  }
}

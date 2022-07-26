import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/favorite_controller.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';
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
  List<Doctor_Sub_Model> mid = [];
  late ScrollController scrollController;
  FavoriteController _con = FavoriteController();

  Future<void> getFavDoctor() async {
    final listFavDoctor = await _con.getFavDoctor();
    setState(() {
      for (int i = 0; i < listFavDoctor.length; i++) mid.add(listFavDoctor[i]);
    });
    print(mid[0].photo);
  }

  @override
  initState() {
    getFavDoctor();
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Doctor_Detail(
                                    index: mid[index].id)));
                      },
                      image: mid[index].photo!,
                      name: mid[index].name!,
                      mark: mid[index].likes_count.toString(),
                      day: mid[index].experience_year.toString(),
                      clinic: mid[index].kata_name);
                }),
          )),
        ],
      ),
    );
  }
}

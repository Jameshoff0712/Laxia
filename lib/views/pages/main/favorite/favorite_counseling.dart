import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/favorite_controller.dart';
import 'package:laxia/models/counseling_api_model.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/views/widgets/counseling_card%20.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Favorite_Counseling extends StatefulWidget {
  const Favorite_Counseling({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorite_Counseling> createState() => _Favorite_CounselingState();
}

class _Favorite_CounselingState extends State<Favorite_Counseling> {
  bool expanded = true;
  int index = -1;
  List<Counseling> mid = [];
  FavoriteController _con = FavoriteController();

  Future<void> getFavCounseling() async {
    final listFavCounseling = await _con.getFavCounseling();
    setState(() {
      for(int i=0; i< listFavCounseling.length; i++)
        mid.add(listFavCounseling[i]);
    });
  }
  @override
  initState(){
    getFavCounseling();
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
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                itemCount: mid.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Counseling_Card(
                    avator: mid[index].patient_photo!,
                    name: mid[index].patient_nickname!,
                    sentence: mid[index].content!,
                    image1: mid[index].patient_photo!,
                    image2: mid[index].patient_photo!,
                    image3: mid[index].patient_photo!,
                    image4: mid[index].patient_photo!,
                    type: mid[index].counseling_date!,
                    clinic: mid[index].clinic_name!,
                    check: mid[index].doctor_name!,
                    eyes: mid[index].views_count.toString(),
                    hearts: mid[index].likes_count.toString(),
                    chats: mid[index].comments_count.toString(),
                    onpress: () {
                      Navigator.of(context).pushNamed("/CounselDetail");
                    },
                  );
                }),
          )),
        ],
      ),
    );
  }
}

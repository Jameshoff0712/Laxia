import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/favorite_controller.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/textbutton_drawer.dart';

class Favorite_Diary extends StatefulWidget {
  const Favorite_Diary({Key? key}) : super(key: key);

  @override
  State<Favorite_Diary> createState() => _Favorite_DiaryState();
}

class _Favorite_DiaryState extends State<Favorite_Diary> {
  bool expanded = true;
  int index = -1;
  List<Diary_Sub_Model> mid = [];
  late ScrollController scrollController;
  FavoriteController _con = FavoriteController();

  Future<void> getFavDiary() async {
    final listFavDiary = await _con.getFavDiary();
    setState(() {
      for(int i=0; i< listFavDiary.length; i++)
        mid.add(listFavDiary[i]);
    });
    print(mid);
  }
  @override
  initState(){
    getFavDiary();
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
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Diary_Card(
                    avator: mid[index].patient_photo!,
                    name: mid[index].patient_nickname!,
                    image1: mid[index].before_image!,
                    image2: mid[index].after_image!,
                    sentence: "",
                    type: "",
                    clinic: mid[index].clinic_name,
                    check: mid[index].doctor_name!,
                    price: mid[index].price.toString(),
                    eyes: mid[index].views_count.toString(),
                    hearts: mid[index].likes_count.toString(),
                    chats: mid[index].comments_count.toString(),
                    onpress: () {
                      Navigator.of(context).pushNamed("/Diary_Detail");
                    },
                  );
                }),
          )),
        ],
      ),
    );
  }
}

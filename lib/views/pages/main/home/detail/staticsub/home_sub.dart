import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/home_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/home_sub_horizonalbar.dart';
import 'package:provider/provider.dart';

class Home_Sub extends StatefulWidget {
  const Home_Sub({Key? key}) : super(key: key);

  @override
  State<Home_Sub> createState() => _Home_SubState();
}

class _Home_SubState extends State<Home_Sub> {
  PageController _pageController = PageController();
  double? currentPageValue = 0.0;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    return Container(
        color: Helper.homeBgColor,
        child: SingleChildScrollView(
          physics:AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Horizontal_Dockbar(pageController: _pageController),
              Container(
                decoration: BoxDecoration(color: Helper.whiteColor),
                child: Column(children: [
                  SizedBox(
                    height: 13,
                  ),
                  DockBar_Bottom(
                      pageController: _pageController,
                      currentPageValue: currentPageValue),
                  SizedBox(
                    height: 16,
                    width: MediaQuery.of(context).size.width,
                  ),
                ]),
              ),
              Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:175/291,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: home_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Home_Card(
                        onpress: () {
                      },
                        title: home_list[index].title,
                        type: home_list[index].type,
                        clinic: home_list[index].clinic,
                        recommend: home_list[index].recommend,
                        source: home_list[index].source,
                        name: home_list[index].name,
                        doctorimage: home_list[index].doctorimage,
                        chat: home_list[index].chat,
                      );
                    }),
              ),
              // Home_Card(
              //   title: "まず前々から気になっていたのは目の下のクマでしたあああ...",
              //   type: "二重",
              //   clinic: "湘南美容クリニック新宿...",
              //   recommend: "999",
              //   chat: "444",
              //   source: "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-1.jpg",
              //   doctorimage: "https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-1.jpg",
              //   name:"Yuka111",
              // ),
            ],
          ),
        ));
  }
}

class DockBar_Bottom extends StatelessWidget {
  const DockBar_Bottom({
    Key? key,
    required PageController pageController,
    required this.currentPageValue,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final double? currentPageValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 31,
      height: 6,
      child: InkWell(
        onTap: () {
          _pageController.animateToPage((currentPageValue!.floor() + 1) % 2,
              duration: Duration(milliseconds: 250), curve: Curves.easeIn);
        },
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
              width: 31,
              height: 6,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 239, 239),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Align(
              alignment: currentPageValue!.floor() == 0
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                width: 16,
                height: 6,
                decoration: BoxDecoration(
                  color: Helper.mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Horizontal_Dockbar extends StatelessWidget {
  const Horizontal_Dockbar({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        color: Helper.whiteColor,
      ),
      height: 150,
      child: PageView(
        controller: _pageController,
        children: [
          Center(
            child: Container(
              height: 143,
              child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.9,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  children: [
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/doubles.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(0);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "二重",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Contour.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(1);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "輪郭・小顔",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Raise_nose.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(2);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "鼻を高く",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/drooping_eye.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(3);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "タレ目",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Hair_loss.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(4);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "脱毛",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/chest.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(5);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "胸",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/body.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(6);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "ボディ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Nose.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(7);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "小鼻",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Wrinkles.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(8);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "しわ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Spots_freckles.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(9);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "しみ・そばかす",
                    ),
                  ]),
            ),
          ),
          Center(
            child: Container(
              height: 143,
              child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.9,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  children: [
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/mouth.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(10);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "口元",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Inner_eye.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(11);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "目頭",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/pores.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(12);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "毛穴",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Sagging.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(13);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "たるみ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Eyes.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(14);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "目元",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Mole_warts.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(15);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "ホクロ・イボ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Permanent_makeup.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(16);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "アートメイク",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Nose_tip.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(17);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "鼻先",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Aesthetic_dentistry.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(18);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "審美歯科",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/all.png",
                      onpress: () {
                        userProperties.setCurrentPartIndex(19);
                        Navigator.of(context).pushNamed("/Part");
                      },
                      text: "すべて",
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

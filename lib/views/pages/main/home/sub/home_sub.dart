import 'package:flutter/material.dart';
import 'package:laxia/models/home_model.dart';
import 'package:laxia/views/widgets/doctor_card.dart';
import 'package:laxia/views/widgets/home_card.dart';
import 'package:laxia/views/widgets/home_sub_horizonalbar.dart';

class Home_Sub extends StatefulWidget {
  const Home_Sub({Key? key}) : super(key: key);

  @override
  State<Home_Sub> createState() => _Home_SubState();
}

class _Home_SubState extends State<Home_Sub> {
  final ScrollController _scrollController = ScrollController();
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
        color: Color.fromARGB(250, 240, 242, 245),
        child: SingleChildScrollView(
          physics:AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Horizontal_Dockbar(pageController: _pageController),
              Container(
                decoration: BoxDecoration(color: Colors.white),
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
                        onpress: () {},
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
                  color: Color.fromARGB(255, 110, 198, 210),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                      onpress: () {},
                      text: "二重",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Contour.png",
                      onpress: () {},
                      text: "輪郭・小顔",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Raise_nose.png",
                      onpress: () {},
                      text: "鼻を高く",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/drooping_eye.png",
                      onpress: () {},
                      text: "タレ目",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Hair_loss.png",
                      onpress: () {},
                      text: "脱毛",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/chest.png",
                      onpress: () {},
                      text: "胸",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/body.png",
                      onpress: () {},
                      text: "ボディ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Nose.png",
                      onpress: () {},
                      text: "小鼻",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Wrinkles.png",
                      onpress: () {},
                      text: "しわ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Spots_freckles.png",
                      onpress: () {},
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
                      onpress: () {},
                      text: "口元",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Inner_eye.png",
                      onpress: () {},
                      text: "目頭",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/pores.png",
                      onpress: () {},
                      text: "毛穴",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Sagging.png",
                      onpress: () {},
                      text: "たるみ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Eyes.png",
                      onpress: () {},
                      text: "目元",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Mole_warts.png",
                      onpress: () {},
                      text: "ホクロ・イボ",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Permanent_makeup.png",
                      onpress: () {},
                      text: "アートメイク",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Nose_tip.png",
                      onpress: () {},
                      text: "鼻先",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/Aesthetic_dentistry.png",
                      onpress: () {},
                      text: "審美歯科",
                    ),
                    Home_Sub_Horizonalbar(
                      width: 45,
                      height: 65,
                      image: "icons/menubar/all.png",
                      onpress: () {},
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

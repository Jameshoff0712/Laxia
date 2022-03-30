import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
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
        color: Helper.homeBgColor,
        child: SingleChildScrollView(
          physics:AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
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
                    physics: const AlwaysScrollableScrollPhysics(),
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
              height: 150,
              child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
                  ]),
            ),
          ),
          Center(
            child: Container(
              height: 150,
              child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
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
                      image: "icons/menubar/doubles.png",
                      onpress: () {},
                      text: "二重",
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

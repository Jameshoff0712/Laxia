import 'package:laxia/views/pages/auth/login.dart';
import 'package:laxia/views/pages/auth/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/models/instructions.dart';
import 'package:laxia/common/helper.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController();

  double? currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Helper.whiteColor.withOpacity(0),
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Helper.whiteColor.withOpacity(0),
    ));
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    // if (currentPageValue!.floor() != 3) {
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onBoardingInstructions.length,
                itemBuilder: (context, i) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 21.5, right: 21.5, top: 56.72),
                      child: SvgPicture.asset(
                        "${onBoardingInstructions[i].image}",
                        width: 300,
                        height: 326.53,
                      ),
                    ),
                    SizedBox(height: 80),
                    Text("${onBoardingInstructions[i].heading}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 27 / 18,
                            letterSpacing: -0.54)),
                    SizedBox(
                      height: 30,
                    ),
                    Text("${onBoardingInstructions[i].title}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 24 / 16,
                            letterSpacing: -0.54,
                            color: Helper.maintxtColor)),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 32, top: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onBoardingInstructions.length,
                        (f) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: f == currentPageValue!.floor()
                                ? Helper.blackColor.withOpacity(0.98)
                                : Helper.blackColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          width: f == currentPageValue!.floor() ? 7 : 7,
                          height: 7,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    (currentPageValue!.floor() != 3)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: Text("スキップ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          height: 24 / 16,
                                          letterSpacing: -0.54,
                                          color: Helper.maintxtColor)),
                                  onPressed: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen())),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Helper.mainColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: InkWell(
                                    onTap: () => _pageController.nextPage(
                                        duration:
                                            const Duration(microseconds: 300),
                                        curve: Curves.easeIn),
                                    child: Text("次へ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            height: 27 / 18,
                                            letterSpacing: -0.54,
                                            color: Helper.whiteColor)),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Helper.mainColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen())),
                                child: Text("ラシアを始める",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        height: 27 / 18,
                                        letterSpacing: -0.54,
                                        color: Helper.whiteColor)),
                              ),
                            ),
                          )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

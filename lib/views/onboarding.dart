import 'package:laxia/views/pages/auth/login.dart';
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
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Helper.whiteColor,
    ));
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    var list;
    if (currentPageValue!.floor() != 3) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Helper.mainColor,
          body: Padding(
            padding:
                const EdgeInsets.only(top: 0, right: 0, bottom: 0, left: 0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onBoardingInstructions.length,
                    itemBuilder: (context, i) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 142, bottom: 32),
                          alignment: Alignment.topCenter,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "${onBoardingInstructions[i].heading} \n",
                                style: TextStyle(
                                    color: Helper.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                text: "${onBoardingInstructions[i].title}",
                                style: TextStyle(
                                    color: Helper.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    fontSize: 16),
                              ),
                            ]),
                          ),
                        ),
                        Flexible(
                          child: Image.asset(
                            "${onBoardingInstructions[i].image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Helper.mainColor,
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            width: f == currentPageValue!.floor() ? 7 : 7,
                            height: 7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 18),
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      "すぐに始める",
                      style: TextStyle(
                          color: Helper.whiteColor,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          fontSize: 14,
                          decoration: TextDecoration.underline),
                    ),
                    onPressed: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          backgroundColor:Helper.mainColor,
          body: Padding(
            padding:
                const EdgeInsets.only(top: 0, right: 0, bottom: 0, left: 0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onBoardingInstructions.length,
                    itemBuilder: (context, i) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 142, bottom: 32),
                          alignment: Alignment.topCenter,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "${onBoardingInstructions[i].heading} \n",
                                style: TextStyle(
                                    color: Helper.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    fontSize: 16),
                              ),
                              TextSpan(
                                text: "${onBoardingInstructions[i].title}",
                                style: TextStyle(
                                    color: Helper.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    fontSize: 16),
                              ),
                            ]),
                          ),
                        ),
                        Flexible(
                          child: Image.asset(
                            "${onBoardingInstructions[i].image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 32.0, left: 0.0, right: 0.0, bottom: 76.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 219,
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Helper.btnBgYellowColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "さあ, はじめよう！",
                                style: defaultTextStyle(
                                    Helper.whiteColor, FontWeight.w700,
                                    size: 14),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (onBoardingInstructions.length - 1 ==
                                _pageController.page) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            } else
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.easeIn);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

import 'package:laxia/screens/signup.dart';
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
      statusBarColor: Colors.white,
    ));
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 10, bottom: 15, left: 10),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  child: Text("Skip", style: defaultTextStyle(Helper.mainColor, FontWeight.w700)),
                  onPressed: () =>
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen())),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onBoardingInstructions.length,
                  itemBuilder: (context, i) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.topLeft,
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "${onBoardingInstructions[i].heading} \n",
                              style: defaultTextStyle(Helper.mainColor, FontWeight.w700, size: 36),
                            ),
                            TextSpan(
                              text: "${onBoardingInstructions[i].title}",
                              style: defaultTextStyle(Colors.blueGrey, FontWeight.w700, size: 32),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${onBoardingInstructions[i].subtitle}",
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey),
                          textAlign: TextAlign.left,
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
                padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onBoardingInstructions.length,
                        (f) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            shape: f == currentPageValue!.floor() ? BoxShape.rectangle : BoxShape.circle,
                            color: f == currentPageValue!.floor() ? Helper.mainColor : Colors.blueGrey,
                            borderRadius: f == currentPageValue!.floor() ? BorderRadius.circular(5.0) : null,
                          ),
                          width: f == currentPageValue!.floor() ? 15 : 5,
                          height: 5,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Helper.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Next ",
                              style: defaultTextStyle(Colors.white, FontWeight.w700),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                        onPressed: () {
                          if (onBoardingInstructions.length - 1 == _pageController.page) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                          } else
                            _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeIn);
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

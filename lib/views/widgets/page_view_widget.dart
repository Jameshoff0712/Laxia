import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/instructions.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
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
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Helper.blackColor,
          bottomOpacity: 0,
          shadowColor: Helper.blackColor,
          title: Text(
            '${currentPageValue!.floor() + 1}/${onBoardingInstructions.length}',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              height: 1.5,
              color: Helper.whiteColor,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Helper.whiteColor,
                size: 30,
              )),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Helper.blackColor),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onBoardingInstructions.length,
                  itemBuilder: (context, i) => SingleChildScrollView(
                    child: Image.asset(
                      "${onBoardingInstructions[i].image}",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  onBoardingInstructions.length,
                  (f) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: f == currentPageValue!.floor()
                          ? Color.fromARGB(255, 255, 255, 255)
                          : Helper.whiteColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    width: f == currentPageValue!.floor() ? 8 : 8,
                    height: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

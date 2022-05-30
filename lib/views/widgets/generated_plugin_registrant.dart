import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/VideoVolumeWidget.dart';
import "package:video_controls/video_controls.dart";
class PageViewWidget extends StatefulWidget {
  final int ?startindex;
  final bool ? isimage;
  final List<String> onBoardingInstructions;
  const PageViewWidget({Key? key, required this.onBoardingInstructions, this.isimage=true, this.startindex=0}) : super(key: key);

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  PageController _pageController = PageController();
  late  VideoController  _controller;
  double? currentPageValue = 0.0;
  bool isStart=false;
  String currenttime="00:00";

  @override
  void initState() {
    currentPageValue=widget.startindex!.toDouble();
    super.initState();
    _pageController = PageController(initialPage: widget.startindex!);
    _controller = VideoController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    ..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
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
            '${currentPageValue!.floor() + 1}/${widget.onBoardingInstructions.length}',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              
              color: Helper.whiteColor,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Helper.whiteColor,
                size: 30,
              )),
          elevation: 0,
        ),
        body: widget.isimage!?  Container(
          decoration: BoxDecoration(
              color: Helper.blackColor),
          child: Column(
            children: [
             Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.onBoardingInstructions.length,
                  itemBuilder: (context, i) => SizedBox(
                    width:MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                     fit: BoxFit.contain,
                      imageUrl: widget.onBoardingInstructions[i],
                      placeholder: (context, url) => Image.asset(
                        'assets/images/loading.gif',
                       fit: BoxFit.contain,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/Profile.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  widget.onBoardingInstructions.length,
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
        ):(_controller.value.isInitialized
              ? Container(
                color: Color.fromRGBO(0, 0, 0, 1),
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller)),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: VideoVolumeWidget(controller: _controller),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //      InkWell(
                    //         onTap: (){
                    //                 if(isStart){
                    //                    setState(() {
                    //                      isStart=!isStart;
                    //                    });
                    //                   _controller.pause();
                    //                 }else{
                    //                   setState(() {
                    //                      isStart=!isStart;
                    //                    });
                    //                   _controller.play();
                    //                 }
                    //         },
                    //         child: Icon(!isStart? Icons.play_arrow :Icons.pause,color: Helper.whiteColor,)
                    //       ),
                    //       Text(currenttime+":"+_controller.value.duration.toString().substring(3,7),style: TextStyle(color: Helper.whiteColor))
                    //   ],
                    // )
                  ],
                ),
              )
              : Container(
                decoration: BoxDecoration(
              color: Helper.blackColor),
              )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:video_player/video_player.dart';

class Home_Card extends StatefulWidget {
  final VoidCallback onpress;
  final bool? isimage;
  final String source, title, type, clinic, doctorimage, name, recommend, chat;
  const Home_Card(
      {Key? key,
      this.isimage = true,
      required this.source,
      required this.title,
      required this.type,
      required this.clinic,
      required this.name,
      required this.recommend,
      required this.chat,
      required this.doctorimage,
      required this.onpress})
      : super(key: key);

  @override
  State<Home_Card> createState() => _Home_CardState();
}

class _Home_CardState extends State<Home_Card> {
  bool isvideo=false;
  late  VideoPlayerController _controller;
  @override 
  void initState(){
    if(!widget.source.contains(".jpg")){
      print("object");
      setState(() {
        isvideo=true;
      });
      _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Helper.whiteColor,
        ),
        width: 175,
        height: 291,
        child: InkWell(
          onTap: widget.onpress,
          child: Column(
            children: [
              SizedBox(
                height: 175,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    isvideo? LayoutBuilder(
                        builder: (context, constraints) => _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: 1,
                                // _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : Container(),
                      ): CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.source,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/Profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    isvideo? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                                 _controller.play();
                        },
                        child: SvgPicture.asset(
                                "icons/menubar/video_play.svg",
                                width: 24,
                                height: 24,
                              ),
                      ),
                    ):Container(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Helper.titleColor),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/menubar/ping.svg",
                            width: 12,
                            height: 12,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            widget.type,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Helper.maintxtColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/menubar/clinic.svg",
                            width: 12,
                            height: 12,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            widget.clinic,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Helper.maintxtColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 13,
                          width: 13,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child:CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.doctorimage,
                              placeholder: (context, url) => Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/Profile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Helper.txtColor),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        SvgPicture.asset(
                          "assets/icons/menubar/heart.svg",
                          width: 10,
                          height: 9,
                        ),
                        Text(
                          widget.recommend,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Helper.txtColor),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(
                          "assets/icons/menubar/comment.svg",
                          width: 10,
                          height: 9,
                        ),
                        Text(
                          widget.recommend,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Helper.txtColor),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

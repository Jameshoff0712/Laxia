import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoVolumeWidget extends StatefulWidget {
  final VideoPlayerController controller;

  VideoVolumeWidget({required this.controller});

  @override
  VideoVolumeWidgetState createState() => VideoVolumeWidgetState();
}

class VideoVolumeWidgetState extends State<VideoVolumeWidget> {
  bool isMute = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
            highlightColor: Colors.transparent, 
      icon: Icon(isMute ? Icons.volume_off_outlined : Icons.volume_up_outlined, size: 18),
      onPressed: () {
        if (isMute) {
          widget.controller.setVolume(0);
        } else {
          widget.controller.setVolume(1);
        }
        isMute = !isMute;
        setState(() {});
      },
    );
  }
}

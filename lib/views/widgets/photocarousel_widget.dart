import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';

class PhotoCarouselWidget extends StatefulWidget {
   final Function(int) onRemove;
  final List ImageList;
  final bool? bRemove;
  const PhotoCarouselWidget({ Key? key, required this.onRemove, required this.ImageList, this.bRemove=true }) : super(key: key);

  @override
  State<PhotoCarouselWidget> createState() => _PhotoCarouselWidgetState();
}

class _PhotoCarouselWidgetState extends State<PhotoCarouselWidget> {
  

 @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (int i = 0; i < widget.ImageList.length; i++)
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: <Widget>[
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget( onBoardingInstructions: [
                              for (int j = 0; j < widget.ImageList.length; j++)
                                widget.ImageList[j],
                            ],
                            startindex: 1,)));
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            child: Image.file(
                                        widget.ImageList[i]!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget.bRemove == true
                      ? InkWell(
                          onTap: () {
                            widget.onRemove(i);
                          },
                          child: Container(
                            // top: 0,
                            // right: -20,
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 0,
                        ),
                ],
              ),
            ],
          ),
        ),
    ]);
  }
}

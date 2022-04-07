import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_viewer/image_viewer.dart';

class PhotoCarouselWidget extends StatelessWidget {
  //final List<Offer>? offerList;
  List ImageList;
  bool? bRemove;

  //PhotoCarouselWidget({Key? key, this.offerList, this.heroTag}) : super(key: key);
  PhotoCarouselWidget({Key? key, required this.ImageList, this.bRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (int i = 0; i < ImageList.length; i++)
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
                          ImageViewer.showImageSlider(
                            images: [
                              for (int j = 0; j < ImageList.length; j++)
                                ImageList[j],
                            ],
                            startingPosition: 1,
                          );
                        },
                        child: Container(
                          width: 110,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: ImageList[i],
                              placeholder: (context, url) => Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  bRemove == true
                      ? InkWell(
                          onTap: () {
                            print("remove");
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

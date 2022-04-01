import 'package:cached_network_image/cached_network_image.dart';
import 'package:laxia/generated/l10n.dart';
import 'package:laxia/models/m_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PhotoCarouselWidget extends StatelessWidget {
  //final List<Offer>? offerList;
  //final String? heroTag;

  //PhotoCarouselWidget({Key? key, this.offerList, this.heroTag}) : super(key: key);
  PhotoCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Container(
                width: 110,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-1.jpg',
                    placeholder: (context, url) => Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  print("remove");
                },
                child: Container(
                  // top: 0,
                  // right: -20,
                  child: SvgPicture.asset(
                    "icons/close.svg",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    //   return offerList!.isEmpty
    //       ? PhotoCarouselLoaderWidget(direction: Axis.horizontal)
    //       : Container(
    //           height: 200,
    //           // padding: EdgeInsets.symmetric(vertical: 10),
    //           child: ListView.builder(
    //             itemCount: offerList!.length,
    //             itemBuilder: (context, index) {
    //               var offer = offerList![index];
    //               double _marginLeft = 0;
    //               (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
    //               return InkWell(
    //                 splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.08),
    //                 highlightColor: Colors.transparent,
    //                 onTap: () {
    //                 },
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: <Widget>[
    //                     Stack(
    //                       alignment: AlignmentDirectional.topEnd,
    //                       children: <Widget>[
    //                         Hero(
    //                           tag: heroTag! + offer.id.toString(),
    //                           child: Container(
    //                             margin: EdgeInsetsDirectional.only(start: _marginLeft, end: 20),
    //                             width: 210,
    //                             height: 120,
    //                             child: ClipRRect(
    //                               borderRadius:
    //                                   BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
    //                               child: CachedNetworkImage(
    //                                 fit: BoxFit.cover,
    //                                 imageUrl: offer.imageUrl!,
    //                                 placeholder: (context, url) => Image.asset(
    //                                   'assets/images/loading.gif',
    //                                   fit: BoxFit.cover,
    //                                 ),
    //                                 errorWidget: (context, url, error) => Icon(Icons.error),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         Container(
    //                           margin: EdgeInsetsDirectional.only(end: 25, top: 5),
    //                           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.all(Radius.circular(100)),
    //                             color: offer.offerPrice! > 0 ? Colors.redAccent : Theme.of(context).colorScheme.secondary,
    //                           ),
    //                           alignment: AlignmentDirectional.topEnd,
    //                           child: Text(
    //                             "aaa",
    //                             style: TextStyle(color: Colors.white, fontSize: 16),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     Container(
    //                         width: 210,
    //                         margin: EdgeInsetsDirectional.only(start: _marginLeft, end: 20),
    //                         padding: const EdgeInsets.only(top: 8, bottom: 12),
    //                         decoration: BoxDecoration(
    //                           color: Colors.grey[100],
    //                           borderRadius:
    //                               BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
    //                         ),
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: <Widget>[
    //                             SizedBox(
    //                               width: 180,
    //                               child: Text(
    //                                 offer.provider!,
    //                                 overflow: TextOverflow.fade,
    //                                 softWrap: false,
    //                                 maxLines: 1,
    //                                 //style: defaultTextStyle(Helper.appTxtColor, FontWeight.bold, size: 14),
    //                               ),
    //                             ),
    //                             SizedBox(height: 6),
    //                           ],
    //                         )),
    //                   ],
    //                 ),
    //               );
    //             },
    //             scrollDirection: Axis.horizontal,
    //           ));
  }
}

class PhotoCarouselLoaderWidget extends StatelessWidget {
  final Axis direction;
  const PhotoCarouselLoaderWidget({Key? key, this.direction = Axis.vertical})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: ListView.builder(
        scrollDirection: direction,
        itemBuilder: (context, index) {
          double _marginLeft = 0;
          (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
          return Container(
            margin: EdgeInsetsDirectional.only(start: _marginLeft, end: 20),
            width: 160,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // boxShadow: [
              //   BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
              // ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Image.asset(
                'assets/images/loading.gif',
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}

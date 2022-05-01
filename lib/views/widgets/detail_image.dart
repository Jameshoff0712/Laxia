import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laxia/common/helper.dart';

class Detail_Image extends StatefulWidget {
  final bool ? insidestar,isDoctor;
  final VoidCallback onPressBack, onPressUpRight;
  final VoidCallback? onStar;
  final List imageList;
  final double height;
  const Detail_Image(
      {Key? key,
      required this.height,
      required this.imageList,
      required this.onPressBack,
      required this.onPressUpRight, this.insidestar=false, this.onStar, this.isDoctor=false})
      : super(key: key);

  @override
  State<Detail_Image> createState() => _Detail_ImageState();
}

class _Detail_ImageState extends State<Detail_Image> {
  int _currentpage = 0;
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.insidestar!?Alignment.topRight:Alignment.topLeft,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentpage = index;
                });
              },
              height: widget.height,
              viewportFraction: 1.0,
              autoPlay: false),
          items: widget.imageList.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: image.path,
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
                );
              },
            );
          }).toList(),
        ),
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  "assets/icons/back_detail.svg",
                  width: 30,
                  height: 30,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/upright.svg",
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(width: 10,),
                  (widget.insidestar!)&&(!widget.isDoctor!)?InkWell(
                    onTap: widget.onStar,
                    child: SvgPicture.asset(
                      "assets/icons/insidestar.svg",
                      width: 30,
                      height: 30,
                    ),
                  ):SizedBox(width: 0,),
                ],
              ),
            ],
          ),
        )),
        Padding(

          padding: widget.insidestar!?EdgeInsets.only(right: 16, top: widget.isDoctor!?(widget.height - 115):(widget.height - 40)):EdgeInsets.only(left: 16, top: widget.height - 40),
          child: Container(
              decoration: BoxDecoration(
                  color: Helper.blackColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  (_currentpage+1).toString() +
                      "/" +
                      widget.imageList.length.toString(),
                  style: TextStyle(letterSpacing: 2, color: Helper.whiteColor,fontSize: 12),
                ),
              )),
        )
      ],
    );
  }
}

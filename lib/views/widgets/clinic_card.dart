import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_detail.dart';

class Clinic_Card extends StatefulWidget {
  final VoidCallback? onpress, posPress;
  final String image, post, name, mark, day, location;
  const Clinic_Card(
      {Key? key,
      required this.image,
      required this.post,
      required this.name,
      required this.mark,
      required this.day,
      required this.location,
      this.onpress = null,
      this.posPress = null})
      : super(key: key);

  @override
  State<Clinic_Card> createState() => _Clinic_CardState();
}

class _Clinic_CardState extends State<Clinic_Card> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpress!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        color: Helper.whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.image != "none"
                  ? Container(
                      decoration: BoxDecoration(color: Helper.whiteColor),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                fit: BoxFit.fitHeight,
                                imageUrl: widget.image,
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/loading.gif',
                                  fit: BoxFit.fitHeight,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/profile.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 41,
                            width: 50,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: 0,
                    ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  color: Helper.whiteColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                               fontFamily: Helper.headFontFamily,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                                height: 1.5),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            widget.post,
                            style: TextStyle(
                                fontFamily: Helper.headFontFamily,
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                                height: 1.5),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 206, 176, 88),
                              size: 12,
                            ),
                          Text(
                            widget.mark,
                            style: TextStyle(
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.0,
                                height: 1.5),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.day,
                            style: TextStyle(
                                color: Helper.titleColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.0,
                                height: 1.5),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            "日記",
                            style: TextStyle(
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 11.0,
                                height: 1.5),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          if (widget.posPress != null) {
                            widget.posPress!();
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/menubar/pin.svg",
                              width: 14,
                              height: 14,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              widget.location,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Helper.maintxtColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

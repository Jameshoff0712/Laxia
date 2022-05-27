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
        decoration: BoxDecoration(
            color: Helper.whiteColor, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.image != "none"
                  ? Container(
                      decoration: BoxDecoration(
                          color: Helper.whiteColor,
                          borderRadius: BorderRadius.circular(5)),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.name,
                            style: widget.image != "none"
                                ? TextStyle(
                                    fontFamily: Helper.headFontFamily,
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                    height: 1.5)
                                : TextStyle(
                                    fontFamily: Helper.headFontFamily,
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0,
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
                        height: widget.image != "none" ? 2.5 : 7,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(Icons.star_rounded,
                                color: Helper.starColor,
                                size: widget.image != "none" ? 16 : 20),
                          Text(
                            widget.mark,
                            style: widget.image != "none"
                                ? TextStyle(
                                    fontFamily: Helper.headFontFamily,
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0)
                                : TextStyle(
                                    fontFamily: Helper.headFontFamily,
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.day,
                            style: widget.image != "none"
                                ? TextStyle(
                                    fontFamily: Helper.headFontFamily,
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0)
                                : TextStyle(
                                    fontFamily: Helper.headFontFamily,
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          widget.image != "none"
                              ? Text(
                                  "日記",
                                  style: TextStyle(
                                      color: Helper.maintxtColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.0),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        height: widget.image != "none" ? 20 : 10,
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
                            widget.image != "none"
                                ? SvgPicture.asset(
                                    "assets/icons/menubar/pin.svg",
                                    width: 14,
                                    height: 14,
                                  )
                                : SvgPicture.asset(
                                    "assets/icons/fullpin.svg",
                                    width: 12,
                                    height: 16,
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

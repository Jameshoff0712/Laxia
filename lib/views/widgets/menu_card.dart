import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Menu_Card extends StatefulWidget {
  final VoidCallback?onpress;
  final String image, heading, price, clinic;
  final String? tax;
  final BoxShadow? shadow;
  const Menu_Card(
      {Key? key,
      required this.image,
      required this.heading,
      required this.price,
      this.tax,
      required this.clinic, this.shadow=null, this.onpress=null})
      : super(key: key);

  @override
  State<Menu_Card> createState() => _Menu_CardState();
}

class _Menu_CardState extends State<Menu_Card> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onpress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            boxShadow:widget.shadow==null?[]: [widget.shadow!]),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(color: Helper.whiteColor),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 7, bottom: 10),
                  child: SizedBox(
                    height: 110,
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.image,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/loading.gif',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Helper.whiteColor),
                child: SizedBox(
                  width: 10,
                  height: 130,
                ),
              ),
              Expanded(
                child: Container(
                  color: Helper.whiteColor,
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                height: 41,
                                child: Text(
                                  widget.heading,
                                  style: defaultTextStyle(
                                      Helper.titleColor, FontWeight.w700,
                                      size: 14.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.price,
                              style: defaultTextStyle(Helper.priceColor, FontWeight.w700,
                                  size: 16.0),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "(税込)",
                              style: defaultTextStyle(
                                  Helper.titleColor, FontWeight.w500,
                                  size: 10.0),
                            ),
                          ],
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
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  widget.clinic,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: defaultTextStyle(
                                      Helper.appTxtColor, FontWeight.w500,
                                      size: 12.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

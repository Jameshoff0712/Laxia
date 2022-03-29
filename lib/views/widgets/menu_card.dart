import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Menu_Card extends StatefulWidget {
  final String image, heading, price, tax, clinic;
  const Menu_Card(
      {Key? key,
      required this.image,
      required this.heading,
      required this.price,
      required this.tax,
      required this.clinic})
      : super(key: key);

  @override
  State<Menu_Card> createState() => _Menu_CardState();
}

class _Menu_CardState extends State<Menu_Card> {
  final greyTextcolor = Color.fromARGB(255, 51, 51, 51);
  final priceColor = Color.fromARGB(255, 240, 154, 55);
  final _whiteColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => MessageScreen(user: favorites[index])));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: _whiteColor),
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
              decoration: BoxDecoration(color: _whiteColor),
              child: SizedBox(
                width: 10,
                height: 130,
              ),
            ),
            Expanded(
              child: Container(
                color: _whiteColor,
                height: 130,
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
                                  greyTextcolor, FontWeight.w700,
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
                          style: defaultTextStyle(priceColor, FontWeight.w700,
                              size: 16.0),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.tax,
                          style: defaultTextStyle(
                              greyTextcolor, FontWeight.w500,
                              size: 10.0),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "icons/menubar/clinic.svg",
                            width: 12,
                            height: 12,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.clinic,
                            style: defaultTextStyle(
                                Helper.appTxtColor, FontWeight.w500,
                                size: 12.0),
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
    );
  }
}

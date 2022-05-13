import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laxia/views/pages/main/home/detail/doctor_detail.dart';

class Doctor_Card extends StatefulWidget {
  final VoidCallback? onpress;
  final String image, post, name, mark, day, clinic;
  const Doctor_Card(
      {Key? key,
      required this.image,
      required this.post,
      required this.name,
      required this.mark,
      required this.day,
      required this.clinic,
      this.onpress = null})
      : super(key: key);

  @override
  State<Doctor_Card> createState() => _Doctor_CardState();
}

class _Doctor_CardState extends State<Doctor_Card> {
  final _whiteColor = Helper.whiteColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpress!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        color: Helper.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: _whiteColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                      width: 52,
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
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
                    SizedBox(
                      height: 42,
                      width: 52,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: _whiteColor),
              child: SizedBox(
                width: 12,
              ),
            ),
            Expanded(
              child: Container(
                color: _whiteColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontFamily: Helper.headFontFamily,
                              color: Helper.titleColor, 
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              height: 1.5),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.post,
                          style: TextStyle(
                              color: Helper.maintxtColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/menubar/clinic.svg",
                          width: 12,
                          height: 12,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.clinic,
                          style: TextStyle(
                              color: Helper.maintxtColor,
                              fontWeight: FontWeight.w400, 
                              fontSize: 12.0,
                              height: 1.5),
                        ),
                      ],
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
   
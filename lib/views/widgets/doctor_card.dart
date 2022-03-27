import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Doctor_Card extends StatefulWidget {
  final String image, post, name, mark, day, clinic;
  const Doctor_Card(
      {Key? key,
      required this.image,
      required this.post,
      required this.name,
      required this.mark,
      required this.day,
      required this.clinic})
      : super(key: key);

  @override
  State<Doctor_Card> createState() => _Doctor_CardState();
}

class _Doctor_CardState extends State<Doctor_Card> {
  final greyTextcolor = Color.fromARGB(255, 51, 51, 51);
  final clinicColor = Color.fromARGB(255, 102, 110, 110);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(color: _whiteColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                      width: 74,
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.image,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/doctor_profile.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 42,
                      width: 74,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: _whiteColor),
              child: SizedBox(
                width: 12,
                height: 109,
              ),
            ),
            Expanded(
              child: Container(
                color: _whiteColor,
                height: 110,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: defaultTextStyle(
                              greyTextcolor, FontWeight.w700,
                              size: 16.0),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.post,
                          style: defaultTextStyle(clinicColor, FontWeight.w700,
                              size: 10.0),
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
                            color: Colors.yellow,
                            size: 12,
                          ),
                        Text(
                          widget.mark,
                          style: defaultTextStyle(
                              greyTextcolor, FontWeight.w700,
                              size: 11.0),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.day,
                          style: defaultTextStyle(
                              greyTextcolor, FontWeight.w700,
                              size: 11.0),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Text(
                          "日記",
                          style: defaultTextStyle(clinicColor, FontWeight.w400,
                              size: 11.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          style: defaultTextStyle(clinicColor, FontWeight.w400,
                              size: 12.0),
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

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home_Card extends StatefulWidget {
  final VoidCallback onpress;
  final bool? isimage;
  final String source, title, type, clinic, doctorimage, name, recommend, chat;
  const Home_Card(
      {Key? key,
      this.isimage = true,
      required this.source,
      required this.title,
      required this.type,
      required this.clinic,
      required this.name,
      required this.recommend,
      required this.chat,
      required this.doctorimage,
      required this.onpress})
      : super(key: key);

  @override
  State<Home_Card> createState() => _Home_CardState();
}

class _Home_CardState extends State<Home_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 175,
      height: 291,
      child: InkWell(
        onTap: widget.onpress,
        child: Column(
          children: [
            SizedBox(
              height: 175,
              width: 175,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.source,
                placeholder: (context, url) => Image.asset(
                  'assets/images/loading.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/ProDoctor.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 51, 51, 51)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "icons/menubar/heart.svg",
                          width: 12,
                          height: 12,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.type,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 102, 110, 110)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "icons/menubar/heart.svg",
                          width: 12,
                          height: 12,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.clinic,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 102, 110, 110)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 13,
                        width: 13,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.doctorimage,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/ProDoctor.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 156, 161, 161)),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      SvgPicture.asset(
                        "icons/menubar/heart.svg",
                        width: 10,
                        height: 9,
                      ),
                      Text(
                        widget.recommend,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 156, 161, 161)),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(
                        "icons/menubar/comment.svg",
                        width: 10,
                        height: 9,
                      ),
                      Text(
                        widget.recommend,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 156, 161, 161)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

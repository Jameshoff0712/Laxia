import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Home_Sub_Horizonalbar extends StatefulWidget {
  final VoidCallback onpress;
  final double width, height;
  final String image, text;
  const Home_Sub_Horizonalbar(
      {Key? key,
      required this.width,
      required this.height,
      required this.image,
      required this.text,
      required this.onpress})
      : super(key: key);

  @override
  State<Home_Sub_Horizonalbar> createState() => _Home_Sub_HorizonalbarState();
}

class _Home_Sub_HorizonalbarState extends State<Home_Sub_Horizonalbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Helper.whiteColor),
      child: InkWell(
        onTap: widget.onpress,
        child: Column(
          children: [
            SizedBox(
              width: widget.width,
              height: widget.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.width / 2),
                child: SvgPicture.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 7,),
            Center(
                child: Text(
              widget.text,
              overflow: TextOverflow.visible,
              maxLines: 1,
              style: TextStyle(
                  color: Helper.unSelectSmallTabColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ))
          ],
        ),
      ),
    );
  }
}

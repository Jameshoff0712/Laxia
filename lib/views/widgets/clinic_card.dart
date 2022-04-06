import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laxia/views/pages/main/home/detail/clinic_detail.dart';

class Clinic_Card extends StatefulWidget {
  final VoidCallback? onpress,posPress;
  final String image, post, name, mark, day, pos;
  const Clinic_Card(
      {Key? key,
      required this.image,
      required this.post,
      required this.name,
      required this.mark,
      required this.day,
      required this.pos, this.onpress=null, this.posPress=null})
      : super(key: key);

  @override
  State<Clinic_Card> createState() => _Clinic_CardState();
}

class _Clinic_CardState extends State<Clinic_Card> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onpress!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.image!="none"?Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
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
                            'assets/images/profile.png',
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
            ):SizedBox(width: 0,),
            Container(
              decoration: BoxDecoration(color: Helper.whiteColor),
              child: SizedBox(
                width: 12,
                height: 109,
              ),
            ),
            Expanded(
              child: Container(
                color: Helper.whiteColor,
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
                              Helper.titleColor, FontWeight.w700,
                              size: 16.0),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          widget.post,
                          style: defaultTextStyle(Helper.maintxtColor, FontWeight.w700,
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
                              Helper.titleColor, FontWeight.w700,
                              size: 11.0),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.day,
                          style: defaultTextStyle(
                              Helper.titleColor, FontWeight.w700,
                              size: 11.0),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Text(
                          "日記",
                          style: defaultTextStyle(Helper.maintxtColor, FontWeight.w400,
                              size: 11.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (){
                        if(widget.posPress!=null)
                        {
                          widget.posPress!();
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "icons/menubar/pin.svg",
                            width: 12,
                            height: 12,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.pos,
                            overflow:TextOverflow.ellipsis ,
                            style: defaultTextStyle(Helper.maintxtColor, FontWeight.w400,
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

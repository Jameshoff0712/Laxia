import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class Doctor_Group_Card extends StatefulWidget {
  final dynamic doctor;
  const Doctor_Group_Card({ Key? key, required this.doctor }) : super(key: key);

  @override
  State<Doctor_Group_Card> createState() => _Doctor_Group_CardState();
}

class _Doctor_Group_CardState extends State<Doctor_Group_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Helper.whiteColor,
      borderRadius: BorderRadius.circular(7),
      boxShadow:[
         BoxShadow(
        color: Colors.grey.withOpacity(0.8),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 1), // changes position of shadow
      ),
      ]
      ),
      width: 87,
       height: 110,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.5,vertical: 6),
          child: FittedBox(
            child: SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:  widget.doctor["image"],
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
        Text(
          widget.doctor["name"],
          style: TextStyle(
              color:
                  Helper.titleColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        Text(
           widget.doctor["post"],
          style: TextStyle(
              color:
                  Helper.maintxtColor,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
       ]),
    );
  }
}
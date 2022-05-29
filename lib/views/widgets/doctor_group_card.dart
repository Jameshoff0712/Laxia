import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/doctor/doctor_sub_model.dart';

class Doctor_Group_Card extends StatefulWidget {
  final VoidCallback onpress;
  final Doctor_Sub_Model doctor;
  const Doctor_Group_Card(
      {Key? key, required this.doctor, required this.onpress})
      : super(key: key);

  @override
  State<Doctor_Group_Card> createState() => _Doctor_Group_CardState();
}

class _Doctor_Group_CardState extends State<Doctor_Group_Card> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          decoration: BoxDecoration(
              color: Helper.whiteColor,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
              ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.5, vertical: 6),
              child: FittedBox(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.doctor.photo == null
                          ? "https://error.png"
                          : widget.doctor.photo!,
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
            SizedBox(
              height: 6,
            ),
            Text(
              widget.doctor.name == null ? "" : widget.doctor.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Helper.titleColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              widget.doctor.job_name == null ? "" : widget.doctor.job_name!,
              style: TextStyle(
                  color: Helper.maintxtColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 2,
            )
          ]),
        ),
      ),
    );
  }
}

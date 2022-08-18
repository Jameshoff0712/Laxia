import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/home/category_model.dart';
import 'package:laxia/models/menu/image_model.dart';
import 'package:laxia/models/question/media_model.dart';
import 'package:nb_utils/nb_utils.dart';

class Counseling_Card extends StatefulWidget {
  final VoidCallback onpress;
  final String avator,
      name,
      sentence,
      check,
      clinic,
      eyes,
      hearts,
      chats;
  final List<Image_model> images;
  final List<Category> type;
  const Counseling_Card(
      {Key? key,
      required this.onpress,
      required this.avator,
      required this.name,
      required this.images,
      required this.sentence,
      required this.type,
      required this.clinic,
      required this.check,
      required this.hearts,
      required this.chats,
      required this.eyes,})
      : super(key: key);

  @override
  State<Counseling_Card> createState() => _Counseling_CardState();
}

class _Counseling_CardState extends State<Counseling_Card> {
  String type='';
  @override
  void initState(){
    for(int i=0;i<widget.type.length;i++)
      type+=widget.type[i].name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Helper.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GestureDetector(
            onTap: widget.onpress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Userpage');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.avator,
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
                        width: 5,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Helper.titleColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.sentence,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: Helper.headFontFamily,
                        fontSize: 14,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
                        color: Helper.titleColor),
                  ),
                ),
                Container(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemCount: widget.images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        crossAxisCount: 4,
                        childAspectRatio: 1
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 78,
                        height: 78,
                        child: 
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.images[index].path,
                                placeholder: (context, url) => Image.asset(
                                  'assets/images/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/profile.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          
                        
                      );
                    }
                  ),
                ),
                // SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: SvgPicture.asset(
                          "assets/icons/menubar/ping.svg",
                          width: 12,
                          height: 12,
                        ),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        type,
                        style: TextStyle(
                            fontSize: 12,
                            
                            fontWeight: FontWeight.w400,
                            color: Helper.maintxtColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: SvgPicture.asset(
                          "assets/icons/menubar/clinic.svg",
                          width: 12,
                          height: 12,
                        ),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        widget.clinic,
                        style: TextStyle(
                            fontSize: 12,
                            
                            fontWeight: FontWeight.w400,
                            color: Helper.maintxtColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: SvgPicture.asset(
                          "assets/icons/menubar/part.svg",
                          width: 12,
                          height: 12,
                        ),
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        widget.check,
                        style: TextStyle(
                            fontSize: 12,
                            
                            fontWeight: FontWeight.w400,
                            color: Helper.maintxtColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/menubar/eye.svg",
                              width: 13,
                              height: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.eyes,
                              style: TextStyle(
                                  fontSize: 11,
                                  
                                  fontWeight: FontWeight.w400,
                                  color: Helper.maintxtColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              "assets/icons/menubar/heart.svg",
                              width: 13,
                              height: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.hearts,
                              style: TextStyle(
                                  fontSize: 11,
                                  
                                  fontWeight: FontWeight.w400,
                                  color: Helper.maintxtColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              "assets/icons/menubar/comment.svg",
                              width: 16,
                              height: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.chats,
                              style: TextStyle(
                                  fontSize: 11,
                                  
                                  fontWeight: FontWeight.w400,
                                  color: Helper.maintxtColor),
                            )
                          ]),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

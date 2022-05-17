import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:nb_utils/nb_utils.dart';

class Question_Card extends StatefulWidget {
  final VoidCallback onpress;
  final String avator,
      name,
      image1,
      image2,
      sentence,
      type,
      eyes,
      hearts,
      chats;
  final bool isanswer;
  const Question_Card({
    Key? key,
    required this.onpress,
    required this.avator,
    required this.name,
    required this.image1,
    required this.image2,
    required this.sentence,
    required this.type,
    required this.hearts,
    required this.chats,
    required this.eyes,
    required this.isanswer,
  }) : super(key: key);

  @override
  State<Question_Card> createState() => _Question_CardState();
}

class _Question_CardState extends State<Question_Card> {
  final apiUrl = dotenv.env["DEV_API_URL"];
  late String image1,image2;
  @override 
  void initState(){
    if(widget.image1.contains("https://")){
      setState(() {
        image1=widget.image1;
      });
    }
    else{
      setState(() {
        image1=apiUrl!+"/"+widget.image1;
      });
    }
    if(widget.image2.contains("https://")){
      setState(() {
        image2=widget.image2;
      });
    }
    else{
      setState(() {
        image2=apiUrl!+"/"+widget.image2;
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Helper.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: widget.onpress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
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
                    SizedBox(width: 5),
                    Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: Helper.headFontFamily,
                          color: Helper.titleColor),
                    ),
                    widget.isanswer?Expanded(
                            child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Helper.mainColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: Text(
                                  "回答あり",
                                  style: TextStyle(
                                      color: Helper.whiteColor,
                                      fontSize: 10,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          )):
                    Expanded(
                            child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Helper.searchBartxtColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: Text(
                                  "回答なし",
                                  style: TextStyle(
                                      color: Helper.whiteColor,
                                      fontSize: 10,
                                      height: 1.5,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ))
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  widget.sentence,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                      color: Helper.titleColor),
                ),
                Container(
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5,
                        crossAxisCount: 4,
                        childAspectRatio: 1),
                    children: [
                      SizedBox(
                        height: 78,
                        width: 78,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: image1,
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
                        height: 78,
                        width: 78,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: image2,
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
                        height: 78,
                        width: 78,
                      ),
                      SizedBox(
                        height: 78,
                        width: 78,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/menubar/ping.svg",
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        widget.type,
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
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
                                  height: 1.5,
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
                                  height: 1.5,
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
                                  height: 1.5,
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

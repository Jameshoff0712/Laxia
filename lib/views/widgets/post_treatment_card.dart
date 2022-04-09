import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail_default.dart';

class Post_Treatment_Card extends StatefulWidget {
  final dynamic post_treatment;
  const Post_Treatment_Card({ Key? key, this.post_treatment}) : super(key: key);

  @override
  State<Post_Treatment_Card> createState() => _Post_Treatment_CardState();
}

class _Post_Treatment_CardState extends State<Post_Treatment_Card> {
  @override
  Widget build(BuildContext context) {
    if(widget.post_treatment["post_list"]["isvideo"]!){
      return Container(
        width: double.infinity,
        child: Column(children: [
           Row(children: [
             Container(
               width: 20,
               height: 20,
               decoration: BoxDecoration(color: Helper.mainColor,borderRadius: BorderRadius.circular(10)),
             ),
             SizedBox(width: 10,),
             Text(
                widget.post_treatment["post_list"]["label"],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Helper.titleColor,
                ),
              ),
           ],),
           SizedBox(height: 5,),
           Padding(
             padding: EdgeInsets.only(left: 10),
             child: Container(
               decoration: BoxDecoration(border: Border(left:BorderSide(color:Helper.txtColor) ),),
               child: Padding(
                 padding: EdgeInsets.only(left: 10,top: 5),
                 child: Column(
                   children: [
                     FittedBox(
                      fit: BoxFit.fill,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: widget.post_treatment["video"],
                              placeholder: (context, url) => Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.fill,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/profile.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                    ),
                     Text(
                        widget.post_treatment["description"],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Helper.titleColor,
                        ),
                      ),
                      Bottom_Widget()
                   ],
                 ),
               ),
              ),
           ),
           
        ],),
      );
    }
    switch (widget.post_treatment["post_list"]["images"].length) {
      case 1 : return GestureDetector(
        onTap: (){
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryDetailDefault(isMyDiary: true,),));
        },
        child: Container(
          width: double.infinity,
          child: Column(children: [
             Row(children: [
               Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(color: Helper.mainColor,borderRadius: BorderRadius.circular(10)),
               ),
               SizedBox(width: 10,),
               Text(
                  widget.post_treatment["post_list"]["label"],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Helper.titleColor,
                  ),
                ),
             ],),
             SizedBox(height: 5,),
             Padding(
               padding: EdgeInsets.only(left: 10),
               child: Container(
                 decoration: BoxDecoration(border: Border(left:BorderSide(color:Helper.txtColor) ),),
                 child: Padding(
                   padding: EdgeInsets.only(left: 10,top: 5),
                   child: Column(
                     children: [
                       Image_Widget(context,0),
                       Text(
                          widget.post_treatment["description"],
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Helper.titleColor,
                          ),
                        ),
                        Bottom_Widget()
                     ],
                   ),
                 ),
                ),
             ),
             
          ],),
        ),
      );
      case 2 : return GestureDetector(
        onTap: (){
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryDetailDefault(isMyDiary: true,),));
        },
        child: Container(
          width: double.infinity,
          child: Column(children: [
             Row(children: [
               Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(color: Helper.mainColor,borderRadius: BorderRadius.circular(10)),
               ),
               SizedBox(width: 10,),
               Text(
                  widget.post_treatment["post_list"]["label"],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Helper.titleColor,
                  ),
                ),
             ],),
             SizedBox(height: 5,),
             Padding(
               padding: EdgeInsets.only(left: 10),
               child: Container(
                 decoration: BoxDecoration(border: Border(left:BorderSide(color:Helper.txtColor) ),),
                 child: Padding(
                   padding: EdgeInsets.only(left: 10,top: 5),
                   child: Column(
                     children: [
                       GridView(
                         physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:1,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                         children: [
                            Image_Widget(context,0),
                            Image_Widget(context,1),
                        ],
                       ),
                        Text(
                            widget.post_treatment["description"],
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Helper.titleColor,
                            ),
                          ),
                        Bottom_Widget()
                      ],
                   ),
                 ),
                ),
             ),
             
          ],),
        ),
      );
      case 3 : return GestureDetector(
        onTap: (){
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryDetailDefault(isMyDiary: true,),));
        },
        child: Container(
          width: double.infinity,
          child: Column(children: [
             Row(children: [
               Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(color: Helper.mainColor,borderRadius: BorderRadius.circular(10)),
               ),
               SizedBox(width: 10,),
               Text(
                  widget.post_treatment["post_list"]["label"],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Helper.titleColor,
                  ),
                ),
             ],),
             SizedBox(height: 5,),
             Padding(
               padding: EdgeInsets.only(left: 10),
               child: Container(
                 decoration: BoxDecoration(border: Border(left:BorderSide(color:Helper.txtColor) ),),
                 child: Padding(
                   padding: EdgeInsets.only(left: 10,top: 5),
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Expanded(
                             flex: 2,
                             child: Container(
                               child: GridView(
                                 physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio:1,
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                                 children: [
                                   Image_Widget(context,0),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(width: 10,),
                           Expanded(
                                 flex: 1,
                                 child: Container(
                                   child: GridView(
                                      physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio:1,
                                        crossAxisCount: 1,
                                        ),
                                   children:[ 
                                     Padding(
                                       padding: const EdgeInsets.only(bottom:5.0),
                                       child: Image_Widget(context,1),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.only(top:5.0),
                                       child: Image_Widget(context,2),
                                     ),
                                   ]
                                   ),
                                 ),
                               )
                         ],
                       ),
                      Text(
                          widget.post_treatment["description"],
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Helper.titleColor,
                          ),
                        ),
                        Bottom_Widget()
                     ],
                   ),
                 ),
                ),
             ),
             
          ],),
        ),
      );
      case 4 :return GestureDetector(
        onTap: (){
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryDetailDefault(isMyDiary: true,),));
        },
        child: Container(
          width: double.infinity,
          child: Column(children: [
             Row(children: [
               Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(color: Helper.mainColor,borderRadius: BorderRadius.circular(10)),
               ),
               SizedBox(width: 10,),
               Text(
                  widget.post_treatment["post_list"]["label"],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Helper.titleColor,
                  ),
                ),
             ],),
             SizedBox(height: 5,),
             Padding(
               padding: EdgeInsets.only(left: 10),
               child: Container(
                 decoration: BoxDecoration(border: Border(left:BorderSide(color:Helper.txtColor) ),),
                 child: Padding(
                   padding: EdgeInsets.only(left: 10,top: 5),
                   child: Column(
                     children: [
                       GridView(
                         physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:1,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                         children: [
                           Image_Widget(context,0),
                           Image_Widget(context,1),
                           Image_Widget(context,2),
                           Image_Widget(context,3),
                        ],
                       ),
                      Text(
                          widget.post_treatment["description"],
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Helper.titleColor,
                          ),
                        ),
                        Bottom_Widget()
                      ],
                   ),
                 ),
                ),
             ),
             
          ],),
        ),
      );
      case 5 : return GestureDetector(
        onTap: (){
           Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryDetailDefault(isMyDiary: true,),));
        },
        child: Container(
          width: double.infinity,
          child: Column(children: [
             Row(children: [
               Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(color: Helper.mainColor,borderRadius: BorderRadius.circular(10)),
               ),
               SizedBox(width: 10,),
               Text(
                  widget.post_treatment["post_list"]["label"],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Helper.titleColor,
                  ),
                ),
             ],),
             SizedBox(height: 5,),
             Padding(
               padding: EdgeInsets.only(left: 10),
               child: Container(
                 decoration: BoxDecoration(border: Border(left:BorderSide(color:Helper.txtColor) ),),
                 child: Padding(
                   padding: EdgeInsets.only(left: 10,top: 5),
                   child: Column(
                     children: [
                       GridView(
                         physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:1,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                         children: [
                            Image_Widget(context,0),
                            Image_Widget(context,1),
                        ],
                       ),
                       GridView(
                         physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:1,
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                         children: [
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Image_Widget(context,2),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Image_Widget(context,3),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Image_Widget(context,4),
                            ),
                        ],
                       ),
                        Text(
                            widget.post_treatment["description"],
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Helper.titleColor,
                            ),
                          ),
                        Bottom_Widget()
                      ],
                   ),
                 ),
                ),
             ),
             
          ],),
        ),
      );
      case 6 : return GestureDetector(
        onTap: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => DiaryDetailDefault(isMyDiary: true,),));
        },
        child: Container(
          width: double.infinity,
          child: Column(children: [
             Row(children: [
               Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(color: Helper.mainColor,borderRadius: BorderRadius.circular(10)),
               ),
               SizedBox(width: 10,),
               Text(
                  widget.post_treatment["post_list"]["label"],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Helper.titleColor,
                  ),
                ),
             ],),
             SizedBox(height: 5,),
             Padding(
               padding: EdgeInsets.only(left: 10),
               child: Container(
                 decoration: BoxDecoration(border: Border(left:BorderSide(color:Helper.txtColor) ),),
                 child: Padding(
                   padding: EdgeInsets.only(left: 10,top: 5),
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Expanded(
                             flex: 2,
                             child: GridView(
                               physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio:1,
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                               children: [
                                 Image_Widget(context,0),
                               ],
                             ),
                           ),
                           SizedBox(width: 10,),
                           Expanded(
                                 flex: 1,
                                 child: GridView(
                                    physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio:1,
                                      crossAxisCount: 1),
                                 children:[ 
                                   Padding(
                                    padding: const EdgeInsets.only(bottom:5.0),
                                    child: Image_Widget(context,1),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:5.0),
                                    child: Image_Widget(context,2),
                                  ),
                                 ]
                                 ),
                               )
                         ],
                       ),
                       GridView(
                         physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio:1,
                            crossAxisCount: 3,
                            crossAxisSpacing: 10),
                         children: [
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Image_Widget(context,3),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Image_Widget(context,4),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: Image_Widget(context,5),
                            ),
                        ],
                       ),
                      Text(
                          widget.post_treatment["description"],
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Helper.titleColor,
                          ),
                        ),
                        Bottom_Widget()
                     ],
                   ),
                 ),
                ),
             ),
             
          ],),
        ),
      );
      default: return Container();
    }
  }
  Row Bottom_Widget() {
    return Row(
      children: [
        Expanded(
            child: Align(
          alignment: Alignment.centerRight,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  "assets/icons/menubar/heart.svg",
                  width: 13,
                  height: 13,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  widget.post_treatment["favourite"],
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Helper.txtColor),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      "assets/icons/menubar/comment.svg",
                      width: 13,
                      height: 13,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      widget.post_treatment["chat"],
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Helper.txtColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                      )
              ]),
        ))
      ],
    );
  }

  FittedBox Image_Widget(BuildContext context,int index) {
    return FittedBox(
      fit: BoxFit.fill,
      child: SizedBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: widget.post_treatment["post_list"]["images"][index],
              placeholder: (context, url) => Image.asset(
                'assets/images/loading.gif',
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
    );
  }
}
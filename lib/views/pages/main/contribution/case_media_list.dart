import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laxia/models/menu/image_model.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_viewer/image_viewer.dart';

class CaseMediaList extends StatefulWidget {
  final List<Image_model> beforeimage,afterimage;
  final String name;
  const CaseMediaList({Key? key, required this.beforeimage, required this.afterimage, required this.name}) : super(key: key);
  @override
  _CaseMediaListState createState() => _CaseMediaListState();
}

class _CaseMediaListState extends StateMVC<CaseMediaList> {
  bool isfavourite = false;

  @override
  void initState() {
    print('object');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Center(
          child: Text(
            widget.name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Container(
          color: Helper.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "施術前",
                  style: TextStyle(color: Helper.appTxtColor, fontSize: 15),
                ),
              ),
              Container(
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 3.5,
                      crossAxisSpacing: 7,
                      crossAxisCount: 3,
                      childAspectRatio: 1),
                  children: [
                    for (int i = 0;
                        i < widget.beforeimage.length;
                        i++)
                      FittedBox(
                        fit: BoxFit.fill,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget(
                              onBoardingInstructions: [
                                for (int j = 0;
                                    j <
                                        widget.beforeimage
                                            .length;
                                    j++)
                                   widget.beforeimage[j].path,
                              ],
                              startindex: i,
                            )));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:  widget.beforeimage[i].path,
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
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "施術後",
                  style: TextStyle(color: Helper.appTxtColor, fontSize: 15),
                ),
              ),
              Container(
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 3.5,
                      crossAxisSpacing: 7,
                      crossAxisCount: 3,
                      childAspectRatio: 1),
                  children: [
                    for (int i = 0;
                        i < widget.afterimage.length;
                        i++)
                      FittedBox(
                        fit: BoxFit.fill,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget(onBoardingInstructions: [
                                for (int j = 0;
                                    j <
                                         widget.afterimage
                                            .length;
                                    j++)
                                  widget.beforeimage[j].path,
                              ],
                              startindex: 1,)));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:  widget.afterimage[i].path,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

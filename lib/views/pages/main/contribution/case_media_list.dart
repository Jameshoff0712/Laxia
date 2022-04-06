import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_viewer/image_viewer.dart';

class CaseMediaList extends StatefulWidget {
  @override
  _CaseMediaListState createState() => _CaseMediaListState();
}

class _CaseMediaListState extends StateMVC<CaseMediaList> {
  List disease_Details = [];
  bool isfavourite = false;

  Future<void> get_disease_info() async {
    String mid = await rootBundle.loadString("cfg/detail_disease.json");
    setState(() {
      disease_Details.addAll(json.decode(mid));
    });
  }

  @override
  void initState() {
    get_disease_info();
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
            disease_Details[0]["name"],
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
                        i < disease_Details[0]["image_before"].length;
                        i++)
                      FittedBox(
                        fit: BoxFit.fill,
                        child: InkWell(
                          onTap: () {
                            ImageViewer.showImageSlider(
                              images: [
                                for (int j = 0;
                                    j <
                                        disease_Details[0]["image_before"]
                                            .length;
                                    j++)
                                  disease_Details[0]["image_before"][j],
                              ],
                              startingPosition: 1,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: disease_Details[0]["image_before"][i],
                              placeholder: (context, url) => Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.fill,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/ProDoctor.png',
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
                        i < disease_Details[0]["image_after"].length;
                        i++)
                      FittedBox(
                        fit: BoxFit.fill,
                        child: InkWell(
                          onTap: () {
                            ImageViewer.showImageSlider(
                              images: [
                                for (int j = 0;
                                    j <
                                        disease_Details[0]["image_after"]
                                            .length;
                                    j++)
                                  disease_Details[0]["image_after"][j],
                              ],
                              startingPosition: 1,
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: disease_Details[0]["image_after"][i],
                              placeholder: (context, url) => Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.fill,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/ProDoctor.png',
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

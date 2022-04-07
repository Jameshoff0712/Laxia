import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:laxia/common/helper.dart';


class Diary_MediaList extends StatefulWidget {
  final List post_treatment;
  const Diary_MediaList({ Key? key, required this.post_treatment}) : super(key: key);

  @override
  State<Diary_MediaList> createState() => _Diary_MediaListState();
}

class _Diary_MediaListState extends State<Diary_MediaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'たっきーの写真一覧',
          style: TextStyle(
            fontWeight: FontWeight.w400,
              fontSize: 16,
              color:Helper.titleColor)
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            for(int i=0;i<widget.post_treatment.length;i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post_treatment[i]["label"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color:Helper.titleColor)
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:1,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                        itemCount: widget.post_treatment[i]["post_list"]["images"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image_Widget(context,index,i);
                  }),
                ],
              ),
          ],),
        ),
      ),
    );
  }
  FittedBox Image_Widget(BuildContext context,int imageUrl,int index) {
    return FittedBox(
      fit: BoxFit.fill,
      child: InkWell(
        onTap: (){
          ImageViewer.showImageSlider(
              images: [
                for (int j = 0; j < widget.post_treatment[index]["post_list"]["images"].length; j++)
                   widget.post_treatment[index]["post_list"]["images"][j]
              ],
              startingPosition: imageUrl,
            );
        },
        child: SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.post_treatment[index]["post_list"]["images"][imageUrl],
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
    );
  }
}

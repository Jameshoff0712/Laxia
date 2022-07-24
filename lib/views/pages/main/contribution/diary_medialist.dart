import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/diary/diary/progress.dart';
import 'package:laxia/models/question/media_model.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';


class Diary_MediaList extends StatefulWidget {
  final List<Media_model> before_medias;
  final List<Progress> processes;
  const Diary_MediaList({ Key? key, required this.processes, required this.before_medias}) : super(key: key);

  @override
  State<Diary_MediaList> createState() => _Diary_MediaListState();
}

class _Diary_MediaListState extends State<Diary_MediaList> {
  @override
  void initState(){
    super.initState();
  }
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
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "施術前",
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
                        itemCount: widget.before_medias.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image_Widget(context,index,widget.before_medias);
                  }),
                ],
              ),
            for(int i=0;i<widget.processes.length;i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "施術"+widget.processes[i].from_treat_day.toString()+"日後",
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
                        itemCount: widget.processes[i].medias.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image_Widget(context,index,widget.processes[i].medias);
                  }),
                ],
              ),
          ],),
        ),
      ),
    );
  }
  FittedBox Image_Widget(BuildContext context,int startindex,List<Media_model> medias) {
    return FittedBox(
      fit: BoxFit.fill,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
                                   MaterialPageRoute(
                            builder: (context) => PageViewWidget( onBoardingInstructions: [
                for (int j = 0; j < medias.length; j++)
                  medias[j].path
              ],
              startindex: startindex,)));
        },
        child: SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: medias[startindex].path,
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

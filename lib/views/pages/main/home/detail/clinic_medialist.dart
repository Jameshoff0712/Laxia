import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_viewer/image_viewer.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/views/widgets/generated_plugin_registrant.dart';


class Clinic_MediaList extends StatefulWidget {
  final List clinic_list;
  const Clinic_MediaList({ Key? key, required this.clinic_list}) : super(key: key);

  @override
  State<Clinic_MediaList> createState() => _Clinic_MediaListState();
}

class _Clinic_MediaListState extends State<Clinic_MediaList> {
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
          child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                      itemCount: widget.clinic_list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image_Widget(context,index);
                }),
        ),
      ),
    );
  }
  FittedBox Image_Widget(BuildContext context,int imageUrl) {
    return FittedBox(
      fit: BoxFit.fill,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
                    MaterialPageRoute(
            builder: (context) => PageViewWidget(onBoardingInstructions: [
                for (int j = 0; j < widget.clinic_list.length; j++)
                   widget.clinic_list[j]
              ],
              startindex: imageUrl,)));
        },
        child: SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.clinic_list[imageUrl],
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';

class QuestionFixPostPage extends StatefulWidget {
  const QuestionFixPostPage({Key? key}) : super(key: key);

  @override
  State<QuestionFixPostPage> createState() => _QuestionFixPostPageState();
}

class _QuestionFixPostPageState extends State<QuestionFixPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          '質問内容を入力',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Helper.titleColor,
              size: 25,
            )),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24, bottom: 6, left: 16, right: 16),
            child: Text(
              '質問したい施術内容',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                
                color: Helper.maintxtColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            color: Helper.whiteColor,
            child: Text(
              '二重切開 , 目頭切開',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.3,
                color: Color.fromARGB(255, 18, 18, 18),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, bottom: 6, left: 16, right: 16),
            child: Text(
              '質問内容',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                
                color: Helper.maintxtColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            color: Helper.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '二重切開について質問したいです！',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    
                    color: Helper.titleColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'この二重幅にしたい場合は埋没の方が良いのか、それとも切開の方が良いのか教えていただきたいです！',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.3,
                    color: Helper.titleColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //PhotoCarouselWidget(offerList: _con.offers, heroTag: 'offer_trending_carousel'),
                            _buildPhoto(),
                            _buildPhoto(),
                            _buildPhoto(),
                            _buildPhoto(),
                            _buildPhoto(),
                            _buildPhoto(),
                            _buildPhoto(),
                            _buildPhoto(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 62),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Helper.mainColor,
                    )),
                child: Text(
                  "編集を完了",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    
                    color: Helper.mainColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPhoto() {
    return Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl:
              'https://res.cloudinary.com/ladla8602/image/upload/v1611921105/DCA/doctor-1.jpg',
          placeholder: (context, url) => Image.asset(
            'assets/images/loading.gif',
            fit: BoxFit.cover,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}

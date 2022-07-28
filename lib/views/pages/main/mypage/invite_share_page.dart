import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/my_controller.dart';

class InviteSharePage extends StatefulWidget {
  const InviteSharePage({Key? key}) : super(key: key);

  @override
  State<InviteSharePage> createState() => _InviteSharePageState();
}

class _InviteSharePageState extends State<InviteSharePage> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Helper.whiteColor,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'あなたが使うと私もおトク！\nタクシーアプリGO使ってみてください。',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    
                    color: Helper.titleColor,
                  ),
                ),
                Expanded(child: Container()),
                IconButton(
                  splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Helper.titleColor,
                      size: 30,
                    )),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildSingleUser(),
                  _buildSingleUser(),
                  _buildSingleUser(),
                  _buildSingleUser(),
                  _buildSingleUser(),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSocialLink(),
                _buildSocialLink(),
                _buildSocialLink(),
                _buildSocialLink(),
                _buildSocialLink(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Color.fromARGB(255, 245, 245, 245),
                filled: true,
                suffixIcon: GestureDetector(
                  child: Icon(Icons.file_copy_outlined,
                      color: Helper.maintxtColor),
                ),
              ),
              onChanged: (text) {},
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Color.fromARGB(255, 245, 245, 245),
                filled: true,
                suffixIcon: GestureDetector(
                  child: Icon(Icons.folder, color: Helper.maintxtColor),
                ),
              ),
              onChanged: (text) {},
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildSingleUser() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70 / 2),
                child: Image.asset(
                  "assets/icons/menubar/doubles.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
                child: Text(
              "Rina",
              style: TextStyle(
                  color: Helper.unSelectSmallTabColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ))
          ],
        ),
      ),
    );
  }

  GestureDetector _buildSocialLink() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.red),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/icons/menubar/doubles.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
                child: Text(
              "Rina",
              style: TextStyle(
                  color: Helper.unSelectSmallTabColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ))
          ],
        ),
      ),
    );
  }
}

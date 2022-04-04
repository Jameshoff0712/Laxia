import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:laxia/common/helper.dart';
// import 'package:webview_flutter/webview_flutter.dart';


class DeletionGuideWeb extends StatefulWidget {
  const DeletionGuideWeb({Key? key}) : super(key: key);

  @override
  State<DeletionGuideWeb> createState() => _DeletionGuideWebState();
}

class _DeletionGuideWebState extends State<DeletionGuideWeb> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          '利用規約',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.5,
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Helper.mainColor,
              size: 30,
            )),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://flutter.dev')),
      ),
    );
  }
}

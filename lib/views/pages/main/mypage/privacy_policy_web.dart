import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:laxia/common/helper.dart';
// import 'package:webview_flutter/webview_flutter.dart';


class PrivacyPolicyWeb extends StatefulWidget {
  const PrivacyPolicyWeb({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyWeb> createState() => _PrivacyPolicyWebState();
}

class _PrivacyPolicyWebState extends State<PrivacyPolicyWeb> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'プライバシーポリシー',
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

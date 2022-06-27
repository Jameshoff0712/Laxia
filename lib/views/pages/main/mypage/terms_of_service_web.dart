import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:laxia/common/helper.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class TermsOfServiceWeb extends StatefulWidget {
  const TermsOfServiceWeb({Key? key}) : super(key: key);

  @override
  State<TermsOfServiceWeb> createState() => _TermsOfServiceWebState();
}

class _TermsOfServiceWebState extends State<TermsOfServiceWeb> {
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
              color: Helper.mainColor,
              size: 30,
            )),
        elevation: 0,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://flutter.dev')),
      ),
    );
  }
}

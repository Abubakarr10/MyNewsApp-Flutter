import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utilities/app_text.dart';

class ArticleWebView extends StatelessWidget {
  final String url;
  final String title;

  const ArticleWebView({super.key, required this.url, required this.title});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: AppText(title: title,textColor: Colors.white,),
        leading: InkWell(
            onTap: (){Get.back();},
            child: const Icon(Icons.backspace,)),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

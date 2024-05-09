import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_news_app/utilities/app_text.dart';

class NewsDetailScreen extends StatefulWidget {
  String? newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
   NewsDetailScreen(
      {super.key,
      required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.content,
      required this.source});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double heightX = Get.height * 1;
    double widthX = Get.width * 1;
    if (kDebugMode) {
      print(widget.newsImage);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SizedBox(
            height: heightX * 0.45,
            width: widthX,
            child: CachedNetworkImage(
              imageUrl:  widget.newsImage.toString(),
              fit: BoxFit.cover,
              height: heightX * 0.20,
              width: widthX * 0.3,
              placeholder: (context, url) =>
              const SpinKitDualRing(
                color: Colors.redAccent,
                size: 40,
              ),
              errorWidget: (context, url, error) =>
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: heightX * 0.4),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white, //Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                  )
                    ),
                child: Column(
                  children: [
                    AppSimpleText(
                      title: widget.newsTitle.toString(),
                      textFontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    SizedBox(height: heightX * .01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppSimpleText(title: widget.source.toString(), textColor: Colors.blue, textFontWeight: FontWeight.w700,),
                        AppSimpleText(title: widget.newsDate.toString())
                      ],
                    ),
                    SizedBox(height: heightX * .02,),
                    AppSimpleText(title:  'Author: ${widget.author}' ),
                    SizedBox(height: heightX * .01,),
                    AppSimpleText(title: widget.description.toString()),
                    SizedBox(height: heightX * .03,),
                    AppSimpleText(title: widget.content.toString()),
                    SizedBox(height: heightX * .05,),
                    TextButton(
                        onPressed: (){},
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                        child: const AppSimpleText(title: 'Read full article',textColor: Colors.white,),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

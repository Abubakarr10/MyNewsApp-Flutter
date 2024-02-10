import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_news_app/utilities/app_text.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  const NewsDetailScreen(
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
              imageUrl: widget.newsImage,
              fit: BoxFit.cover,
              placeholder: (context, uri) => const Center(
                child: SpinKitDancingSquare(
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: heightX * 0.4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                  ),
                  child: ListView(
                    children: [AppText(title: widget.newsTitle)],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

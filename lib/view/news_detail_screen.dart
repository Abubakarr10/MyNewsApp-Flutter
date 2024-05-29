import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_news_app/controller/saveArticleFire/save_article_fire_controller.dart';
import 'package:my_news_app/model/save_article_model.dart';
import 'package:my_news_app/utilities/app_text.dart';
import 'package:my_news_app/view/article_webview_screen.dart';
import 'package:my_news_app/view/login_signup/login_screen.dart';

class NewsDetailScreen extends StatefulWidget {
 final String? newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      newsUrl,
      source;
 final String savedArticleID;
 final bool? deleteArticle;
   const NewsDetailScreen(
      {super.key,
      required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.newsUrl,
      required this.content,
      required this.source,
        this.deleteArticle = false, this.savedArticleID =''});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {


  SaveArticleFireController saveArticleFireController = SaveArticleFireController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double heightX = Get.height * 1;
    double widthX = Get.width * 1;

    final user = FirebaseAuth.instance.currentUser;

    String cleanContent = removePattern(widget.content.toString());

    if (kDebugMode) {
      print(widget.newsImage);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const AppText(title: "MY NEWS", fontSize: 24, textColor: Colors.red,textFontWeight: FontWeight.bold,),
      ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    AppSimpleText(title: cleanContent),
                    SizedBox(height: heightX * .05,),

                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: user != null? SizedBox(
                              child: widget.deleteArticle == false?
                              ElevatedButton(
                                  onPressed: ()async{

                                    SaveArticleModel saveArticle = SaveArticleModel(
                                        userID: user.uid.toString(),
                                        title: widget.newsTitle.toString(),
                                        description: widget.description.toString(),
                                        source: widget.source.toString(),
                                        url: widget.newsUrl.toString(),
                                        urlToImage: widget.newsImage.toString(),
                                        content: cleanContent,
                                        author: widget.author.toString(),
                                        publishedAt: widget.newsDate.toString()
                                    );

                                    saveArticleFireController.saveArticle(saveArticle, user.uid);

                                  },
                                  child: const AppText(title: 'Save Article',)):
                              ElevatedButton(
                                  onPressed: ()async{
                                    if(widget.savedArticleID!='')
                                    deleteDocument(widget!.savedArticleID);
                                  },
                                  child: const AppText(title: 'Delete Article',))
                              ,
                            )
                            :
                            ElevatedButton(
                                onPressed: ()async{
                                  Get.to(()=> const LoginScreen());
                                },
                                child: const AppText(title: 'First Login To Save Article',)),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red
                              ),
                              onPressed: ()async{
                                Get.to(()=> ArticleWebView(
                                    url: widget.newsUrl.toString(),
                                    title: widget.newsTitle.toString()
                                ));
                              },
                              child: const AppText(title: 'Read Full Article',textColor: Colors.white,)),
                        ],
                      ),
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
  String removePattern(String content) {
    // Regular expression to find the pattern
    final pattern = RegExp(r'\s*\(\.\.\.\s*\[\+\d+\s*chars\]\s*\)');
    return content.replaceAll(pattern, '');
  }


  void deleteDocument(String docId) async {
    try {
      await firestore.collection('saveArticles').doc(docId).delete();
      Get.snackbar(
          'Done!', 'Successfully Deleted',
          icon: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.done_sharp,
              size: 30,
              color: Colors.lightGreen,
            ),
          ),
          backgroundColor: Colors.blue,
          colorText: Colors.white
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting document: $e');
      }
    }
  }

}

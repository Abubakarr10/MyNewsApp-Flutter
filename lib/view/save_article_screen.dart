import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:my_news_app/controller/saveArticleFire/save_article_fire_controller.dart';
import 'package:my_news_app/model/save_article_model.dart';
import 'package:my_news_app/utilities/app_text.dart';
import 'package:my_news_app/view/login_signup/login_screen.dart';
import 'package:my_news_app/view/news_detail_screen.dart';

import '../controller/select_screen_controller.dart';
import '../utilities/navigation_conts.dart';

class SaveArticlesScreen extends StatefulWidget {
  const SaveArticlesScreen({super.key});

  @override
  State<SaveArticlesScreen> createState() => _SaveArticlesScreenState();
}

class _SaveArticlesScreenState extends State<SaveArticlesScreen> {


  SelectScreenController screenController = Get.put(SelectScreenController());

  final user = FirebaseAuth.instance.currentUser;
  SaveArticleFireController saveArticleFireController = SaveArticleFireController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveArticleFireController.fetchSaveArticleData();
  }

  @override
  Widget build(BuildContext context) {

    double heightX = Get.height * 1;
    double widthX = Get.width * 1;

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){Get.back();},
            child: const Icon(Icons.arrow_back_ios)),
        title: const AppText(title: 'Saved Articles',fontSize: 24,),
      ),
      body: user == null? Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bgImage.jpeg',
            fit: BoxFit.cover,
          ),
          // The blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red.withOpacity(0.7),Colors.black.withOpacity(0.6)],
                begin: FractionalOffset.topLeft, end: AlignmentDirectional.bottomCenter
                )
              ),
            ),
          ),
          // Your foreground content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AppText(
                      title :'Hello! First Login For Saved Articles',
                      fontSize: heightX*.022,
                      textFontWeight: FontWeight.w600,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthX*.06),
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(()=> const LoginScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login,
                            color: Colors.white),
                        SizedBox(width: 8),
                        AppText(title: 'Login',textColor: Colors.white,),
                      ],
                    ),
                ),
              )
            ],
          ),
        ],
      )
          :
      Column(
        children: [


          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('saveArticles').where('userID', isEqualTo: user!.uid.toString()).snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){

                if(snapshot.connectionState == ConnectionState.waiting){
                  return  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: SpinKitDualRing(
                          color: Colors.redAccent,
                          size: 40,
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:AppText(title: 'None Saved Articles', fontSize: 20, textFontWeight: FontWeight.w700),
                      ),
                      ],
                  );
                }

                final articles = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context,index){
                    final article = articles[index];
                    final docID = article.id;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      child: InkWell(
                        onTap: (){
                          Get.to(()=> NewsDetailScreen(
                              newsImage: article['urlToImage'],
                              newsTitle: article['title'],
                              newsDate: article['publishedAt'],
                              author: article['author'],
                              description: article['description'],
                              newsUrl: article['url'],
                              content: article['content'],
                              source: article['source'],
                            deleteArticle: true,
                            savedArticleID: docID,
                          ));
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: article['urlToImage'].toString(),
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (context, String url) =>
                                  const SpinKitDualRing(
                                    color: Colors.redAccent,
                                    size: 40,
                                  ),
                                  errorWidget:
                                      (context, url, error) =>
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    AppText(title: article['title'],textFontWeight: FontWeight.bold,fontSize: 14,),
                                    AppText(title: article['description'],textFontWeight: FontWeight.normal,),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(title: article['source'],textColor: Colors.blue),
                                    AppText(title: article['publishedAt'],textColor: Colors.red),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
          SizedBox(height: heightX*.080,),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(()=> FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.red,
          shape: const StadiumBorder(),
          label: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(Navi.iconList.length, (int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                      onTap: () {
                        screenController.selectedIndex.value = Navi.checkList[index];
                        Get.to(Navi.screenList.elementAt(index));
                        if (kDebugMode) {
                          print(screenController.selectedIndex.value.toString());
                        }
                      },
                      child: screenController.selectedIndex.value ==  Navi.checkList[index]? Icon(Navi.iconListFilled.elementAt(index),
                          size: 35, color: Colors.white) :
                      Icon(Navi.iconList.elementAt(index),
                          size: 35, color: Colors.black45)),
                );
              }),
            ),
          ))
      ),
    );
  }
}

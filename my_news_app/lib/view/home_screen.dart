import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/controller/filter_news_controller.dart';
import 'package:my_news_app/model/news_channel_headlines_model.dart';
import 'package:my_news_app/utilities/app_text.dart';
import 'package:my_news_app/view/categories_screen.dart';
import 'package:my_news_app/view/news_detail_screen.dart';
import 'package:my_news_app/view_model/news_view_model.dart';

import '../model/news_categories_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, theWashingtonPost, cnnNews, alJazeera, fortune,}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterNewsController fnController = Get.put(FilterNewsController());

  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');
  //String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    double heightX = Get.height * 1;
    double widthX = Get.width * 1;
    if (kDebugMode) {
      print('First print');
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.to(const CategoriesScreen());
            },
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 24,
              width: 24,
            )),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              onSelected: (FilterList item){

                fnController.selectNews(item.name);

              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,),
              itemBuilder: (context)=> <PopupMenuEntry<FilterList>>[
                const PopupMenuItem(
                  value: FilterList.bbcNews,
                  child: Text('BBC News'),
                ),
                const PopupMenuItem(
                  value: FilterList.cnnNews,
                  child: Text('CNN News'),
                ),
                const PopupMenuItem(
                  value: FilterList.alJazeera,
                  child: Text('Al-Jazeera'),
                ),
                const PopupMenuItem(
                  value: FilterList.theWashingtonPost,
                  child: Text('The Washington Post'),
                ),
                const PopupMenuItem(
                  value: FilterList.fortune,
                  child: Text('Fortune'),
                )
          ])
        ],
      ),
      // backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              height: heightX * 0.35,
              width: widthX,
              child: Obx(() =>
                  FutureBuilder<NewsChannelHeadlinesModel>(
                    future: newsViewModel.fetchNewsModelHeadlinesApi(fnController.newsName.value),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitFadingFour(
                        color: Colors.red,
                        size: 50,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        var api = snapshot.data!.articles![index];
                        DateTime dateTime = DateTime.parse(api.publishedAt.toString());
                        return InkWell(
                          onTap: (){
                            Get.to(()=> NewsDetailScreen(
                                newsImage: api.urlToImage.toString(),
                                newsTitle: api.title.toString(),
                                newsDate: format.format(dateTime),
                                author: api.author.toString(),
                                description: api.description.toString(),
                                content: api.content.toString(),
                                source: api.source!.name.toString()
                            ));
                          },
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: heightX * 0.6,
                                  width: widthX * 0.9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widthX * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: api.urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                      const SpinKitDualRing(
                                        color: Colors.redAccent,
                                        size: 40,
                                      ),
                                      errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: heightX * 0.17,
                                      width: widthX * 0.7,
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(api.title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(title: api.source!.name.toString(),fontSize: 12,),
                                              AppText(title: format.format(dateTime), fontSize: 12, textColor: Colors.blue,)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchNewsCategoriesApi('General'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingFour(
                      color: Colors.red,
                      size: 50,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      var api = snapshot.data!.articles![index];
                      DateTime dateTime = DateTime.parse(api.publishedAt.toString());
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: api.urlToImage.toString(),
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
                                  size: 40,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  height: heightX * 0.20,
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      AppText(title: api.title.toString(),
                                        textFontWeight: FontWeight.w700, fontSize: 15,
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(title: api.source!.name.toString(),
                                            textFontWeight: FontWeight.w500, textColor: Colors.blue,
                                            fontSize: 12,
                                          ),
                                          AppText(title: format.format(dateTime), fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

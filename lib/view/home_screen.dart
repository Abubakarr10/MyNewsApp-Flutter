import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/controller/filter_news_controller.dart';
import 'package:my_news_app/controller/select_screen_controller.dart';
import 'package:my_news_app/model/news_channel_headlines_model.dart';
import 'package:my_news_app/utilities/app_text.dart';
import 'package:my_news_app/utilities/navigation_conts.dart';
import 'package:my_news_app/view/categories_screen.dart';
import 'package:my_news_app/view/news_detail_screen.dart';
import 'package:my_news_app/view/profile/profile_screen.dart';
import 'package:my_news_app/view/save_article_screen.dart';
import 'package:my_news_app/view_model/news_view_model.dart';

import '../model/article_model.dart';
import '../model/news_categories_model.dart';
import '../respository/news_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  theWashingtonPost,
  cnnNews,
  alJazeera,
  fortune,
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterNewsController fnController = Get.put(FilterNewsController());

  FilterList? selectedMenu;
  final format = DateFormat('MMM dd, yyyy');
  //String name = 'bbc-news';



  SelectScreenController screenController = Get.put(SelectScreenController());

  @override
  Widget build(BuildContext context) {
    double heightX = Get.height * 1;
    double widthX = Get.width * 1;
    if (kDebugMode) {
      print('First print');
    }
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.to(() => const CategoriesScreen());
              },
              icon: Image.asset(
                'assets/images/category_icon.png',
                height: 24,
                width: 24,
              )),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                title: 'My ',
                fontSize: 24,
                textFontWeight: FontWeight.w700,
              ),
              AppText(
                title: 'News',
                fontSize: 24,
                textFontWeight: FontWeight.w700,
                textColor: Colors.red,
              ),
            ],
          ),
          actions: const [
            Icon(
              Icons.person_2_outlined,
              size: 34,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
          ]),
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
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              /// === Top Headlines Text ===
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      title: 'Top Headlines',
                      fontSize: 24,
                      textFontWeight: FontWeight.w700,
                    ),
                    PopupMenuButton<FilterList>(
                        initialValue: selectedMenu,
                        onSelected: (FilterList item) {
                          fnController.selectNews(item.name);
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          size: 26,
                          color: Colors.black,
                        ),
                        itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
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
                            ]),
                  ],
                ),
              ),

              /// ==Top Headlines News==
              SizedBox(
                height: heightX * 0.35,
                width: widthX,
                child: Obx(() => FutureBuilder<NewsChannelHeadlinesModel>(
                      future: newsViewModel.fetchNewsModelHeadlinesApi(
                          fnController.newsName.value),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                              DateTime dateTime =
                                  DateTime.parse(api.publishedAt.toString());
                              return InkWell(
                                onTap: () {
                                  String newsImage = api.urlToImage == null
                                      ? 'null'
                                      : api.urlToImage.toString();
                                  String newsTitle = snapshot
                                      .data!.articles![index].title
                                      .toString();
                                  String newsDate = format.format(dateTime);
                                  String newsAuthor = snapshot
                                      .data!.articles![index].author
                                      .toString();
                                  String newsDescription = snapshot
                                      .data!.articles![index].description
                                      .toString();
                                  String newsContent = snapshot
                                      .data!.articles![index].content
                                      .toString();
                                  String newsSource = snapshot
                                      .data!.articles![index].source!.name
                                      .toString();
                                  Get.to(() => NewsDetailScreen(
                                      newsImage: newsImage,
                                      newsTitle: newsTitle,
                                      newsDate: newsDate,
                                      author: newsAuthor,
                                      description: newsDescription,
                                      content: newsContent,
                                      source: newsSource));
                                },
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: heightX * 0.7,
                                        width: widthX * 0.9,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: widthX * 0.02),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(60),
                                            topLeft: Radius.circular(60),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: api.urlToImage.toString(),
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
                                      ),
                                      Positioned(
                                        child: Container(
                                          height: heightX * .155,
                                          width: widthX * .83,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: widthX * .002),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(60),
                                                      topRight:
                                                          Radius.circular(60))),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          height: heightX * 0.15,
                                          width: widthX * 0.8,
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 25, 20, 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(api.title.toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: heightX * .014,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  )),
                                              const Spacer(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppText(
                                                    title: api.source!.name
                                                        .toString(),
                                                    fontSize: 12,
                                                    textColor: Colors.white,
                                                  ),
                                                  AppText(
                                                    title:
                                                        format.format(dateTime),
                                                    fontSize: 12,
                                                    textColor: Colors.blue,
                                                  )
                                                ],
                                              )
                                            ],
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

              /// === Trending Text ===
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 30, bottom: 20),
                    child: AppText(
                      title: 'Trending',
                      fontSize: 24,
                      textFontWeight: FontWeight.w700,
                    ),
                  )),
              // ==General News Categories==
              Padding(
                padding: const EdgeInsets.all(15),
                child: FutureBuilder(
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
                      List<Article> articles = snapshot.data as List<Article>;
                      return ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Article article = articles[index];
                          DateTime dateTime =
                              DateTime.parse(article.publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => NewsDetailScreen(
                                    newsImage: article.urlToImage.toString(),
                                    newsTitle: article.title.toString(),
                                    newsDate: format.format(dateTime),
                                    author: article.author.toString(),
                                    description: article.description.toString(),
                                    content: article.content.toString(),
                                    source: article.author.toString()));
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: article.urlToImage.toString(),
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
                                        AppText(
                                          title: article.title.toString(),
                                          textFontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              title: article.author.toString(),
                                              textFontWeight: FontWeight.w500,
                                              textColor: Colors.blue,
                                              fontSize: 12,
                                            ),
                                            // === date ===
                                            AppText(
                                              title: format.format(dateTime),
                                              fontSize: 12,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
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
        ),
      ),
    );
  }
}

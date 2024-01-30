import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/model/news_channel_headlines_model.dart';
import 'package:my_news_app/utilities/app_text.dart';
import 'package:my_news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    double heightX = Get.height * 1;
    double widthX = Get.width * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 30,
              width: 30,
            )),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      // backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              height: heightX * 0.35,
              width: widthX,
              child: FutureBuilder<NewsChannelHeadlinesModel>(
                future: newsViewModel.fetchNewsModelHeadlinesApi(),
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
                        return Stack(
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
                                child: Container(
                                  height: heightX * 0.1,
                                  child: Column(
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
                                        children: [
                                          AppText(title: api.source!.name.toString())
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

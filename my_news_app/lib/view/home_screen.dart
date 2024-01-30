import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/model/news_channel_headlines_model.dart';
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
            onPressed: (){},
            icon: Image.asset('assets/images/category_icon.png',
            height: 30, width: 30,
            )),
        title: Text('News', style: GoogleFonts.poppins(
          fontSize: 24, fontWeight: FontWeight.w700
        ),),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: heightX * 0.55,
            width: widthX,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.fetchNewsModelHeadlinesApi(),
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: SpinKitFadingFour(
                      color: Colors.red,
                      size: 50,
                    ),
                  );
                }else{
                 return ListView.builder(
                     itemCount: snapshot.data!.articles!.length,
                   itemBuilder: (BuildContext context, int index) {
                       var api = snapshot.data!.articles![index];
                       return Stack(
                         alignment: Alignment.center,
                         children: [
                           CachedNetworkImage(
                               imageUrl: api.urlToImage.toString(),
                             fit: BoxFit.cover,
                             placeholder: (context, url)=> const SpinKitDualRing(color: Colors.redAccent,size: 40,),
                             errorWidget: (context, url, error)=> const Icon(
                               Icons.error_outline,
                               color: Colors.red,size: 40,),
                           )
                         ],
                       );
                   },);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

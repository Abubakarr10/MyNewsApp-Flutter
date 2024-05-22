import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Get.off(()=> const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    double heightX = Get.height *1;
    double widthX = Get.width *1;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: heightX * 0.4,
              width: widthX * 0.6,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(60),
                image: const DecorationImage(image: AssetImage('assets/images/news_app_logo.png'),
                fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: heightX * 0.004,),
            Text('MY NEWS', style: GoogleFonts.anton(
              letterSpacing: 0.6, color: Colors.red, fontSize: 46
            ),),
            SizedBox(height: heightX * 0.004,),
            const SpinKitDoubleBounce(
              color: Colors.red,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}

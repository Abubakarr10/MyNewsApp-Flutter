import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_news_app/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/share_preferences/share_preferences_controller.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  bool isLoggedIn = await getLoginStatus();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(isLoggedIn: isLoggedIn,));
}


class MyApp extends StatelessWidget {
final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'My News',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


import 'package:flutter/material.dart';

import '../view/categories_screen.dart';
import '../view/home_screen.dart';
import '../view/profile/profile_screen.dart';
import '../view/save_article_screen.dart';
//
class Navi{

 static List<IconData> iconList = [
    Icons.home_outlined,
    Icons.dashboard_outlined,
    Icons.save_outlined,
    Icons.person_2_outlined
  ];

 static List screenList = [
    const HomeScreen(),
    const CategoriesScreen(),
    const SaveArticlesScreen(),
    const ProfileScreen(),
  ];

 static List<IconData> iconListFilled = [
    Icons.home,
    Icons.dashboard,
    Icons.save,
    Icons.person
  ];

 static List<int> checkList = [
    0,1,2,3
  ];

}
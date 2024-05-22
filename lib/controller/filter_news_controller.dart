import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../view/home_screen.dart';

class FilterNewsController extends GetxController{

  RxString newsName = 'bbc-news'.obs;

  selectNews(String chooseItemName){
        if(FilterList.bbcNews.name == chooseItemName){
          newsName.value = 'bbc-news';
        }
        if(FilterList.fortune.name == chooseItemName){
          newsName.value = 'fortune';
        }
        if(FilterList.cnnNews.name == chooseItemName){
          newsName.value = 'cnn';
        }
        if(FilterList.alJazeera.name == chooseItemName){
          newsName.value = 'al-jazeera-english';
        }
        if(FilterList.theWashingtonPost.name == chooseItemName){
          newsName.value = 'the-washington-post';
        }

        if (kDebugMode) {
          print('GetX Print Hora hai');
        }

}

}
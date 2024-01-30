import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_news_app/model/news_channel_headlines_model.dart';
class NewsRepository{

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi()async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=66a93a292ef2452ab0a7a4691c505a11';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }throw Exception('Error');
  }

}
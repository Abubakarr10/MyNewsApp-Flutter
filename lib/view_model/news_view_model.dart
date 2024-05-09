import 'package:my_news_app/model/news_categories_model.dart';
import 'package:my_news_app/model/news_channel_headlines_model.dart';
import 'package:my_news_app/respository/news_repository.dart';

import '../model/article_model.dart';

class NewsViewModel{

  final api = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsModelHeadlinesApi(String source)async{
    final response = await api.fetchNewsChannelHeadlinesApi(source);
    return response;
  }

  Future<List<Article>> fetchNewsCategoriesApi(String category)async{
  //  final response = await api.fetchNewsCategoriesApi(category);
    final response = await api.fetchNews(category);
    return response;
  }

}
import 'package:my_news_app/model/news_categories_model.dart';
import 'package:my_news_app/model/news_channel_headlines_model.dart';
import 'package:my_news_app/respository/news_repository.dart';

class NewsViewModel{

  final api = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsModelHeadlinesApi(String source)async{
    final response = await api.fetchNewsChannelHeadlinesApi(source);
    return response;
  }

  Future<CategoriesNewsModel> fetchNewsCategoriesApi(String category)async{
    final response = await api.fetchNewsCategoriesApi(category);
    return response;
  }

}
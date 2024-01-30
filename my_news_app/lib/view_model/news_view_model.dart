import 'package:my_news_app/model/news_channel_headlines_model.dart';
import 'package:my_news_app/respository/news_repository.dart';

class NewsViewModel{

  final api = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsModelHeadlinesApi()async{
    final response = await api.fetchNewsChannelHeadlinesApi();
    return response;
  }

}
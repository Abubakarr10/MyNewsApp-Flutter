import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_news_app/model/news_categories_model.dart';
import 'package:my_news_app/model/news_channel_headlines_model.dart';

class NewsRepository{

  final apiKey = '66a93a292ef2452ab0a7a4691c505a11';

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String source)async{
    String url = "https://newsapi.org/v2/top-headlines?sources=$source&apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }throw Exception('Error');
  }

  Future<CategoriesNewsModel> fetchNewsCategoriesApi(String category)async{
    String url = "https://newsapi.org/v2/everything?q=$category&apiKey=$apiKey";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      var body = jsonDecode(response.body);
      var checkBody;
      if(body['status']=='ok'){
       body["articles"].forEach((element){
         if(element["urlToImage"] !=null || element["author"] !=null){
           checkBody = body;
           return checkBody;
          }
        });
       return CategoriesNewsModel.fromJson(checkBody);
       //  for(var bodyObj in body){
       //    String? urlToImage = bodyObj["urlToImage"];
       //    String? description = bodyObj["description"];
       //  if(urlToImage!=null && description!=null){
       //    return CategoriesNewsModel.fromJson(body);
       //  }
       //  }
      }
    }throw Exception('Error');
  }

  Future<List<Article>> fetchNews(String category) async {
    final apiUrl = "https://newsapi.org/v2/everything?q=$category&apiKey=$apiKey";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'ok') {
        List<Article> articles = [];

        for (var article in data['articles']) {
          // Check if all required elements are not empty
          if (article['title'] != null &&
              article['description'] != null &&
              article['url'] != null &&
              article['urlToImage'] != null) {
            // Check if urlToImage is not null
            if (article['urlToImage'] != null) {
              articles.add(Article.fromJson(article));
            }
          }
        }
        return articles;
      } else {
        throw Exception('Failed to load news');
      }
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String? author;
  final String? publishedAt;
  final String? content;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.author,
    required this.publishedAt
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
        author: json['author'],
        publishedAt: json['publishedAt'],
        content: json['content']
    );
  }
}
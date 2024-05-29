import 'news_categories_model.dart';

class Article {
  final String title;
  final String description;
  final String url;
  Source? source;
  final String urlToImage;
  final String? author;
  final String? publishedAt;
  final String? content;

  Article({
    required this.title,
    required this.description,
    required this.source,
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
        content: json['content'],
        source: json['source'] != null ? Source.fromJson(json['source']) : null
    );
  }
}
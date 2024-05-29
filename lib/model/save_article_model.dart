
class SaveArticleModel{
  final String userID;
  final String title;
  final String description;
  final String url;
  final String source;
  final String urlToImage;
  final String? author;
  final String? publishedAt;
  final String? content;
  SaveArticleModel(
      {
        required this.userID,
        required this.title,
        required this.description,
        required this.source,
        required this.url,
        required this.urlToImage,
        required this.content,
        required this.author,
        required this.publishedAt

      });

  Map<String,dynamic> toJson(){
    return {
      'userID' : userID,
      'title' : title,
      'description' : description,
      'source' : source,
      'url' : url,
      'urlToImage' : urlToImage,
      'content' : content,
      'author' : author,
      'publishedAt' : publishedAt,
    };
  }

  factory SaveArticleModel.fromJson(Map<String, dynamic> json){
    return SaveArticleModel(
        userID: json['uid'],
      title: json['title'],
      description: json['description'],
      source: json['source'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      author: json['author'],
      content: json['content'],
      publishedAt: json['publishedAt'],

    );
  }
}


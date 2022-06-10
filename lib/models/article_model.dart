class ArticleModel {
  String sourceName;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;

  ArticleModel(
      {required this.sourceName,
      required this.author,
      required this.title,
      required this.description,
      required this.urlToImage,
      required this.url,
      required this.publishedAt});

  factory ArticleModel.fromJson(Map<String, dynamic> element) {
    return ArticleModel(
        sourceName: element['source']['name'],
        author: element['author'],
        title: element['title'],
        description: element['description'],
        urlToImage: element['urlToImage'],
        url: element['url'],
        publishedAt: element['publishedAt']);
  }
}

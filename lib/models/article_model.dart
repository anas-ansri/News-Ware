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
      author: element['author'],
      description: element['dec'],
      sourceName: element['source'],
      publishedAt: element['time'],
      title: element['title'],
      url: element['url'],
      urlToImage: element['urlImage'],
    );
  }
}

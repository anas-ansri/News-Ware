import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'package:news_ware/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  Future<List<ArticleModel>> getNews() async {
    List<ArticleModel> news = [];
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=b9a7a3e1f77a4f88b4d9206516b31790';

    // String url =
    //     'https://newsapi.org/v2/popularity&apiKey=b9a7a3e1f77a4f88b4d9206516b31790';
    // String url =
    //     'https://newsapi.org/v2/top-headlines?pageSize=100&country=in&apiKey=b9a7a3e1f77a4f88b4d9206516b31790';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      print(jsonData['totalResults']);
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null) {
          ArticleModel articleModel = ArticleModel(
              sourceName: element['source']['name'],
              author: element['author'],
              title: element['title'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              url: element['url'],
              publishedAt: element['publishedAt']);
          news.add(articleModel);
        }
      });
    }
    return news;
  }

  Future<List<ArticleModel>> searchNews(String query) async {
    List<ArticleModel> news = [];
    // DateTime now = new DateTime.now();
    // DateTime today = new DateTime(now.year, now.month, now.day);
    String url =
        'https://newsapi.org/v2/everything?language=en&q=$query&sortBy=publishedAt&apiKey=b9a7a3e1f77a4f88b4d9206516b31790';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      print(jsonData['totalResults']);
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['author'] != null) {
          ArticleModel articleModel = ArticleModel(
              sourceName: element['source']['name'],
              author: element['author'],
              title: element['title'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              url: element['url'],
              publishedAt: element['publishedAt']);
          news.add(articleModel);
        }
      });
    }
    return news;
  }
}

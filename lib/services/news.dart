import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_ware/services/database.dart';
// import 'package:http/http.dart';
import 'package:news_ware/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_ware/models/categories.dart';

class News {
  Db db = Db();
  String base = 'https://newsapi.org/v2';

  Future<List<ArticleModel>> getNews(String country) async {
    List<String>? keyList = await db.getApiKeys();
    List<ArticleModel> news = [];

    int index = 0;
    String apiKey = keyList![index];

    while (true) {

      print("List length: "+ keyList.length.toString());
      print("Current Index : "+ index.toString());
      apiKey = keyList[index % keyList.length];

      String url = '$base/top-headlines?country=$country&apiKey=$apiKey';

      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      print(apiKey);
      if (response.statusCode == 200) {
        if (jsonData['status'] == 'ok') {
          // print(jsonData["totalResults"]);
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
        break;
      } else if (response.statusCode == 429) {
        index++;
      } else {
        // print("Error occured ");
      }
    }

    // print(news);
    return news;
  }

  Future<List<ArticleModel>> searchNews(String query) async {
    List<String>? keyList = await db.getApiKeys();
    List<ArticleModel> news = [];
    int index = 0;
    String _apiKey = keyList![index];
    // DateTime now = new DateTime.now();
    // DateTime today = new DateTime(now.year, now.month, now.day);
    while (true) {
      _apiKey = keyList[index % keyList.length];
      String url = '$base/everything?language=en&q=$query&apiKey=$_apiKey';
      // https: //newsapi.org/v2/everything?q=tesla&from=2022-05-14&sortBy=publishedAt&apiKey=API_KEY
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (jsonData['status'] == 'ok') {
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
        break;
      } else if (response.statusCode == 429) {
        index++;
      } else {
        print(response.statusCode);
      }
    }
    return news;
  }

  Future<List<ArticleModel>> fetchNews(
      BuildContext context, Category category, String country) async {
    List<String>? keyList = await db.getApiKeys();
    List<ArticleModel> news = [];

    int index = 0;
    String _apiKey = keyList![index];

    while (true) {
      _apiKey = keyList[index % keyList.length];
      String url =
          // '$base/top-headlines?country=in&apiKey=$apiKey';
          '$base/top-headlines?country=$country&apiKey=$_apiKey&category=${category.id}';
      // final response = await http.get(Uri.parse(url));

      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonData['status'] == 'ok') {
          // print(jsonData["totalResults"]);
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
        break;
      } else if (response.statusCode == 429) {
        index++;
      } else {
        throw Exception('Failed to load post');
      }
    }
    return news;

    // if (response.statusCode == 200) {
    //   List<dynamic> articlesData = json.decode(response.body)['articles'];
    //   return articlesData.map((item) => ArticleModel.fromJson(item)).toList();
    // } else {
    //   throw Exception('Failed to load post');
    // }
  }
}

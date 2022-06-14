import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:news_ware/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_ware/models/categories.dart';

class News {
  String base = 'https://newsapi.org/v2';
  String apiKey = "b9a7a3e1f77a4f88b4d9206516b31790";

  Future<List<ArticleModel>> getNews(String country) async {
    List<ArticleModel> news = [];
    String url = '$base/top-headlines?country=$country&apiKey=$apiKey';

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
    } else {
      print("Error occured ");
      print(response.statusCode);
    }
    // print(news);
    return news;
  }

  Future<List<ArticleModel>> searchNews(String query) async {
    List<ArticleModel> news = [];
    // DateTime now = new DateTime.now();
    // DateTime today = new DateTime(now.year, now.month, now.day);
    String url = '$base/everything?language=en&q=$query&apiKey=$apiKey';
    // https: //newsapi.org/v2/everything?q=tesla&from=2022-05-14&sortBy=publishedAt&apiKey=API_KEY
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      print(jsonData["totalResults"]);
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

  Future<List<ArticleModel>> fetchNews(
      BuildContext context, Category category, String country) async {
    List<ArticleModel> news = [];
    String url =
        // '$base/top-headlines?country=in&apiKey=$apiKey';
        '$base/top-headlines?country=$country&apiKey=$apiKey&category=${category.id}';
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
    } else {
      throw Exception('Failed to load post');
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

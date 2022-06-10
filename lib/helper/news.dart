import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_ware/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_ware/models/categories.dart';

class News {
  String base = 'https://newsapi.org/v2';
  String apiKey = "426c52a71d044294a6f5529d29362c3b";

  Future<List<ArticleModel>> getNews(String country) async {
    List<ArticleModel> news = [];
    String url = '$base/top-headlines?country=$country&apiKey=$apiKey';

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
    } else {
      print("Error occured ");
      print(response.statusCode);
    }

    return news;
  }

  Future<List<ArticleModel>> searchNews(String query, String country) async {
    List<ArticleModel> news = [];
    // DateTime now = new DateTime.now();
    // DateTime today = new DateTime(now.year, now.month, now.day);
    String url =
        'https://newsapi.org/v2/everything?&q=$query&sortBy=publishedAt&apiKey=$apiKey';
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

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

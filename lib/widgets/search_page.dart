import 'package:flutter/material.dart';

import '../helper/news.dart';
import '../models/article_model.dart';
import 'news_card.dart';

class SearchPage extends StatefulWidget {
  final String query;
  SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ArticleModel> articles = List<ArticleModel>.empty(growable: true);
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    News news = News();

    return FutureBuilder<List<ArticleModel>>(
        future: news.searchNews(widget.query.toLowerCase()),
        builder: (context, AsyncSnapshot<List<ArticleModel>> snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            List<ArticleModel>? articles = snapshot.data;
            print(articles?.length);
            return ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: articles!.length,
              itemBuilder: (context, index) {
                return NewsCard(
                    source: articles[index].sourceName,
                    author: articles[index].author,
                    urlImage: articles[index].urlToImage,
                    title: articles[index].title,
                    dec: articles[index].description,
                    time: articles[index].publishedAt,
                    url: articles[index].url);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

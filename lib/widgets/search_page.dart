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
  void initState() {
    super.initState();
    searchNews(widget.query);
  }

  searchNews(String query) async {
    News news = News();
    await news.searchNews(query);
    articles = news.news;
    setState(() {
      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Colors.black12,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: articles.length,
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
            ),
          );
  }
}

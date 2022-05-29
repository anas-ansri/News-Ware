import 'package:flutter/material.dart';
import 'package:news_ware/helper/news.dart';
import 'package:news_ware/models/article_model.dart';
import 'package:news_ware/widgets/news_card.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // late Future<List<ArticleModel>> articles = ;
  List<ArticleModel> articles = List<ArticleModel>.empty(growable: true);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News news = News();
    await news.getNews();
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
            color: Colors.white,
            child: RefreshIndicator(
              onRefresh: () async {
                getNews();
                setState(() async {
                  News news = News();
                  await news.getNews();
                  articles = news.news;
                  setState(() {
                    _loading = !_loading;
                  });
                });
              },
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
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
            ),
          );
  }
}

// ListView(
// children: [
// NewsCard(
// source: "The Indian Express",
// author: "John Aducts",
// urlImage:
// "http://c.files.bbci.co.uk/13803/production/_124057897_comp6april.jpg",
// title:
// "Tesla’s plan to split stock is a ‘massive catalyst’ for TSLA, Dan Ives suggests",
// dec:
// "Tesla Inc. (NASDAQ: TSLA) stated on Monday, March 28th that they will ask for shareholders’ approval at the annual meeting... Continue reading \nThe post Tesla’s plan to split stock is a ‘massive catalyst’ for TSLA, Dan Ives suggests appeared first on Finbold.",
// time: "2 hrs ago"),
// NewsCard(
// source: "Indian Express",
// author: "John Aducts",
// urlImage:
// "http://c.files.bbci.co.uk/13803/production/_124057897_comp6april.jpg",
// title:
// "Tesla’s plan to split stock is a ‘massive catalyst’ for TSLA, Dan Ives suggests",
// dec:
// "Tesla Inc. (NASDAQ: TSLA) stated on Monday, March 28th that they will ask for shareholders’ approval at the annual meeting... Continue reading \nThe post Tesla’s plan to split stock is a ‘massive catalyst’ for TSLA, Dan Ives suggests appeared first on Finbold.",
// time: "2 hrs ago"),
// ],
// );

import 'package:flutter/material.dart';
import 'package:news_ware/models/article_model.dart';
import 'package:news_ware/services/database.dart';
import 'package:news_ware/widgets/loading.dart';
import 'package:news_ware/widgets/news_card.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    Db db = Db();
    return FutureBuilder<List<ArticleModel>?>(
        future: db.getArticles(),
        builder: (context, snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            List<ArticleModel>? articles = snapshot.data;
            // articles.add();
            // print(articles?.length);
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
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
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Loading();
        });
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/models/user.dart';
// import 'package:news_ware/services/database.dart';
import 'package:news_ware/widgets/loading.dart';

import '../services/news.dart';
import '../models/article_model.dart';
import 'news_card.dart';

class SearchPage extends StatefulWidget {
  final String query;
  const SearchPage({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ArticleModel> articles = List<ArticleModel>.empty(growable: true);
  UserData? userData;
  News news = News();

  @override
  Widget build(BuildContext context) {
    // String uid = FirebaseAuth.instance.currentUser!.uid;

    // return StreamBuilder<UserData>(
    //     stream: DatabaseService(uid: uid).userDetail,
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //       if (snapshot.hasData) {
    //         userData = snapshot.data;
    return FutureBuilder<List<ArticleModel>>(
        future: news.searchNews(widget.query),
        builder: (context, AsyncSnapshot<List<ArticleModel>> snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            List<ArticleModel>? articles = snapshot.data;
            // print(articles?.length);
            return ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
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
          return const Loading();
        });
    //   } else {
    //     return const Loading();
    //   }
    // });
  }
}

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_ware/services/network_status_service.dart';
import 'package:news_ware/services/news.dart';
import 'package:news_ware/models/article_model.dart';
import 'package:news_ware/models/categories.dart';
import 'package:news_ware/models/user.dart';
import 'package:news_ware/widgets/card_shimmers.dart';
import 'package:news_ware/widgets/news_card.dart';

class Feed extends StatefulWidget {
  final UserData? userData;
  const Feed({Key? key, required this.userData}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final categories = Category.all();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: HexColor("#14246c"),
          leading: null,
          title: TabBar(
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white54,
            indicatorWeight: 3,
            isScrollable: true,
            tabs: [
              ...categories.map((category) => Tab(
                  child: Align(
                      child: Text(category.label),
                      alignment: Alignment.center)))
            ],
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            ...categories.map((category) => NewsList(
                  category: category,
                  userData: widget.userData,
                ))
          ],
        ),
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  final Category category;
  final UserData? userData;

  NewsList({Key? key, required this.category, required this.userData})
      : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  News news = News();

  @override
  Widget build(BuildContext context) {
    // String uid = FirebaseAuth.instance.currentUser!.uid;

    // return StreamBuilder<UserData>(
    //     stream: DatabaseService(uid: uid).userDetail,
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //       if (snapshot.hasData) {
    //         userData = snapshot.data;
    return widget.category.label == "Top Headlines"
        ? TopHeadlines(
            country: widget.userData!.country,
          )
        : CategoryNews(
            country: widget.userData!.country, category: widget.category);
    //   } else {
    //     return Loading();
    //   }
    // });
  }
}

class TopHeadlines extends StatefulWidget {
  final String country;
  const TopHeadlines({Key? key, required this.country}) : super(key: key);

  @override
  State<TopHeadlines> createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines>
    with AutomaticKeepAliveClientMixin {
  News news = News();

  late Future<List<ArticleModel>> articles;
  void getData() {
    setState(() {
      articles = news.getNews(widget.country);
    });
  }

  // Must include
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  // late Future<List<ArticleModel>> articles;

  // @override
  // void initState() {
  //   super.initState();

  //   // must use listen false here
  //   // final news = Provider.of<News>(context, listen: false);
  //   articles = news.getNews(widget.country);
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   // final username = Provider.of<SharedPreferencesFunction>(context).username;
  //   // user = userApi.getUserByUsername(username: username);
  //   articles = news.getNews(widget.country);
  // }

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return Connect(
      child: FutureBuilder<List<ArticleModel>>(
          future: articles,
          builder: (context, snapshot) {

            //let's check if we got a response or not
            if (snapshot.hasData) {

              //Now let's make a list of articles
              List<ArticleModel>? articles = snapshot.data;
              return RefreshIndicator(
                onRefresh: () async {
                  getData();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: articles?.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                        source: articles![index].sourceName,
                        author: articles[index].author,
                        urlImage: articles[index].urlToImage,
                        title: articles[index].title,
                        dec: articles[index].description,
                        time: articles[index].publishedAt,
                        url: articles[index].url);
                  },
                ),
              );
            } else if (snapshot.hasError) {

              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return const Loading();
          }),
    );
  }
}

class CategoryNews extends StatefulWidget {
  final Category category;
  final String country;
  const CategoryNews({Key? key, required this.country, required this.category})
      : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews>
    with AutomaticKeepAliveClientMixin {
  News news = News();

  late Future<List<ArticleModel>> articles;

  void getData() {
    setState(() {
      articles = news.fetchNews(context, widget.category, widget.country);
    });
  }

  // Must include
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Connect(
      child: FutureBuilder<List<ArticleModel>>(
          future: articles,
          builder: (context, snapshot) {
            //let's check if we got a response or not
            if (snapshot.hasData) {
              //Now let's make a list of articles
              List<ArticleModel>? articles = snapshot.data;
              return RefreshIndicator(
                onRefresh: () async {
                  getData();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: articles?.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                        source: articles![index].sourceName,
                        author: articles[index].author,
                        urlImage: articles[index].urlToImage,
                        title: articles[index].title,
                        dec: articles[index].description,
                        time: articles[index].publishedAt,
                        url: articles[index].url);
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return const Loading();
          }),
    );
  }
}

// ListView.builder(
//   shrinkWrap: true,
//   physics: const AlwaysScrollableScrollPhysics(),
//   itemCount: articles.length,
//   itemBuilder: (context, index) {
//     return NewsCard(
//         source: articles[index].sourceName,
//         author: articles[index].author,
//         urlImage: articles[index].urlToImage,
//         title: articles[index].title,
//         dec: articles[index].description,
//         time: articles[index].publishedAt,
//         url: articles[index].url);
//   },
// ),

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

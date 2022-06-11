import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_ware/helper/expandable_text.dart';
import 'package:news_ware/screens/article_view.dart';
import 'package:news_ware/services/database.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

// import 'package:share_plus/share_plus.dart';

class NewsCard extends StatefulWidget {
  final String source, author, urlImage, title, dec, time, url;

  const NewsCard(
      {Key? key,
      required this.source,
      required this.author,
      required this.urlImage,
      required this.title,
      required this.dec,
      required this.time,
      required this.url})
      : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  late int likes = 0;

  bool likeToggle = false;
  // late final String saveId;
  Db db = Db();

  @override
  Widget build(BuildContext context) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(widget.time);
    var dateTime = DateTime.parse(parseDate.toString());
    var dateLocal = dateTime.toLocal();
    var dateNow = DateTime.now().toLocal();
    var publishedBefore = dateNow.difference(dateLocal);
    final timeAgo = DateTime.now().subtract(publishedBefore);

    return Card(
      shadowColor: Colors.black54,
      margin: const EdgeInsets.all(3),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black38, width: 0)),
      child: Column(
        children: [
          ListTile(
            //When user click
            onTap: () {},
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
            title: Text(widget.source),
            subtitle: Text(widget.author + ", " + timeago.format(timeAgo)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleView(
                            articleUrl: widget.url,
                          )));
            },
            child: FancyShimmerImage(
              imageUrl: widget.urlImage,
              boxFit: BoxFit.fill,
              width: 400,
              height: 250,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                // ReadMoreText(
                //   widget.dec,
                //   trimLines: 1,
                //   colorClickableText: Colors.pink,
                //   trimMode: TrimMode.Line,
                //   trimCollapsedText: 'Show more',
                //   trimExpandedText: 'Show less',
                //   moreStyle:
                //       TextStyle(fontSize: 5, fontWeight: FontWeight.bold),
                // ),
                // ExpandableText(
                //   'The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface. ',
                //   trimLines: 2,
                //   colorClickableText: Colors.pink,
                //   trimMode: TrimMode.Line,
                //   trimCollapsedText: '...Read more',
                //   trimExpandedText: ' Less',
                // ),
                ExpandableText(text: widget.dec, max: .5)

                // Text(
                //   widget.dec,
                //   style: const TextStyle(color: Colors.black54),
                // ),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            // IconButton(
            //     onPressed: () {
            //       setState(() {
            //         likeToggle = !likeToggle;
            //         likes += 1;
            //       });
            //     },
            //     icon: likeToggle
            //         ? Icon(Icons.favorite, color: Colors.red)
            //         : Icon(Icons.favorite_border)),
            // Text(likes.toString()),
            // const SizedBox(
            //   width: 20,
            // ),
            SizedBox(
              width: 15,
            ),
            FutureBuilder(
              future: db.isSaved(widget.url),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                bool saveToggle = snapshot.data ?? false;
                return IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () async {
                      final timeStamp =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      if (!saveToggle) {
                        await db
                            .saveArticle(
                                timeStamp,
                                widget.source,
                                widget.author,
                                widget.urlImage,
                                widget.title,
                                widget.dec,
                                widget.time,
                                widget.url)
                            .then((value) {
                          setState(() {
                            saveToggle = true;
                          });
                        });
                      } else {
                        db.removeArticle(widget.url).then((value) {
                          setState(() {
                            saveToggle = false;
                          });
                        });
                      }
                    },
                    icon: saveToggle
                        ? const Icon(Icons.bookmark)
                        : Icon(Icons.bookmark_border));
              },
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  // Share.share(widget.url);
                  // share(context, articles)
                },
                icon: const Icon(Icons.share)),
            SizedBox(
              width: 15,
            ),
          ]),
        ],
      ),
    );
  }
}

// void share(BuildContext context,Widget wid) {

// }
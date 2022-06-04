import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_ware/helper/expandable_text.dart';
import 'package:news_ware/screens/article_view.dart';
import 'package:timeago/timeago.dart' as timeago;

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
  bool saveToggle = false;
  bool likeToggle = false;

  @override
  Widget build(BuildContext context) {
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(widget.time);

    var dateTime = DateTime.parse(parseDate.toString());
    var dateLocal = dateTime.toLocal();
    var dateNow = DateTime.now();
    var publishedBefore = dateNow.difference(dateLocal);
    final timeAgo = DateTime.now().subtract(publishedBefore);

    return Card(
      shadowColor: Colors.black54,
      margin: const EdgeInsets.all(3),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black38, width: 0)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            // hoverColor: Colors.white30,
            // leading: const CircleAvatar(
            //  // backgroundImage: //Source image link to be pasted here,
            //   backgroundColor: Colors.amber,
            // ),
            //When user click
            onTap: () {},
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
            title: Text(widget.source),
            subtitle: Text(widget.author + ", " + timeago.format(timeAgo)),
          ),

          // Image.network(urlImage),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleView(
                            articleUrl: widget.url,
                          )));
            },
            child: Container(
              width: 400,
              height: 250,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey),
              //   borderRadius: BorderRadius.circular(3),
              //   color: Colors.white54,
              // ),

              child: SizedBox.expand(
                child: FittedBox(
                    fit: BoxFit.fill, child: Image.network(widget.urlImage)),
              ),
            ),
          ),
          // SizedBox.expand(
          //   child: FittedBox(
          //     child: Image.network(
          //       widget.urlImage,
          //       width: 100,
          //       height: 100,
          //     ),
          //     fit: BoxFit.scaleDown,
          //   ),
          // ),
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
            IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    saveToggle = !saveToggle;
                  });
                },
                icon: saveToggle
                    ? Icon(Icons.bookmark)
                    : Icon(Icons.bookmark_border)),
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
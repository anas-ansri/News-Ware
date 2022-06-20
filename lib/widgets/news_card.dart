// import 'dart:html';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_ware/utils/constants.dart';
import 'package:news_ware/helper/expandable_text.dart';
import 'package:news_ware/screens/other/article_view.dart';
import 'package:news_ware/services/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
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
    double widthValue = getWidthValue(context);
    // double size = MediaQuery.of(context).size.width;
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(widget.time).toLocal();
    // var dateTime = DateTime.parse(parseDate.toString());
    // var dateLocal = dateTime.toLocal();
    var dateNow = DateTime.now();
    var publishedBefore = dateNow.difference(parseDate);
    final timeAgo = DateTime.now().subtract(publishedBefore);
    final textColor = kPrimaryColor;

    return Card(
      // color: secondryColor,
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
            // trailing: IconButton(
            //   icon: const Icon(Icons.more_vert),
            //   onPressed: () {},
            // ),
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
                            title: widget.title,
                            urlImage: widget.urlImage,
                            url: widget.url,
                          )));
            },
            child: FittedBox(
              fit: BoxFit.cover,
              child: FancyShimmerImage(
                imageUrl: widget.urlImage,
                boxFit: BoxFit.fill,
                width: widthValue * 100,
                height: widthValue * 75,
                errorWidget: Image.asset("assets/images/breaking.jpg"),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  widget.title,
                  // textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                ExpandableText(text: widget.dec, max: .5)
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                              "Article Saved!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.grey[300],
                            // duration: Duration(seconds: 1),
                          ));

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
                onPressed: () async {
                  final url = Uri.parse(widget.urlImage);
                  final response = await http.get(url);
                  final bytes = response.bodyBytes;
                  final temp = await getTemporaryDirectory();
                  final path = "${temp.path}/image.jpg";
                  File(path).writeAsBytesSync(bytes);

                  await Share.shareFiles([path],
                      text: "${widget.title}\nNews Url: ${widget.url}");
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
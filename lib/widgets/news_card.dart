import 'package:flutter/material.dart';
import 'package:news_ware/screens/article_view.dart';
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
    return Column(
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
          subtitle: Text(widget.author + ", " + widget.time),
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
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 3),
              Text(
                widget.dec,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              onPressed: () {
                setState(() {
                  likeToggle = !likeToggle;
                  likes += 1;
                });
              },
              icon: likeToggle
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border)),
          Text(likes.toString()),
          const SizedBox(
            width: 20,
          ),
          IconButton(
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
        ]),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}

// void share(BuildContext context,Widget wid) {

// }
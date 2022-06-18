import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news_ware/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String articleUrl;
  final String title;
  final String url;
  final String urlImage;
  const ArticleView(
      {Key? key,
      required this.articleUrl,
      required this.title,
      required this.url,
      required this.urlImage})
      : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: appTitle,
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          actions: [
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
          ],
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              ))),
      body: WebView(
        // backgroundColor:Colors.amber,
        initialUrl: widget.articleUrl,
        onWebViewCreated: ((WebViewController webViewController) =>
            _completer.complete(webViewController)),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String articleUrl;
  const ArticleView({Key? key, required this.articleUrl}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Color backgroundColor = const Color(0xFF0D6EFD);

  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("News Ware"),
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              ))),
      body: WebView(
        initialUrl: widget.articleUrl,
        onWebViewCreated: ((WebViewController webViewController) =>
            _completer.complete(webViewController)),
      ),
    );
  }
}

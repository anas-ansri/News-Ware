import 'dart:ui';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/widgets/loading.dart';
// import 'package:news_ware/helper/loading.dart';

class MyActivity extends StatelessWidget {
  const MyActivity({Key? key}) : super(key: key);
  final Color backgroundColor = const Color(0xFF0D6EFD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Activity"),
        centerTitle: true,
        backgroundColor: backgroundColor,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: const Text(
          "Coming Soon",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
        ),
      ),
      // body: Image(
      //   // fit: BoxFit.fitWidth,
      //   image: NetworkImage(
      //       "https://firebasestorage.googleapis.com/v0/b/news-ware-4b3d0.appspot.com/o/AppData%2FAssets%2FImages%2Fcoming_soon.png?alt=media&token=76c68553-8fe3-4546-bc7a-52389e4db45f"),
      // )
      //  FancyShimmerImage(
      //     boxFit: BoxFit.,
      //     imageUrl:
      //         "https://firebasestorage.googleapis.com/v0/b/news-ware-4b3d0.appspot.com/o/AppData%2FAssets%2FImages%2Fcoming_soon.png?alt=media&token=76c68553-8fe3-4546-bc7a-52389e4db45f")
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: const [
      //       Text("This page is under-construction",
      //           textAlign: TextAlign.center,
      //           style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey)),
      //       SizedBox(height: 30,),
      //       Icon(Icons.construction,size: 50,color: Colors.grey,)
      //     ],
      //   ),
      // ),
    );
  }
}

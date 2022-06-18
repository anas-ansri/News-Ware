import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/utils/constants.dart';

class UserPage extends StatelessWidget {
  final String name;
  final String urlImage;

  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(name),
        centerTitle: true,
      ),
      body: FancyShimmerImage(
        imageUrl: urlImage,
        width: double.infinity,
        height: double.infinity,
        boxFit: BoxFit.cover,
      )
      // Image.network(
      //   urlImage,
      //   width: double.infinity,
      //   height: double.infinity,
      //   fit: BoxFit.cover,
      // ),
      );
}

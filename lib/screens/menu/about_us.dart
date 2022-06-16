import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_ware/helper/my_icons_icons.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);
  final Color backgroundColor = const Color(0xFF0D6EFD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
        backgroundColor: backgroundColor,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home,
                size: 50,
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Icon(
            Icons.construction,
            size: 50,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_ware/services/database.dart';
import 'package:news_ware/utils/constants.dart';
import 'package:news_ware/helper/my_icons_icons.dart';

class AboutUs extends StatelessWidget {
  AboutUs({Key? key}) : super(key: key);
  Db db = Db();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("About"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {},
          // ),
        ),
        body: ListView(
          // shrinkWrap: true,

          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: Text(
                "News Ware is a news feed app that lets you browse the latest news from all of the major news sources in one convenient, quick and light app so you can stay up to date on what's going on in the world.\nAnas Ansari (App Developer) began developing this app in March 2022 with the goal of creating a simple and fast app with a user friendly interface.",
                style: GoogleFonts.sourceSansPro(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                Text(
                  "Created using :",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Container(
                  width: 150,
                  height: 65,
                  child: Container(),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/newsapi.png"),
                          fit: BoxFit.cover)),
                ),
              ],
            )
          ],
        ));
  }
}

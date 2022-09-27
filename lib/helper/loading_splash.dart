import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_ware/utils/constants.dart';

class LoadingSplash extends StatefulWidget {
  const LoadingSplash({Key? key}) : super(key: key);

  @override
  State<LoadingSplash> createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: kPrimaryColor,
        width: double.maxFinite,
        height: double.maxFinite,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       // Theme.of(context).colorScheme.secondary,
        //       Colors.white,
        //       Theme.of(context).primaryColor
        //     ],
        //     begin: const FractionalOffset(0, 0),
        //     end: const FractionalOffset(1.0, 0.0),
        //     stops: const [0.0, 1.0],
        //     tileMode: TileMode.clamp,
        //   ),
        // ),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 1200),
          child: ListView(
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.0 * getHeightValue(context),
              ),
              SizedBox(
                height: 120.0,
                width: 120.0,
                child: Center(
                    child: Image.asset(
                        "assets/icons/only_icon.png") //put your logo here

                    ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30.0)),
              const Text(
                "NEWSWARE",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    // fontStyle: FontStyle.italic,
                    fontFamily: "AbrilFatface",
                    // fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white), ////HexColor("#fc6424")
              ),
              const Padding(padding: EdgeInsets.only(top: 80.0)),
              Flexible(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: Colors.green,
                  rightDotColor: Colors.red,
                  size: 60,
                ),
              ),
              SizedBox(
                height: 20.0 * getHeightValue(context),
              ),
            ],
            // ),
          ),
        ),
      ),
    );
  }
}

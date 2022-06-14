import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).primaryColor
            ],
            begin: const FractionalOffset(0, 0),
            end: const FractionalOffset(1.0, 0.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 1200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 140.0,
                width: 140.0,
                child: const Center(
                  child: ClipOval(
                    child: Icon(
                      Icons.newspaper,
                      size: 100,
                    ), //put your logo here
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 2.0,
                        offset: const Offset(5.0, 3.0),
                        spreadRadius: 2.0,
                      )
                    ]),
              ),
              Padding(padding: EdgeInsets.only(top: 50.0)),
              Text(
                "News Ware",
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              Padding(padding: EdgeInsets.only(top: 50.0)),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

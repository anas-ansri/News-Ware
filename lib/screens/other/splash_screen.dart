import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_ware/helper/loading_splash.dart';
import 'package:news_ware/models/user.dart';
import 'package:news_ware/screens/other/wrapper.dart';
import 'package:news_ware/services/auth.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool _isVisible = false;
  _SplashScreenState() {
    Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return StreamProvider<MyUser?>.value(
              value: AuthService().user,
              initialData: null,
              child: const Wrapper());
        }), (route) => false);
      });
    });
    // Timer(const Duration(milliseconds: 10), () {
    //   setState(() {
    //     _isVisible =
    //         true; // Now it is showing fade effect and navigating to Login page
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingSplash();
  }
}

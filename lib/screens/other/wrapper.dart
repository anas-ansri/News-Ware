import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/helper/loading_splash.dart';
import 'package:news_ware/screens/authenticate/Signup/signup_screen.dart';
import 'package:news_ware/screens/authenticate/verify_email_page.dart';
import 'package:news_ware/utils/network_check.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  NetworkCheck network = NetworkCheck();

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<MyUser?>(context);
    // if (hasNetwork) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const VerifyEmailPage();
          // return HomeScreen(
          //   selectedIndex: 0,
          // );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingSplash();
        }
        // else if (snapshot.hasError) {
        //   print("Error aa gya");
        //   return const Center(
        //     child: Text("Something went wrong!"),
        //   );
        // }
        else {
          return const SignUpScreen();
        }
      },
    );
    // } else {
    //   return Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );

    // if (user == null) {
    //   return LoginScreen();
    // } else {
    //   return HomeScreen(selectedIndex: 0);
    //   // Navigator.of(context).pushAndRemoveUntil(
    //   //     MaterialPageRoute(builder: (context) {
    //   //   return HomeScreen(
    //   //     selectedIndex: 0,
    //   //   );
    //   // }), (route) => false);
    // }
    // return Loading();
    // return Scaffold(
    //   body: StreamBuilder(
    //       stream: FirebaseAuth.instance.authStateChanges(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           //Loading
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         } else if (snapshot.hasData) {
    //           return HomeScreen(
    //             selectedIndex: 0,
    //           );
    //         } else if (snapshot.hasError) {
    //           return const Center(
    //             child: Text("Something went wrong!"),
    //           );
    //         } else {
    //           return LoginScreen();
    //         }
    //       }),
    // );

    // final user = Provider.of<User?>(context);
    // if (user == null) {
    //   return Authenticate();
    // } else {
    //   return Home();
    // }
  }
}
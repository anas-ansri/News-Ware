import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/screens/authenticate/Signup/signup_screen.dart';
import 'package:news_ware/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //Loading
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return const HomeScreen();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong!"),
              );
            } else {
              return SignUpScreen();
            }
          }),
    );

    // final user = Provider.of<User?>(context);
    // if (user == null) {
    //   return Authenticate();
    // } else {
    //   return Home();
    // }
  }
}

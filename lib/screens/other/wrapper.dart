import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/helper/loading_splash.dart';
import 'package:news_ware/screens/authenticate/Signup/signup_screen.dart';
import 'package:news_ware/screens/authenticate/verify_email_page.dart';
import 'package:news_ware/utils/constants.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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
        } else if (snapshot.hasError) {
          return showErrorAlert(context, snapshot.error.toString());
        } else {
          return const SignUpScreen();
        }
      },
    );
  }
}

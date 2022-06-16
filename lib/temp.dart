import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/constants.dart';
import 'package:news_ware/screens/home/home.dart';
import 'package:news_ware/services/auth.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = true;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //User need to be created before

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
  }

  Future checkEmailVerified() async {
    FirebaseAuth.instance.currentUser!.reload();
    // user.reload;
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      // await firebase.auth().currentUser.sendEmailVerification();

      await user
          ?.sendEmailVerification()
          .then((value) => print("Verification sent! to ${user.email}"));
    } on Exception catch (e) {
      // TODO
      showErrorAlert(context, e.toString());
    }
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomeScreen(selectedIndex: 0)
      : Scaffold(
          appBar: AppBar(
            title: const Text("Verify your email"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text("Verification email is sent to you!!",
                  // textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center),
            ],
          ));
}

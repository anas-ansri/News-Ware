import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/utils/constants.dart';
import 'package:news_ware/helper/rounded_button.dart';
import 'package:news_ware/screens/home/home.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = true;
  bool canResend = false;
  Timer? timer;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
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
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {

      await user?.sendEmailVerification();
      if (!mounted) return;
      setState(() {
        canResend = false;
      });

      await Future.delayed(const Duration(seconds: 10));

      if (!mounted) return;
      setState(() {
        canResend = true;
      });
    } on Exception catch (e) {
      // TODO
      showErrorAlert(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomeScreen(selectedIndex: 0)
      : Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Verify your email"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: kPrimaryColor,
          ),
          body: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/images/success.gif",
                width: 15.0 * getHeightValue(context),
                height: 15.0 * getHeightValue(context),
              ),
              const SizedBox(
                height: 30,
              ),
              Text("A Verification email is sent to ${user!.email}",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 4.0 * getHeightValue(context),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 30,
              ),
              Text(
                  "Please verify the email and come back.\nIf you didn't find email, don't forget to check your spam box and If you stil did not find email, click on resend button given below.\nRemember: You can request for verification email after 10 seconds.",
 
                  style: TextStyle(fontSize: 2.0 * getHeightValue(context)),
                  textAlign: TextAlign.center),
     
              const SizedBox(
                height: 30,
              ),
              RoundedButton(
                  fontSize: 2.5 * getHeightValue(context),
                  text: "Resend email",
                  textColor: Colors.white,
                  press: () {
                    sendVerificationEmail();
                  }),
              RoundedButton(
                  fontSize: 2.5 * getHeightValue(context),
                  text: "Cancel",
                  color: secondryColor,
                  press: () {
                    FirebaseAuth.instance.signOut();
                  })
            ],
          ),
        );
}

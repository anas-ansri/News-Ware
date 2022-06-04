import 'package:flutter/material.dart';
import 'package:news_ware/helper/loading.dart';
import 'package:news_ware/services/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  // final Function toggleView;
  // Register({required this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            body: Center(
                // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
              key: _formKey,
              child: (ElevatedButton(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogIn();
                },
                child: const Text(
                  'Sign UP with GOOGLE',
                  style: TextStyle(color: Colors.white),
                ),
              )),
            )),
          );
  }
}

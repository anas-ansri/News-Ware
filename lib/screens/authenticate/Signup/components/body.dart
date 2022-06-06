import 'package:flutter/material.dart';

import 'package:news_ware/helper/already_have_an_account_acheck.dart';
import 'package:news_ware/helper/loading.dart';
import 'package:news_ware/helper/rounded_button.dart';
import 'package:news_ware/helper/rounded_input_field.dart';
import 'package:news_ware/helper/rounded_password_field.dart';
import 'package:news_ware/screens/authenticate/Login/login_screen.dart';
import 'package:news_ware/screens/authenticate/Signup/components/background.dart';
import 'package:news_ware/screens/authenticate/Signup/components/or_divider.dart';
import 'package:news_ware/services/auth.dart';

import 'package:provider/provider.dart';

import 'social_icon.dart';

class Body extends StatelessWidget {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String name = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Background(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "SIGNUP",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // SvgPicture.asset(
                    //   "assets/icons/signup.svg",
                    //   height: size.height * 0.35,
                    // ),

                    RoundedInputField(
                      hintText: "Your Name",
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    RoundedInputField(
                      validator: (val) {
                        if (val!.isEmpty || !val.contains("@")) {
                          return "Please enter a valid email";
                        } else {
                          return null;
                        }
                      },
                      hintText: "Your Email",
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    RoundedPasswordField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return "Please enter a valid password";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    RoundedButton(
                      text: "SIGNUP",
                      press: () {
                        print("Hello");
                        if (_formKey.currentState!.validate()) {
                          loading = true;
                          final provider =
                              Provider.of<AuthService>(context, listen: false);
                          print(provider);
                          final result =
                              provider.registerWithEmail(email, password, name);
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                    const OrDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocalIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press: () {
                            final provider = Provider.of<AuthService>(context,
                                listen: false);
                            provider.googleLogIn();
                            // _auth.googleSignIn;
                          },
                        ),
                      ],
                    ),
                    Text(error)
                  ],
                ),
              ),
            ),
          );
  }
}

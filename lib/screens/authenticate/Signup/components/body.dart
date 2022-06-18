import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_ware/utils/constants.dart';
import 'package:news_ware/helper/already_have_an_account_acheck.dart';
import 'package:news_ware/helper/loading_splash.dart';
import 'package:news_ware/helper/rounded_button.dart';
import 'package:news_ware/helper/rounded_input_field.dart';
import 'package:news_ware/helper/rounded_password_field.dart';
import 'package:news_ware/screens/authenticate/Login/login_screen.dart';
import 'package:news_ware/screens/authenticate/Signup/components/background.dart';
import 'package:news_ware/screens/authenticate/Signup/components/or_divider.dart';
import 'package:news_ware/services/auth.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
        ? LoadingSplash()
        : Background(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "SIGNUP",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // SvgPicture.asset(
                    //   "assets/icons/signup.svg",
                    //   height: size.height * 0.35,
                    // ),

                    RoundedInputField(
                      hintText: "Your Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name can not be empty";
                        } else {
                          return null;
                        }
                      },
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
                          return "Please enter a valid password, password should contain at least 8 letters.";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    Text(error),
                    RoundedButton(
                      fontSize: getWidthValue(context) * 2.5,
                      text: "SIGNUP",
                      press: () async {
                        // loading = true;
                        try {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth.registerWithEmail(
                                email, password, name);
                            if (result == null) {
                              setState(() {
                                error = "Please enter valid credentials";
                                loading = false;
                              });
                            }
                          } else {
                            const Text("Please Enter valid credentials");
                          }
                        } catch (e) {
                          error = e.toString();

                          // TODO
                          // showErrorAlert(context, e.toString());
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
                    TextButton.icon(
                        // style: ButtonStyle(backgroundColor: MaterialColor()),
                        label: const Text("Sign In with Google"),
                        icon: const Icon(FontAwesomeIcons.google),
                        onPressed: () async {
                          // final provider =
                          //     Provider.of<AuthService>(context, listen: false);
                          // provider.googleLogIn();
                          // try {
                          await _auth.googleLogIn();
                          // .then((value) => {Navigator.of(context).pop()});
                          // } on Exception catch (e) {
                          //   // print(e.toString());
                          //   showErrorAlert(context, e.toString());
                          // }
                        }),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     // SocalIcon(
                    //     //   iconSrc: "assets/icons/facebook.svg",
                    //     //   press: () {},
                    //     // ),
                    //     // SocalIcon(
                    //     //   iconSrc: "assets/icons/twitter.svg",
                    //     //   press: () {},
                    //     // ),
                    //     // SocalIcon(
                    //     //   iconSrc: "assets/icons/google-plus.svg",
                    //     //   press: () async {
                    //     //     // final provider = Provider.of<AuthService>(context,
                    //     //     //     listen: false);
                    //     //     // provider.googleLogIn();
                    //     //     await _auth.googleLogIn();
                    //     //   },
                    //     // ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          );
  }
}

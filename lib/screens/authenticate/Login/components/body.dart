import 'package:flutter/material.dart';
import 'package:news_ware/utils/constants.dart';
import 'package:news_ware/helper/already_have_an_account_acheck.dart';
import 'package:news_ware/helper/loading_splash.dart';
import 'package:news_ware/helper/rounded_button.dart';
import 'package:news_ware/helper/rounded_input_field.dart';
import 'package:news_ware/helper/rounded_password_field.dart';
import 'package:news_ware/screens/authenticate/Login/components/background.dart';
import 'package:news_ware/screens/authenticate/Signup/signup_screen.dart';
import 'package:news_ware/services/auth.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String email = '';

  String name = '';

  String password = '';

  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    Size size = MediaQuery.of(context).size;
    return loading
        ? const LoadingSplash()
        : Background(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 50.0),
                      ),
                      const Text(
                        "Please sign in to continue.",
                        style: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                      SizedBox(height: size.height * 0.03),
                      SizedBox(height: size.height * 0.03),
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
                      RoundedButton(
                        fontSize: getWidthValue(context) * 2.5,
                        text: "LOGIN",
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result != null) {
                              setState(() {
                                error = result.toString();
                                loading = false;
                              });
                            } else {
                              Navigator.of(context).pop();
                            }
                          } else {
                            const Text("Invalid Credentials");
                          }
                          //email:test@test.c pass: tgtgtgtg
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        login: true,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpScreen();
                              },
                            ),
                          );
                        },
                      ),
                      // const OrDivider(),
                      // RoundedButton(text: "Sign In with Google", press: () {}),
                      // FittedBox(
                      //   fit: BoxFit.contain,
                      //   child: TextButton.icon(
                      //       style: TextButton.styleFrom(
                      //         primary: kPrimaryColor,
                      //         backgroundColor: secondryColor,
                      //         shape: const RoundedRectangleBorder(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(20))),
                      //       ),
                      //       // style: ButtonStyle(backgroundColor: MaterialColor()),
                      //       label: Text(
                      //         "Sign In with Google",
                      //         style: GoogleFonts.sourceSansPro(
                      //             fontSize: 2.5 * getWidthValue(context)),
                      //       ),
                      //       icon: Icon(
                      //         FontAwesomeIcons.google,
                      //         size: 5.0 * getWidthValue(context),
                      //       ),
                      //       onPressed: () async {
                      //         setState(() {
                      //           loading = true;
                      //         });
                      //         // final provider =
                      //         //     Provider.of<AuthService>(context, listen: false);
                      //         // provider.googleLogIn();
                      //         // try {
                      //         await _auth.googleLogIn();
                      //         // .then((value) => {Navigator.of(context).pop()});
                      //         // } on Exception catch (e) {
                      //         //   // print(e.toString());
                      //         //   showErrorAlert(context, e.toString());
                      //         // }
                      //       }),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

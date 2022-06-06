import 'package:flutter/material.dart';
import 'package:news_ware/helper/already_have_an_account_acheck.dart';
import 'package:news_ware/helper/rounded_button.dart';
import 'package:news_ware/helper/rounded_input_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_ware/helper/rounded_password_field.dart';
import 'package:news_ware/screens/authenticate/Login/components/background.dart';
import 'package:news_ware/screens/authenticate/Signup/signup_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: size.height * 0.35,
            // ),
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
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
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
          ],
        ),
      ),
    );
  }
}

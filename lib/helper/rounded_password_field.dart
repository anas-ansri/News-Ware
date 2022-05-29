import 'package:flutter/material.dart';
import 'package:news_ware/helper/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);

  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

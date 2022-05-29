import 'package:flutter/material.dart';
import 'package:news_ware/helper/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

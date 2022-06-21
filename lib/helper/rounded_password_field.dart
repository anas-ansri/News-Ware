import 'package:flutter/material.dart';
import 'package:news_ware/helper/text_field_container.dart';
import 'package:news_ware/utils/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {

  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
    @override
  Widget build(BuildContext context) {


    return TextFieldContainer(
      child: TextFormField(
        validator: widget.validator,
        obscureText: _isHidden,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffix:InkWell(
          onTap: _togglePasswordView,  /// This is Magical Function
          child: Icon(
            _isHidden ?         /// CHeck Show & Hide.
            Icons.visibility :
            Icons.visibility_off,
          ),
        ),
          // suffixIcon: IconButton(
          //   icon: const Icon(
          //     Icons.visibility,
          //     color: kPrimaryColor,
          //   ),
          //   onPressed: () {
          //     hide = !hide;
          //   },
          // ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

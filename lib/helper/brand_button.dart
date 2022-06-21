import 'package:flutter/material.dart';

class BrandButton extends StatelessWidget {
  final String label;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Widget brandIcon;
  final VoidCallback? onPress;

  const BrandButton(
      {Key? key,
      required this.label,
      this.height = 48,
      this.backgroundColor = Colors.white,
      required this.brandIcon,
      this.textColor = Colors.black,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: height,
      child: ElevatedButton(
          onPressed: () async {
            onPress;
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29))),
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                brandIcon,
                const SizedBox(width: 20),
                Text(
                  label,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      height: 1.41),
                )
              ],
            ),
          )),
    );
  }
}

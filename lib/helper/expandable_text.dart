import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final double max;
  const ExpandableText({Key? key, required this.text, required this.max})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  TextPainter? textPainter;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return isOpen
        ? SizedBox(
            child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(children: [
                    TextSpan(
                        text: widget.text,
                        style: TextStyle(color: Colors.black54)),
                    WidgetSpan(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                isOpen = !isOpen;
                              });
                            },
                            child: Text(
                              "  less",
                              style: TextStyle(color: Colors.black),
                            )),
                        style: TextStyle(color: Colors.black54))
                  ]),
                )))
        : Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.start,
              maxLines: 4,
              text: TextSpan(children: [
                TextSpan(
                    text: widget.text.substring(
                            0,
                            int.parse(
                                "${(widget.text.length * widget.max).toInt()}")) +
                        "...",
                    style: TextStyle(color: Colors.black54)),
                WidgetSpan(
                    child: InkWell(
                  mouseCursor: SystemMouseCursors.click,
                  onTap: () {
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  child:
                      Text("Read more", style: TextStyle(color: Colors.black)),
                )),
              ]),
            ),
          );
  }
}

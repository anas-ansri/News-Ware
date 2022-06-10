import 'package:flutter/material.dart';
import 'package:news_ware/widgets/loading.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: const [
          Loading(),
          // Text("Saved page is under-construction",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.grey)),
          // SizedBox(
          //   height: 30,
          // ),
          // Icon(
          //   Icons.construction,
          //   size: 50,
          //   color: Colors.grey,
          // )
        ],
      ),
    );
  }
}

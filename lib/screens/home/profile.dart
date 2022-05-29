import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/helper/rounded_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedButton(
              text: "Insert",
              press: () async {
                FirebaseFirestore.instance
                    .collection('data')
                    .add({'text': 'data added through app'});
              }),
          const Text("This page is under-construction",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
          SizedBox(
            height: 30,
          ),
          Icon(
            Icons.construction,
            size: 50,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:news_ware/models/user.dart';
import 'package:news_ware/services/auth.dart';

class DatabaseService {
  final String uid;
  // final String country;

  DatabaseService({required this.uid});

  Future getUid() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  // User? user = FirebaseAuth.instance.currentUser;
  //Collection Refrance
  final CollectionReference userData =
      FirebaseFirestore.instance.collection("UserData");

  // await ref.set({
  //   "name": "John",
  //   "age": 18,
  //   "address": {
  //     "line1": "100 Mountain View"
  //   }
  // });

  //Check if document exist
  Future<bool> isDocExists() async {
    try {
      var doc = await userData.doc(uid).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future userSetup(String? displayName, String? email, String? photoUrl,
      String? method) async {
    bool docExists = await isDocExists();
    if (docExists) {
      return;
    } else {
      return await userData.doc(uid).set({
        'uid': uid,
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        'country': "in",
        'method': method
      });
    }
  }

  Future setCountry(String country) async {
    try {
      return await userData.doc(uid).update({'country': country});
    } catch (e) {
      rethrow;
    }
  }

  Future getCountry() async {
    try {
      String country;
      // Stream documentStream = userData.doc(uid).snapshots();
      // final docRef = userData.doc(uid);
      userData.doc(uid).snapshots().listen(
        (event) {
          print("current data: ${event.data()}");
          var data = event.data();
          // dat
          // return data["country"];
          // var jsonData = jsonDecode(data);
          // data.foreach(()=>)
        },
        onError: (error) => print("Listen failed: $error"),
      );
      // await userData.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      //   // print(documentSnapshot["country"]);
      //   country = documentSnapshot["country"];
      //   // return country;
      // });
      // print(country);
      // return country;
    } catch (e) {
      rethrow;
    }
  }

  //UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid,
      snapshot["displayName"],
      snapshot["email"],
      snapshot["photoUrl"],
      snapshot["country"],
    );
  }

  //Get user doc steam
  Stream<UserData> get userDetail {
    return userData.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

class Db {
  late String uid;

  //Firebase realtime database
  FirebaseDatabase database = FirebaseDatabase.instance;

  // late DatabaseReference ref = FirebaseDatabase.instance.ref("saved/$uid");

  Future saveArticle(
      String timeStamp,
      String source,
      String author,
      String urlImage,
      String title,
      String dec,
      String time,
      String url) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference ref = database.ref("saved/$uid/$timeStamp");
    await ref.set({
      "source": source,
      "author": author,
      "urlImage": urlImage,
      "title": title,
      "dec": dec,
      "time": time,
      "url": url
    });
  }

  Future removeArticle(String saveId) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    return await database
        .ref()
        .child("saved")
        .child(uid)
        .child(saveId)
        .remove();
  }
}

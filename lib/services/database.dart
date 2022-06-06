import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:news_ware/models/user.dart';
import 'package:news_ware/services/auth.dart';

class DatabaseService {
  final String uid;

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
      return FutureBuilder<DocumentSnapshot>(
        future: userData.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return data['country'];
          }

          return Text("loading");
        },
      );
    } catch (e) {
      rethrow;
    }
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

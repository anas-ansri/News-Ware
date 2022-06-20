import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:news_ware/models/article_model.dart';
import 'package:news_ware/models/user.dart';

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
        'method': method,
      });
    }
  }

  Future updateUserName(String displayName) async {
    try {
      return await userData.doc(uid).update({'displayName': displayName});
    } catch (e) {
      rethrow;
    }
  }

  Future updateUserPic(String photoUrl) async {
    try {
      return await userData.doc(uid).update({'photoUrl': photoUrl});
    } catch (e) {
      rethrow;
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
      // Stream documentStream = userData.doc(uid).snapshots();
      // final docRef = userData.doc(uid);
      userData.doc(uid).snapshots().listen(
        (event) {
          // print("current data: ${event.data()}");
          // dat
          // return data["country"];
          // var jsonData = jsonDecode(data);
          // data.foreach(()=>)
        },
        // onError: (error) => print("Listen failed: $error"),
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
    return UserData(uid, snapshot["displayName"], snapshot["email"],
        snapshot["photoUrl"], snapshot["country"], snapshot["method"]);
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

  Future readRecord(
      String timeStamp,
      String source,
      String author,
      String urlImage,
      String title,
      String dec,
      String time,
      String url) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference ref = database.ref("activity/$uid/read/$timeStamp");
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

  Future searchRecord(
    String timeStamp,
    String query,
  ) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference ref = database.ref("activity/$uid/search/$timeStamp");
    DateTime now = DateTime.now();
    String currentDt = DateFormat().add_yMEd().add_jm().format(now);
    await ref.set({
      "date_time": currentDt,
      "query": query,
    });
  }

  Future removeArticle(String url) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    var ref = database.ref().child("saved").child(uid);
    await ref.once().then((DatabaseEvent databaseEvent) {
      var docs = databaseEvent.snapshot.children;
      for (var element in docs) {
        String docId = element.key as String;
        // print(element.key);
        for (var element in element.children) {
          if (element.value == url) {
            ref.child(docId).remove();
            break;
          }
        }
      }
    });
  }

  Future<void> removeDoc(String docId) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    return await database.ref().child("saved").child(uid).child(docId).remove();
  }

  Future<bool> isSaved(String url) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    bool isExist = false;
    var ref = database.ref().child("saved").child(uid);
    await ref.once().then((DatabaseEvent databaseEvent) {
      var docs = databaseEvent.snapshot.children;
      for (var element in docs) {
        // print(element.key);
        for (var element in element.children) {
          if (element.value == url) {
            isExist = true;
            break;
          }
        }
      }
    });
    return isExist;
  }

  Future<List<ArticleModel>?> getArticles() async {
    List<ArticleModel> articles = [];
    uid = FirebaseAuth.instance.currentUser!.uid;

    var ref = FirebaseDatabase.instance.ref().child("saved").child(uid);
    await ref.once().then((DatabaseEvent databaseEvent) {
      var docs = databaseEvent.snapshot.children;
      for (var element in docs) {
        Map<String, dynamic> data = jsonDecode(jsonEncode(element.value));
        var article = ArticleModel.fromJson(Map<String, dynamic>.from(data));
        // print(article.title);
        // ArticleModel article = ArticleModel(
        //   author: articleData.author,
        //   description: articleData.description,
        //   sourceName: articleData.sourceName,
        //   publishedAt: articleData.publishedAt,
        //   title: articleData.title,
        //   url: articleData.url,
        //   urlToImage: articleData.url,
        // );

        // List<ArticleModel> article =
        // print(article);
        articles.add(article);
      }
    });
    // print(articles);
    return articles;
  }

  Future sendFeedback(
      String type, String name, String email, String description) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    // bool isExist = false;
    var ref = database.ref().child("feedback").child(type).child(timeStamp);
    await ref.set({"name": name, "email": email, "description": description});
  }

  Future<List<String>?> getApiKeys() async {
    List<String> apiKeys = [];

    var ref = FirebaseDatabase.instance.ref().child("apiKeyList");
    await ref.once().then((DatabaseEvent databaseEvent) {
      var docs = databaseEvent.snapshot.children;

      for (var element in docs) {
        // Map<String, dynamic> data = jsonDecode(jsonEncode(element.value));
        // var article = ArticleModel.fromJson(Map<String, dynamic>.from(data));
        String apiKey = jsonDecode(jsonEncode(element.value));

        // var article = ArticleModel.fromJson(Map<String, dynamic>.from(data));
        // print(article.title);
        // ArticleModel article = ArticleModel(
        //   author: articleData.author,
        //   description: articleData.description,
        //   sourceName: articleData.sourceName,
        //   publishedAt: articleData.publishedAt,
        //   title: articleData.title,
        //   url: articleData.url,
        //   urlToImage: articleData.url,
        // );

        // List<ArticleModel> article =
        // print(article);
        apiKeys.add(apiKey);
      }
    });
    // print(articles);
    return apiKeys;
  }
}

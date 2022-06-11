import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(
    String displayName, String email, String photoUrl) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();
  CollectionReference users = FirebaseFirestore.instance.collection('UserData');
  users.add({
    'uid': uid,
    'displayName': displayName,
    'email': email,
    'photoUrl': photoUrl
  });

  // FirebaseFirestore.instance.collection("users").doc(uid).set({
  //   'uid': uid,
  //   'displayName': displayName,
  //   'email': email,
  //   'photoUrl': photoUrl
  // }).then((value) {
  //   print("Hello");
  // print(value.id);
  // });

  return;
}

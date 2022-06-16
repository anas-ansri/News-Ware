// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_ware/models/user.dart';
import 'package:news_ware/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _guser;

  GoogleSignInAccount? get guser {
    return _guser;
  }

  MyUser? _userFromFirebaseUser(User user) {
    if (user != null) {
      return MyUser(uid: user.uid);
    } else {
      return null;
    }
  }

  //auth change user steam
  // Continue from here
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  Future registerWithEmail(
      String email, String password, String displayName) async {
    // try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = result.user;

    await DatabaseService(uid: user!.uid).userSetup(
        displayName,
        user.email,
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
        "Normal");
    _userFromFirebaseUser(user);
    // } catch (e) {
    //   print(e.toString());
    // }
  }

//sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      print(email);
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In with google
  Future googleLogIn() async {
    // try {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _guser = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = result.user;

    await DatabaseService(uid: user!.uid)
        .userSetup(user.displayName, user.email, user.photoURL, "Google");
    _userFromFirebaseUser(user);
    // } on Exception catch (e) {
    //   print(e.toString());
    // }
  }

//sign out
  Future signOut() async {
    try {
      try {
        await googleSignIn.disconnect();
      } catch (e) {
        print(e);
      }

      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  showAlertDialog(BuildContext context, String error) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black38, width: 0)),
      title: const Text("Something went wrong!!"),
      content: Text("Error: $error"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

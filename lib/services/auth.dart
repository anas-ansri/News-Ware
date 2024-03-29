import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return MyUser(uid: user.uid);
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
    try {
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
      return result;
    } on Exception catch (e) {
      // TODO
      return null;
    }
    // } catch (e) {
    //   print(e.toString());
    // }
  }

//sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // print(email);
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      _userFromFirebaseUser(user!);
      return null;
    } catch (e) {
      // print(e.toString());
      return e;
    }
  }

  //Sign In with google
  Future googleLogIn() async {
    try {
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
    } on PlatformException catch (e) {
      print(e.toString());
      return e;
    }
  }

//sign out
  Future signOut(String method) async {
    try {
      if (method == "Google") {
        print(method);
        print(method);
        print(method);
        await googleSignIn.disconnect();
      }
      await _auth.signOut();

      return null;
    } catch (e) {
      return e;
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

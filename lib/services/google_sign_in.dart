import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/helper/userSetup.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user {
    return _user;
  }

  Future googleLogIn() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      userSetup(googleUser.displayName.toString(), googleUser.email.toString(),
          googleUser.photoUrl.toString());
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

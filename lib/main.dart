import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_ware/utils/constants.dart';
import 'package:news_ware/screens/other/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Returns an instance of the WidgetsBinding, creating and initializing it if necessary.

  await Firebase.initializeApp();
  ByteData data = await PlatformAssetBundle().load('assets/ca/encrypt.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SourceSansPro',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          // or from RG
          primary: kPrimaryColor,
          secondary: secondryColor,

          //  const Color(0xFFFFC107),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

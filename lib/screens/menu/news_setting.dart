import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:news_ware/services/database.dart';

class NewsSetting extends StatelessWidget {
  const NewsSetting({Key? key}) : super(key: key);
  final Color backgroundColor = const Color(0xFF0D6EFD);

  @override
  Widget build(BuildContext context) {
    String country = 'in';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("News Setting"),
        centerTitle: true,
        backgroundColor: backgroundColor,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 50, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Choose your country",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const SizedBox(
              height: 30,
            ),
            CountryCodePicker(
              initialSelection: country,
              showCountryOnly: true,
              showOnlyCountryWhenClosed: true,
              favorite: const ["us", "in"],
              onChanged: (value) {
                String uid = FirebaseAuth.instance.currentUser!.uid;
                DatabaseService db = DatabaseService(uid: uid);
                db.setCountry(value.code!);
              },
            )
          ],
        ),
      ),
    );
  }
}

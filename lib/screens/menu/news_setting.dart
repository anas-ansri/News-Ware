import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_ware/models/user.dart';
import 'package:news_ware/services/database.dart';
import 'package:news_ware/utils/constants.dart';

class NewsSetting extends StatefulWidget {
  const NewsSetting({Key? key}) : super(key: key);

  @override
  State<NewsSetting> createState() => _NewsSettingState();
}

class _NewsSettingState extends State<NewsSetting> {
  final Color backgroundColor = const Color(0xFF0D6EFD);

  UserData? userData;

  // Future country = db.getCountry();
  @override
  Widget build(BuildContext context) {
    // print(allCountries.length);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseService db = DatabaseService(uid: uid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("News Setting"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
      ),
      body: StreamBuilder<UserData>(
          stream: DatabaseService(uid: uid).userDetail,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              userData = snapshot.data;
              return Container(
                padding: const EdgeInsets.fromLTRB(20, 50, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Choose your country",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(
                      height: 30,
                    ),
                    CountryCodePicker(
                      initialSelection: userData?.country,
                      showCountryOnly: true,
                      countryFilter: allCountries,
                      showOnlyCountryWhenClosed: true,
                      favorite: const ["us", "in"],
                      onChanged: (value) {
                        // String uid = FirebaseAuth.instance.currentUser!.uid;
                        // DatabaseService db = DatabaseService(uid: uid);
                        db.setCountry(value.code!);

                        // print(db.country);
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              );
            }
          }),
    );
  }
}

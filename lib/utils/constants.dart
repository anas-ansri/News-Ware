import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

//Primary Color: 0xFF0D6EFD
//Font : Source Sans Pro

const kPrimaryColor = Color.fromRGBO(20, 36, 108, 1);
//  Color.fromRGBO(4, 92, 204, 0.9);

// Color(0xFF0D6EFD);
Widget appTitle = const Text(
  "NEWSWARE",
  style: TextStyle(
      // fontStyle: FontStyle.italic,
      fontFamily: "AbrilFatface",
      // fontStyle: FontStyle.italic,
      // fontWeight: FontWeight.bold,
      color: Colors.white), ////HexColor("#fc6424")
);
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Text(
//       "NEWSWARE",
//       style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.white), ////HexColor("#fc6424")
//     ),
//     // Text(
//     //   "WARE",
//     //   style: GoogleFonts.pacifico(
//     //       fontWeight: FontWeight.bold,
//     //       color: Colors.white), ////HexColor("#fc6424")
//     // ),
//   ],
// );

const kPrimaryLightColor = Color.fromARGB(255, 126, 132, 153);
const secondryColor = Color.fromARGB(255, 206, 178, 255);
// const secondryColor = Colors.black12;
// const primaryFont = FontFa,

const double defaultPadding = 16.0;

getHeightValue(BuildContext context) {
  double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
  return unitHeightValue;
}

getWidthValue(BuildContext context) {
  double unitWidthtValue = MediaQuery.of(context).size.height * 0.01;
  return unitWidthtValue;
}

const List<String> allCountries = [
  "ae",
  "ar",
  "at",
  "au",
  "be",
  "bg",
  "br",
  "ca",
  "ch",
  "cn",
  "co",
  "cu",
  "cz",
  "de",
  "eg",
  "fr",
  "gb",
  "gr",
  "hk",
  "hu",
  "id",
  "ie",
  "il",
  "in",
  "it",
  "jp",
  "kr",
  "lt",
  "lv",
  "ma",
  "mx",
  "my",
  "ng",
  "nl",
  "no",
  "nz",
  "ph",
  "pl",
  "pt",
  "ro",
  "rs",
  "ru",
  "sa",
  "se",
  "sg",
  "si",
  "sk",
  "th",
  "tr",
  "tw",
  "ua",
  "us",
  "ve",
  "za"
];

showErrorAlert(BuildContext context, String error) {
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

showAlertDialog(
    BuildContext context, String title, String content, bool isFeedback) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
      if (isFeedback) {
        Navigator.of(context).pop();
      }
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.black38, width: 0)),
    title: Text(title),
    content: Text(content),
    // title: const Text("Photo not selected"),
    // content: const Text("You haven't selected any picture."),
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

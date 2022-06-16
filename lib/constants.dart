import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF0D6EFD);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

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

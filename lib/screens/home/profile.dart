import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_ware/constants.dart';
import 'package:news_ware/helper/rounded_button.dart';
import 'package:news_ware/helper/rounded_input_field.dart';
import 'package:news_ware/helper/text_field_widget.dart';
import 'package:news_ware/models/user.dart';
import 'package:news_ware/services/database.dart';
import 'package:news_ware/widgets/profile_widget.dart';

class Profile extends StatefulWidget {
  UserData? userData;

  Profile({Key? key, required this.userData}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Db db = Db();
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        // Spacer(),
        SizedBox(
          height: 150,
        ),
        ProfileWidget(
          imagePath: widget.userData!.photoUrl,
          onClicked: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                        userData: widget.userData,
                      )),
            );
          },
        ),
        const SizedBox(height: 24),
        buildName(widget.userData!),
      ],
    );
  }

  Widget buildName(UserData userData) => Column(
        children: [
          Text(
            userData.displayName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            userData.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key, required this.userData}) : super(key: key);
  UserData? userData;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _newName = "";
  String _newPhotoUrl = "";

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseService db = DatabaseService(uid: uid);
    //     Future uploadPic(BuildContext context) async{
    //   String fileName = basename(_image.path);
    //       Reference reference = FirebaseStorage.instance.ref().child(
    //                 'UserData/$uid/profile_pic.jpg');
    //             UploadTask uploadTask = reference.putFile(_image);
    //    TaskSnapshot taskSnapshot=await uploadTask.onComplete;
    //    setState(() {
    //       print("Profile Picture uploaded");
    //       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    //    });
    // }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 60,
            ),
            ProfileWidget(
              imagePath: (_newPhotoUrl == ""
                  ? widget.userData!.photoUrl
                  : _newPhotoUrl),
              isEdit: true,
              onClicked: () async {
                String downloadURL;

                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 25,
                );
                if (pickedFile == null) {
                  return showAlertDialog(context);
                } else {
                  File image = File(pickedFile.path);

                  var reference = FirebaseStorage.instance.ref().child(
                      'UserData/$uid/profile_pic.jpg'); // Modify this path/string as your need
                  UploadTask uploadTask = reference.putFile(image);
                  downloadURL = await (await uploadTask).ref.getDownloadURL();
                  setState(() {
                    _newPhotoUrl = downloadURL;
                    print(downloadURL);
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: widget.userData!.displayName,
              onChanged: (name) {
                setState(() {
                  _newName = name;
                });
              },
            ),

            // RoundedInputField(
            //   hintText: "Your Name",
            //   onChanged: (value) {
            //     _newName = value;
            //   },
            // ),
            const SizedBox(height: 24),
            TextFieldWidget(
              readOnly: true,
              label: 'Email',
              text: widget.userData!.email,
              onChanged: (email) {},
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "You can not modify email",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red[300]),
            ),
            const SizedBox(height: 24),
            RoundedButton(
                text: "Save",
                press: () async {
                  if (_newName != "") {
                    await db.updateUserName(_newName);
                  }
                  if (_newPhotoUrl != "") {
                    await db.updateUserPic(_newPhotoUrl);
                  }
                  Navigator.of(context).pop();
                })
          ],
        ));
  }

  showAlertDialog(BuildContext context) {
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
      title: const Text("Photo not selected"),
      content: const Text("You haven't selected any picture."),
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

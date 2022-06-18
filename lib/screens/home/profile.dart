import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_ware/utils/constants.dart';
import 'package:news_ware/helper/rounded_button.dart';
// import 'package:news_ware/helper/rounded_input_field.dart';
import 'package:news_ware/helper/text_field_widget.dart';
import 'package:news_ware/models/user.dart';
import 'package:news_ware/screens/other/user_page.dart';
import 'package:news_ware/services/database.dart';
import 'package:news_ware/widgets/profile_widget.dart';

class Profile extends StatefulWidget {
  final UserData? userData;

  const Profile({Key? key, required this.userData}) : super(key: key);

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
        const SizedBox(
          height: 40,
        ),
        ProfileWidget(
          onClick: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserPage(
                name: widget.userData!.displayName,
                urlImage: widget.userData!.photoUrl,
              ),
            ));
          },
          imagePath: widget.userData!.photoUrl,
        ),
        const SizedBox(height: 24),
        buildName(widget.userData!),
        Padding(
          padding: const EdgeInsets.all(45.0),
          child: RoundedButton(
              fontSize: 2.5 * getWidthValue(context),
              text: "Edit",
              press: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                            userData: widget.userData,
                          )),
                );
              }),
        )
      ],
    );
  }

  Widget buildName(UserData userData) => Column(
        children: [
          Text(
            userData.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            userData.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.userData}) : super(key: key);
  final UserData? userData;

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
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 60,
            ),
            EditProfileWidget(
              imagePath: (_newPhotoUrl == ""
                  ? widget.userData!.photoUrl
                  : _newPhotoUrl),
              isEdit: true,
              onClicked: () async {
                String downloadURL;

                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 10,
                );
                if (pickedFile == null) {
                  return showAlertDialog(context, "Photo not selected",
                      "Please select a picture.", false);
                } else {
                  File image = File(pickedFile.path);

                  var reference = FirebaseStorage.instance.ref().child(
                      'UserData/$uid/profile_pic.jpg'); // Modify this path/string as your need
                  UploadTask uploadTask = reference.putFile(image);
                  downloadURL = await (await uploadTask).ref.getDownloadURL();
                  if (!mounted) return;
                  setState(() {
                    _newPhotoUrl = downloadURL;
                    // print(downloadURL);
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
            const SizedBox(
              height: 10,
            ),
            Text(
              "You can not modify email",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red[300]),
            ),
            const SizedBox(height: 24),
            RoundedButton(
                fontSize: getWidthValue(context) * 2.5,
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
}

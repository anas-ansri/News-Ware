// import 'dart:html';

// import 'package:email_validator/email_validator.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';

import 'package:news_ware/utils/constants.dart';

import 'package:news_ware/services/database.dart';

class FeedbackPage extends StatefulWidget {
  final String name;
  final String email;
  const FeedbackPage({Key? key, required this.email, required this.name})
      : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _messageController = TextEditingController();

  final double minValue = 5.0;
  final _feedbackTypeList = <String>["Comments", "Bugs", "Questions"];

  String _feedbackType = "";
  String _name = "";
  String _email = "";
  String _description = "";

  final TextStyle _errorStyle = const TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  @override
  initState() {
    _feedbackType = _feedbackTypeList[0];
    _name = widget.name;
    _email = widget.email;

    super.initState();
  }

  Widget _buildHeader() {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
            vertical: minValue * 4, horizontal: minValue * 3),
        height: 260.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: minValue * 2,
            ),
            const Text(
              "Write Us",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white),
            ),
            SizedBox(
              width: 120.0,
              child: Container(
                height: 5,
                color: secondryColor,
              ),
            ),
            SizedBox(
              height: minValue * 4,
            ),
            Text(
              "Dear User, Feel free to write us. Your feedback is crucial to understanding how to add value to our app and improve user satisfaction.",
              style: TextStyle(
                  fontSize: 2.0 * getWidthValue(context),
                  color: Colors.grey[200]),
            ),
          ],
        ),
        decoration: const BoxDecoration(color: kPrimaryColor) //Colors.black87),
        );
  }

  Widget _buildCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      // child: SafeArea(
      //   right: true,
      child: Row(
        children: <Widget>[
          Text(
            "Select feedback type",
            style: TextStyle(
                fontSize: 2.0 * getWidthValue(context),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: DropdownButton<String>(
              onChanged: (type) {
                setState(() {
                  _feedbackType = type!;
                });
              },
              hint: Text(
                _feedbackType,
                style: TextStyle(fontSize: 2.0 * getWidthValue(context)),
              ),
              items: _feedbackTypeList
                  .map((type) => DropdownMenuItem<String>(
                        child: Text(type),
                        value: type,
                      ))
                  .toList(),
            ),
          ))
        ],
      ),
      // ),
    );
  }

  Widget _buildName() {
    final TextEditingController _nameController =
        TextEditingController(text: widget.name);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        onChanged: (value) {
          _name = value;
        },
        // initialValue: "Anas Ansari"
        controller: _nameController,
        // validator: usernameValidator,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            hintText: 'Full Name',
            labelText: 'Full  Name',
            labelStyle: const TextStyle(fontSize: 13.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildEmail() {
    final TextEditingController _emailController =
        TextEditingController(text: widget.email);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.text,
        // validator: validateEmail,
        onChanged: (String value) {
          _email = value;
        },
        readOnly: false,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            border: const UnderlineInputBorder(),
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelText: 'Email',
            labelStyle: const TextStyle(fontSize: 13.0, color: Colors.black87)),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      child: TextFormField(
        onChanged: (value) {
          _description = value;
        },
        controller: _messageController,
        keyboardType: TextInputType.text,
        maxLines: 2,
        decoration: InputDecoration(
            errorStyle: _errorStyle,
            labelText: 'Description',
            contentPadding:
                EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
            labelStyle: const TextStyle(fontSize: 13.0, color: Colors.black87)),
      ),
    );
  }

  Db db = Db();
  String error = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Feedback"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          actions: [
            TextButton(
                onPressed: () {
                  if (_name != "" && _email != "" && _description != "") {
                    loading = true;
                    db
                        .sendFeedback(
                            _feedbackType, _name, _email, _description)
                        .then((value) {
                      loading = false;
                      showAlertDialog(context, "Thank you for your feedback.",
                          "We will get back to you as soon as we can.", true);
                      // Navigator.of(context).pop();

                      // Navigator.of(context).pushAndRemoveUntil(newRoute, (route) => false);
                      // Navigator.of(context).popAndPushNamed();
                    });
                  } else {
                    showAlertDialog(context, "Something went wrong!",
                        "Please enter information in all fields.", false);
                  }
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ))
          ],
          // leading: IconButton(
          //     icon: Icon(Icons.close),
          //     color: Colors.black87,
          //     onPressed: () => null),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: loading
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 200,
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      _buildHeader(),
                      _buildCategory(),
                      SizedBox(
                        height: minValue,
                      ),
                      _buildName(),
                      SizedBox(
                        height: minValue * 3,
                      ),
                      _buildEmail(),
                      SizedBox(
                        height: minValue * 3,
                      ),
                      _buildDescription(),
                      SizedBox(
                        height: minValue * 3,
                      ),
                      Text(error)
                    ],
                  ),
                ),
              ));
  }
}

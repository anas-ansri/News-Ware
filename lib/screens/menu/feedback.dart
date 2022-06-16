// import 'dart:html';

// import 'package:email_validator/email_validator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_ware/constants.dart';
import 'package:news_ware/helper/rounded_button.dart';
import 'package:news_ware/services/database.dart';
import 'package:news_ware/utils/validator.dart' as v;
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  late String name;
  late String email;
  FeedbackPage({Key? key, required this.email, required this.name})
      : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _messageController = TextEditingController();

  final double minValue = 8.0;
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
                  fontSize: 48.0,
                  color: Colors.white),
            ),
            SizedBox(
              width: 110.0,
              child: Container(
                height: 6,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              height: minValue * 4,
            ),
            Text(
              "Dear User, Feel free to write us. Your feedback is crucial to understanding how to add value to our app and improve user satisfaction..",
              style: TextStyle(fontSize: 16.0, color: Colors.grey[200]),
            ),
          ],
        ),
        decoration:
            const BoxDecoration(color: Colors.black87) //Colors.black87),
        );
  }

  Widget _buildCategory() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: minValue * 2, horizontal: minValue * 3),
      child: Row(
        children: <Widget>[
          const Text(
            "Select feedback type",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: minValue * 2,
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
                style: const TextStyle(fontSize: 16.0),
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
            labelStyle: const TextStyle(fontSize: 16.0, color: Colors.black87)),
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
            labelStyle: const TextStyle(fontSize: 16.0, color: Colors.black87)),
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
            labelStyle: const TextStyle(fontSize: 16.0, color: Colors.black87)),
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
                  if (_name != "" || _email != "" || _description != "") {
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
                    setState(() {
                      error = "Please enter all information";
                    });
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
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
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
              ));
  }
}

import 'package:flutter/material.dart';
import 'package:news_ware/screens/home/home.dart';
import 'package:news_ware/screens/menu/about_us.dart';
import 'package:news_ware/screens/menu/feedback.dart';
import 'package:news_ware/screens/menu/myactivity.dart';
import 'package:news_ware/screens/menu/news_setting.dart';
import 'package:news_ware/screens/menu/user_page.dart';
import 'package:news_ware/services/auth.dart';
import 'package:provider/provider.dart';

import '../services/google_sign_in.dart';

typedef VoidCallback = void Function();

class NavigationDrawerWidget extends StatelessWidget {
  String name;
  String email;
  String urlImage;

  NavigationDrawerWidget(
      {Key? key,
      required this.email,
      required this.name,
      required this.urlImage})
      : super(key: key);
  final Color backgroundColor = const Color(0xFF0D6EFD);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    //Variables for Header in draw
    return Drawer(
      child: Material(
          color: backgroundColor,
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
              // Row(
              //   children: [
              //     IconButton(
              //         onPressed: () {
              //           Navigator.of(context).pop();
              //         },
              //         icon: const Icon(
              //           Icons.arrow_back,
              //           color: Colors.white,
              //         ))
              //   ],
              // ),
              buildHeader(
                  urlImage: urlImage,
                  name: name,
                  email: email,
                  // onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>
                  //         UserPage(name: name, urlImage: urlImage)))
                  onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeScreen(selectedIndex: 2)))),
              const SizedBox(
                height: 20,
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  children: [
                    const Divider(
                      color: Colors.white70,
                    ),
                    buildMenuItem(
                        text: "My Activity",
                        icon: Icons.history,
                        onClick: () => selectedItem(context, 0)),
                    buildMenuItem(
                        text: "News Setting",
                        icon: Icons.settings,
                        onClick: () => selectedItem(context, 1)),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    const Divider(
                      color: Colors.white70,
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    buildMenuItem(
                        text: "Feedback",
                        icon: Icons.feedback,
                        onClick: () => selectedItem(context, 2)),
                    buildMenuItem(
                        text: "About Us ",
                        icon: Icons.more,
                        onClick: () => selectedItem(context, 3)),
                    const Divider(
                      color: Colors.white70,
                    ),
                    ListTile(
                      onTap: (() {
                        final provider =
                            Provider.of<AuthService>(context, listen: false);
                        provider.signOut();
                      }),
                      title: const Text(
                        "Sign Out ",
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: const Icon(Icons.logout, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

Widget buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClick}) {
  const color = Colors.white;
  const hoverColor = Colors.white24;

  return ListTile(
    onTap: onClick,
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: const TextStyle(color: color),
    ),
    hoverColor: hoverColor,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MyActivity(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NewsSetting(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const FeedbackPage(),
      ));
      break;
    case 3:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AboutUs(),
      ));
      break;
  }
}

Widget buildHeader(
        {required String urlImage,
        required String name,
        required String email,
        required VoidCallback? onClicked}) =>
    InkWell(
      onTap: onClicked,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
          child: Row(
            children: [
              //Profile pic avatar
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 5)
            ],
          ),
        ),
      ),
    );

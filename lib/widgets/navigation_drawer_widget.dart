import 'package:flutter/material.dart';
import 'package:news_ware/constants.dart';
import 'package:news_ware/screens/home/home.dart';
import 'package:news_ware/screens/menu/about_us.dart';
import 'package:news_ware/screens/menu/feedback.dart';
import 'package:news_ware/screens/menu/myactivity.dart';
import 'package:news_ware/screens/menu/news_setting.dart';
import 'package:news_ware/services/auth.dart';

typedef VoidCallback = void Function();

class NavigationDrawerWidget extends StatefulWidget {
  final String name;
  final String email;
  final String urlImage;

  const NavigationDrawerWidget(
      {Key? key,
      required this.email,
      required this.name,
      required this.urlImage})
      : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final AuthService _auth = AuthService();

  final padding = const EdgeInsets.symmetric(horizontal: 20);

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
          builder: (context) =>
              FeedbackPage(email: widget.email, name: widget.name),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AboutUs(),
        ));
        break;
    }
  }
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double widthValue = MediaQuery.of(context).size.width * 0.01;
    //Variables for Header in draw
    return Drawer(
      child: Material(
          color: kPrimaryColor,
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
              buildHeader(
                  urlImage: widget.urlImage,
                  name: widget.name,
                  email: widget.email,
                  widthValue: widthValue,
                  // onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>
                  //         UserPage(name: name, urlImage: urlImage)))
                  onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeScreen(selectedIndex: 2))
                  )
      ),
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
                      onTap: (() async {





                          dynamic result = await _auth.signOut();
                          if(result != null){
                            showErrorAlert(context, result);
                          }


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

  Widget buildHeader(
          {required String urlImage,
          required String name,
          required String email,
          required VoidCallback? onClicked,
          required double widthValue}) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  //Profile pic avatar
                  CircleAvatar(
                      radius: widthValue * 10,
                      backgroundImage: NetworkImage(urlImage)),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: widthValue * 7, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        email,
                        style: TextStyle(
                            fontSize: widthValue * 4, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5)
                ],
              ),
            ),
          ),
        ),
      );
}

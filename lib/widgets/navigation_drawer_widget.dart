import 'package:flutter/material.dart';
import 'package:news_ware/screens/menu/about_us.dart';
import 'package:news_ware/screens/menu/feedback.dart';
import 'package:news_ware/screens/menu/myactivity.dart';
import 'package:news_ware/screens/menu/news_setting.dart';
import 'package:news_ware/screens/menu/user_page.dart';

typedef VoidCallback = void Function();

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final Color backgroundColor = const Color(0xFF0D6EFD);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    //Variables for Header in draw
    const name = "Anas Ansari";
    const email = "anasalansari4@outlook.com";
    const urlImage =
        "https://instagram.fbom17-1.fna.fbcdn.net/v/t51.2885-19/277699386_395153375945574_5669888527873857587_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fbom17-1.fna.fbcdn.net&_nc_cat=106&_nc_ohc=xQFriyUpBXUAX_sbzgg&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT-va2coRFskpxv3kI1q7FBLGZOEZjdkMsCtNkVZE6acLA&oe=625BE2B3&_nc_sid=7bff83";

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
                  onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const UserPage(name: name, urlImage: urlImage)))),
              const SizedBox(
                height: 20,
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  children: [
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
                    buildMenuItem(text: "Sign Out ", icon: Icons.logout),
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
        builder: (context) => const NewsSetting(),
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
            const Spacer(),
            const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            const SizedBox(width: 5)
          ],
        ),
      ),
    );

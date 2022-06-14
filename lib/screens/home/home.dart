// import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:news_ware/constants.dart';
import 'package:news_ware/helper/loading_splash.dart';
import 'package:news_ware/models/user.dart';

import 'package:news_ware/screens/home/feed.dart';
import 'package:news_ware/screens/home/profile.dart';
import 'package:news_ware/screens/home/saved.dart';
import 'package:news_ware/services/database.dart';
import 'package:news_ware/widgets/loading.dart';
import 'package:news_ware/widgets/navigation_drawer_widget.dart';
import 'package:news_ware/widgets/search_page.dart';

class HomeScreen extends StatefulWidget {
  int selectedIndex = 0;
  HomeScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color backgroundColor = const Color(0xFF0D6EFD);
  PageController pageController = PageController();
  UserData? userData;

  @override
  void initState() {
    pageController = PageController(
      initialPage: widget.selectedIndex,
    );
    super.initState();
  }

  void onTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 10), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseService db = DatabaseService(uid: uid);
    Color navyColor = Colors.white;
    return StreamBuilder(
        stream: DatabaseService(uid: uid).userDetail,
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.hasData) {
            userData = snapshot.data;
            return Scaffold(
                //Side Bar Menu
                drawer: NavigationDrawerWidget(
                    name: userData!.displayName,
                    email: user.email!,
                    urlImage: userData!.photoUrl),

                //App Bar
                appBar: AppBar(
                  title: const Text(
                    "News Ware",
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                  backgroundColor: backgroundColor,
                  elevation: 0,
                  actions: [
                    IconButton(
                        onPressed: () {
                          showSearch(
                              context: context, delegate: MySearchDelegate());
                        },
                        icon: const Icon(Icons.search))
                    // Switch(
                    //     value: false,
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         newValue = true;
                    //       });
                    //     })
                  ],
                ),
                //Body
                body: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    Feed(
                      userData: userData,
                    ),
                    const Saved(),
                    Profile(
                      userData: userData,
                    )
                  ],
                ),

                //Bottom Navigation bar
                bottomNavigationBar: Theme(
                  data: Theme.of(context).copyWith(
                    // sets the background color of the `BottomNavigationBar`
                    canvasColor: backgroundColor,
                    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                    // primaryColor: Colors.lightBlue,
                    // textTheme: Theme.of(context).textTheme.copyWith(
                    //     caption: new TextStyle(color: Colors.yellow)
                  ), // sets the inactive color of the `BottomNavigationBar`

                  // child: SafeArea(
                  //   child: Padding(
                  //     padding:
                  //         const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  //     child: BubbleBottomBar(
                  //       backgroundColor: kPrimaryColor,
                  //       tilesPadding: EdgeInsets.all(10),
                  //       opacity: .2,
                  //       currentIndex: widget.selectedIndex,
                  //       onTap: onTapped as void Function(int?)?,
                  //       borderRadius:
                  //           const BorderRadius.vertical(top: Radius.circular(16)),
                  //       elevation: 1,
                  //       // fabLocation: BubbleBottomBarFabLocation.end, //new
                  //       hasNotch: true, //new
                  //       hasInk: true, //new, gives a cute ink effect
                  //       inkColor: Colors
                  //           .black12, //optional, uses theme color if not specified
                  //       items: [
                  //         BubbleBottomBarItem(
                  //             backgroundColor: navyColor,
                  //             icon: Icon(
                  //               Icons.newspaper,
                  //               color: navyColor,
                  //             ),
                  //             activeIcon: Icon(
                  //               Icons.newspaper,
                  //               // Icons.newspaper_rounded,
                  //               color: navyColor,
                  //             ),
                  //             title: Text("Feed")),
                  //         BubbleBottomBarItem(
                  //             backgroundColor: navyColor,
                  //             icon: Icon(
                  //               Icons.bookmark,
                  //               color: navyColor,
                  //             ),
                  //             activeIcon: Icon(
                  //               Icons.bookmark,
                  //               color: navyColor,
                  //             ),
                  //             title: Text("Saved")),
                  //         BubbleBottomBarItem(
                  //             backgroundColor: navyColor,
                  //             icon: Icon(
                  //               Icons.person,
                  //               color: navyColor,
                  //             ),
                  //             activeIcon: Icon(
                  //               Icons.person,
                  //               color: navyColor,
                  //             ),
                  //             title: Text("Profile")),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  child: BottomNavigationBar(
                    // showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white70,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.newspaper,
                        ),
                        label: "Feed",
                      ),
                      // BottomNavigationBarItem(
                      //     icon: Icon(Icons.search), label: "Search"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.bookmark), label: "Saved"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: "Profile"),
                    ],
                    currentIndex: widget.selectedIndex,
                    onTap: onTapped,
                  ),
                ));
          } else {
            return LoadingSplash();
          }
        });
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchPage(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}

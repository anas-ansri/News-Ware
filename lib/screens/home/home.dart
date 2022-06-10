import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:news_ware/screens/home/feed.dart';
import 'package:news_ware/screens/home/profile.dart';
import 'package:news_ware/screens/home/saved.dart';
import 'package:news_ware/screens/home/notifs.dart';
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

    return Scaffold(

        //Side Bar Menu
        drawer: NavigationDrawerWidget(
          name: user.displayName ?? "New User ",
          email: user.email!,
          urlImage: user.photoURL ??
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
        ),

        //App Bar
        appBar: AppBar(
          title: Text(
            "News Ware",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegate());
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
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [Feed(), Saved(), Profile()],
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

          child: BottomNavigationBar(
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

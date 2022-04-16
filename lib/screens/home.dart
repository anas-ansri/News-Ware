import "package:flutter/material.dart";
import 'package:news_ware/screens/home/feed.dart';
import 'package:news_ware/screens/home/profile.dart';
import 'package:news_ware/screens/home/saved.dart';
import 'package:news_ware/screens/home/notifs.dart';
import 'package:news_ware/widgets/navigation_drawer_widget.dart';
import 'package:news_ware/widgets/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color backgroundColor = const Color(0xFF0D6EFD);
  PageController pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    pageController = PageController(
      initialPage: _selectedIndex,
    );
    super.initState();
  }

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 10), curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Side Bar Menu
        drawer: const NavigationDrawerWidget(),

        //App Bar
        appBar: AppBar(
          title: const Text("News Ware"),
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                },
                icon: const Icon(Icons.search))
          ],
        ),

        //Body
        body: PageView(
          controller: pageController,
          children: const [Feed(), Saved(), Notifications(), Profile()],
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
                  Icons.home,
                ),
                label: "Feed",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark), label: "Saved"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: "Notification"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
            currentIndex: _selectedIndex,
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

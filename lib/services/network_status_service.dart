import 'package:flutter/material.dart';
// import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:news_ware/screens/menu/myactivity.dart';

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      debounceDuration: Duration.zero,
      connectivityBuilder: (context, connectivity, child) {
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'Please check your internet connection',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }
        return child;
      },
      child: const MyActivity(),
    );
  }
}

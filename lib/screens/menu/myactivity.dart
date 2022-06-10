import 'package:flutter/material.dart';
import 'package:news_ware/widgets/loading.dart';
// import 'package:news_ware/helper/loading.dart';

class MyActivity extends StatelessWidget {
  const MyActivity({Key? key}) : super(key: key);
  final Color backgroundColor = const Color(0xFF0D6EFD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Activity"),
          centerTitle: true,
          backgroundColor: backgroundColor,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {},
          // ),
        ),
        body: ListView(
          children: [Loading()],
        )
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: const [
        //       Text("This page is under-construction",
        //           textAlign: TextAlign.center,
        //           style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey)),
        //       SizedBox(height: 30,),
        //       Icon(Icons.construction,size: 50,color: Colors.grey,)
        //     ],
        //   ),
        // ),
        );
  }
}

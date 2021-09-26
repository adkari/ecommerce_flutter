import 'package:flutter/material.dart';
import 'package:practice/screens/landingpage.dart';
import 'package:practice/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EShop',
      theme: ThemeData(
        fontFamily: 'more',
        primarySwatch: Colors.deepOrange,
      ),
      home: LandingPage(),
    );
  }
}

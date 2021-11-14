import 'package:fast_farmers/constants.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: 'Nunito',
      ),
      home: HomeScreen(),
    );
  }
}

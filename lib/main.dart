import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 3,
          foregroundColor: Colors.white,),
        accentColor: Colors.blue,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 22.0,
            color: Colors.blue,),
          headline2: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Colors.blueAccent[700],
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
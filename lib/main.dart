import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/views/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Compare 2way',
      theme: const CupertinoThemeData(
          primaryColor: Color(0xFF363A44),
          primaryContrastingColor: Color(0xFFFF7043),
      ),
//      theme: ThemeData(
////        primarySwatch: customSwatch,

//        accentColor: const Color(0xFFFF7043),
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
      home: HomeScreen(),
    );
  }
}

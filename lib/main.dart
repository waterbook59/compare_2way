import 'dart:ui';

import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/views/home/home_screen.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Compare 2way',
      theme: const CupertinoThemeData(
        primaryColor: Color(0xFF363A44),
        primaryContrastingColor: Color(0xFFFF7043),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        //todo barBackgroundColorの場所確認
        barBackgroundColor:  Color(0xFF363A44),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily:'Hiragino Kaku Gothic ProN',
//          regularFontJa,
//              fontSize: 20
          ),
        ),


      ),
      home: HomeScreen(),
    );
  }
}

import 'package:compare_2way/di/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

void main() {
  runApp(
      ///MultiProvider変更前
//      ChangeNotifierProvider<AddViewModel>(
//        create: (context) => AddViewModel(),
//        child: MyApp(),
//  ));

  ///MultiProvider変更後
      MultiProvider(
        providers: globalProviders,
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Compare 2way' ,
      theme: ThemeData(
        primaryColor: const Color(0xFF363A44),
        accentColor: const Color(0xFFFF7043),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        // フォントとしてヒラギノ使う
        fontFamily: 'Hiragino Kaku Gothic ProN',
        ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: HomeScreen(),
    );
      CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Compare 2way',
      theme: const CupertinoThemeData(
        primaryColor: Color(0xFF363A44),
        primaryContrastingColor: Color(0xFFFF7043),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        barBackgroundColor: Color(0xFF363A44),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'Hiragino Kaku Gothic ProN',
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

import 'package:compare_2way/views/list/list_page.dart';
import 'package:compare_2way/views/setting/setting_page.dart';
import 'package:compare_2way/views/tag/tag_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pages = [
    ListPage(),
    TagPage(),
    SettingPage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

//    final accentColor = CupertinoTheme
//        .of(context)
//        .primaryContrastingColor;
    final accentColor = Theme.of(context).accentColor;

    return
      SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            currentIndex: _currentIndex,
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            activeColor: accentColor,
            items: const [
                 BottomNavigationBarItem(
                   icon:Icon(CupertinoIcons.news),
                   title:Text('リスト'),
                 ),
                 BottomNavigationBarItem(
                   icon: Icon(CupertinoIcons.tag),
                   title: Text('タグ'),
                 ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  title: Text('設定'),
                ),
              ],
             ),
          tabBuilder: (context, _currentIndex) {
            return CupertinoTabView(
              builder: (context){
               return _pages[_currentIndex];
              },
            );
          }
      ),
      );
  }
}

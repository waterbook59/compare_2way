import 'package:compare_2way/views/list/list_page.dart';
import 'package:compare_2way/views/setting/setting_page.dart';
import 'package:compare_2way/views/tag/tag_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pages = [
    const ListPage(),
    const TagPage(),
    const SettingPage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

//    final accentColor = CupertinoTheme
//        .of(context)
//        .primaryContrastingColor;
    final accentColor = Theme.of(context).colorScheme.secondary;

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
                   label:'リスト',
                 ),
                 BottomNavigationBarItem(
                   icon: Icon(CupertinoIcons.tag),
                   label: 'タグ',
                 ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: '設定',
                ),
              ],
             ),
          tabBuilder: (context, currentIndex) {
            return CupertinoTabView(
              builder: (context){
               return _pages[currentIndex];
              },
            );
          }
      ,),
      );
  }
}

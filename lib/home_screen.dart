import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/list_page/list_page.dart';
import 'package:compare_2way/views/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = CupertinoTheme
        .of(context)
        .primaryColor;
    final accentColor = CupertinoTheme
        .of(context)
        .primaryContrastingColor;

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: primaryColor,
          middle: const Text(
            'Compare List',
            style: middleTextStyle,
          ),
          trailing: const Text(
            '編集',
            style: trailingTextStyle,
          ),
        ),

        ///SafeAreaはCupertinoPageScaffoldの中で
        ///さらにFABをおくならScaffoldを配置
        child: SafeArea(
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              backgroundColor: Colors.white,
                activeColor: accentColor,
                items: const [
                   BottomNavigationBarItem(
                     icon:Icon(CupertinoIcons.news),
                     title:Text('リスト'),
                   ),
                   BottomNavigationBarItem(
                     icon: Icon(CupertinoIcons.folder),
                     title: Text('カテゴリ'),
                   ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings),
                    title: Text('設定'),
                  ),
                ],
               ),
            tabBuilder: (context, index) {
              return CupertinoTabView(
                builder: (context){
                  switch(index){
                    case 0:
                      return ListPage();
                      break;
                    case 1:
                      return Container(child: Text('ウッピャッぽー'),);
                      break;
                    case 2:
                    return SettingPage();
                  }
                  return Container();
                },
              );
            }
        ),
      ),
    );
  }
}

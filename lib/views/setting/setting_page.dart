import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/setting/license_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor= Theme.of(context).accentColor;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: const Text(
          '設定',
          style: middleTextStyle,
        ),
        trailing:  GestureDetector(
          child: const Icon(
            //CupertinoIcons.keyboard_chevron_compact_downない
            Icons.keyboard_hide,
            color: Colors.white,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body:
        Column(
          children: [
            const SizedBox(height: 16,),
            SettingsList(
              shrinkWrap: true,
              sections: [
                SettingsSection(
                  title: 'このアプリについて',
                  tiles: [
                    SettingsTile(
                      title: '要望・不具合に関する報告',
//                      subtitle: 'English',
                      leading: const Icon(CupertinoIcons.envelope),
                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {
//                    Navigator.of(context).push(MaterialPageRoute(
//                      builder: (_) => LanguagesScreen(),
//                    ));
                      },
                    ),
                    SettingsTile(
                      title: 'このアプリを評価する',
//                      subtitle: 'English',
                      leading: const Icon(CupertinoIcons.star_circle_fill),
                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {
//                    Navigator.of(context).push(MaterialPageRoute(
//                      builder: (_) => LanguagesScreen(),
//                    ));
                      },
                    ),
                    SettingsTile(
                      title: '利用規約',
//                      subtitle: 'English',
                      leading: const Icon(CupertinoIcons.text_justify),
                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {
//                    Navigator.of(context).push(MaterialPageRoute(
//                      builder: (_) => LanguagesScreen(),
//                    ));
                      },
                    ),
                    SettingsTile(
                      title: 'プライバシーポリシー',
//                      subtitle: 'English',
                      leading: const Icon(CupertinoIcons.doc_text),
                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {
//                    Navigator.of(context).push(MaterialPageRoute(
//                      builder: (_) => LanguagesScreen(),
//                    ));
                      },
                    ),
                    SettingsTile(
                      title: 'ライセンス',
//                      subtitle: 'English',
                      leading: Image.asset('assets/images/license.png',width: 26,color: Colors.black54,),
                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {

//                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
//                            builder: (context) => CompareScreen(
//                              comparisonOverview: updateOverview,
//                              screenEditMode: ScreenEditMode.fromListPage,
//                            )));




                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (_) => MyLicensePage(),
                    ));
                      },
                    ),
                    SettingsTile(
                      title: 'バージョン',
//                      subtitle: 'English',
                      leading: const Icon(Icons.language),
                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {
//                    Navigator.of(context).push(MaterialPageRoute(
//                      builder: (_) => LanguagesScreen(),
//                    ));
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),

//        GestureDetector(
//          onTap: () {
//            ///任意の場所をタップするだけでフォーカス外せる(キーボード閉じれる)
//            FocusScope.of(context).unfocus();
//            //setStateいらない
//          },
//          child: SingleChildScrollView(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//              const PageTitle(title: 'タグ',),
//              const SizedBox(height: 8,),
//              const Divider(color: Colors.grey,height: 0,),
//              ListView.builder(
//                  shrinkWrap: true,
//                  physics: const NeverScrollableScrollPhysics(),
//                  itemCount: 6,
//                  itemBuilder: (BuildContext context, int index){
//                    return ListTile(
//                      title: Text(settingList[index]),
////                      subtitle:Text('アイテム数:${testTagChart[index].tagAmount}'),
////                      onTap: (){
////                        print('ListTileのリスト onTap!');
////                        setState(() {
////                          _selectedIndex = index;
////                          myFocusNodes[index].requestFocus();
////                          isDisplayIcon = true;
////                          isReturnText = true;
////                          is2ndReturnText =false;
////                        }
//                        );},
//                    ),
//
////                  }),
//
//            ],),
//          ),
//        )
      ),
    );
  }


}

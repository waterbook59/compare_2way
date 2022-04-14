import 'package:app_review/app_review.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/setting/license_page.dart';
import 'package:compare_2way/views/setting/privacy_policy_screen.dart';
import 'package:compare_2way/views/setting/user_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:page_transition/page_transition.dart';
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
//        trailing:  GestureDetector(
//          child: const Icon(
//            //CupertinoIcons.keyboard_chevron_compact_downない
//            Icons.keyboard_hide,
//            color: Colors.white,
//          ),
//        ),
      ),
      child: Scaffold(
//        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16,),
            ///Androidはこちらがいい
//            const Padding(
//              padding: EdgeInsets.symmetric(horizontal: 8),
//              child: Text('このアプリについて', textAlign: TextAlign.left,
//                style: subTitleTextStyle,),
//            ),
            SettingsList(
              shrinkWrap: true,
              sections: [
                SettingsSection(
                  title: 'このアプリについて',///iOSはこちらがいい
                  titleTextStyle: subTitleTextStyle,
                  tiles: [
                    SettingsTile(
                      title: '要望・不具合に関する報告',
//                      subtitle: 'English',
                      leading: const Icon(CupertinoIcons.envelope),
                      onPressed: (context) {
                        flutterEmailSenderMail();
                      },
                    ),
                    SettingsTile(
                      title: 'このアプリを評価する',
//                      subtitle: 'English',
                      leading: const Icon(CupertinoIcons.star_circle_fill),
//                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context)=>_requestReview(),
                    ),
                    SettingsTile(
                      title: '利用規約',
//                      subtitle: 'English',
                      leading: const Icon(CupertinoIcons.text_justify),
//                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (_) => UserPolicyScreen(),
                        ));
                      },
                    ),
                    SettingsTile(
                      title: 'プライバシーポリシー',
//                      subtitle: 'English',
                      leading: const Icon(CupertinoIcons.doc_text),
//                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (_) => PrivacyPolicyScreen(),
                        ));
                      },
                    ),
                    SettingsTile(
                      title: 'ライセンス',
//                      subtitle: 'English',
                      leading: Image.asset('assets/images/license.png',width: 26,color: Colors.black54,),
//                      trailing:const Icon(Icons.arrow_forward_ios),
                      onPressed: (context) {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (_) => MyLicensePage(),
                    ));
                      },
                    ),
                    SettingsTile(
                      title: 'バージョン',
//                      subtitle: 'English',
                      leading: const Icon(Icons.language),
//                      trailing:const Icon(Icons.arrow_forward_ios),
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

      ),
    );
  }

  void _requestReview() {
    AppReview.requestReview.then(print);
  }

//flutter_email_senderを使ってメールを送信
  Future<void> flutterEmailSenderMail() async {
    final Email email = Email(
      body: '${Template().text}',
      subject: '転ばぬ先の2way：サポート',
      recipients: ['waterbook.tokyo@gmail.com'],
    );

    await FlutterEmailSender.send(email);
  }

}

//本文のテンプレート的な
class Template {
  String text =
      'ご意見・ご要望をこちらにご記入ください';
}
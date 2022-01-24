import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserPolicyScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return SafeArea(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: primaryColor,
            middle: const Text(
              '利用規約',
              style: middleTextStyle,
            ),
          ),
          child: const Scaffold(
            body:  WebView(
              initialUrl: 'https://waterboook.com/privacy-policy',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ));
  }
}

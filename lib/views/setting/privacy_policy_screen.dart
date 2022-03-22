import 'dart:io';

import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool connectionStatus;
  int position = 1;
  final key = UniqueKey();

  void doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  void startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  /// インターネット接続チェック
  Future check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectionStatus = true;
      }
    } on SocketException catch (_) {
      connectionStatus = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return FutureBuilder<dynamic>(
        future: check(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: primaryColor,
                actionsForegroundColor: Colors.white,
                middle: const Text(
                  'プライバシーポリシー',
                  style: middleTextStyle,
                ),
              ),
              child: Scaffold(
                body: connectionStatus == true
                    ? IndexedStack(
                  index: position,
                  children: [
                    WebView(
                      initialUrl: 'https://waterboook.com/privacy-policy',
                      javascriptMode: JavascriptMode.unrestricted,
                      key: key,
                      /// indexを０にしてWebViewを表示
                      onPageFinished: doneLoading,
                      /// indexを1にしてプログレスインジケーターを表示
                      onPageStarted: startLoading,
                    ),
                    // プログレスインジケーターを表示
                    Container(
                      child: const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.blue),
                      ),
                    ),
                  ],
                )

                /// インターネットに接続されていない場合の処理
                    : SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding:const EdgeInsets.only(
                            top: 120,
                            bottom: 20,
                          ),
                          child: Container(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Text(
                            'インターネットに接続されていません',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        }
    );
  }
}



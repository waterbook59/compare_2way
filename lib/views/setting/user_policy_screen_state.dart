import 'dart:io';

import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserPolicy extends StatefulWidget {
  @override
  _UserPolicyState createState() => _UserPolicyState();
}

class _UserPolicyState extends State<UserPolicy> {

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
              '利用規約',
              style: middleTextStyle,
            ),
          ),
          child: Scaffold(
            body: connectionStatus == true
                ? IndexedStack(
              index: position,
              children: [
                WebView(
                  initialUrl: 'https://waterboook.com/terms_of_service',
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

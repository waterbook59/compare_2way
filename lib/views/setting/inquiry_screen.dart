import 'dart:async';
import 'dart:io';

import 'package:compare_2way/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InquiryScreen extends StatefulWidget {

  @override
  _InquiryScreenState createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State {
  final Completer _controller = Completer<dynamic>();
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
        print('Furure check/connectionStatus:$connectionStatus');
      }
    } on SocketException catch (_) {
      connectionStatus = false;
      print('Furure check/connectionStatus:$connectionStatus');
    }
  }

  @override
  void initState() {
    super.initState();
    // 濁点入らない、英字入力で日本語へ戻ってしまう、予測変換されない場合
    ///Androidの時のみ追加
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return  FutureBuilder<dynamic>(
        future: check(), // Future or nullを取得
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: primaryColor,
              middle: const Text(
                '設定',
                style: middleTextStyle,
              ),
            ),
            child: Scaffold(
              body: connectionStatus == true
               ? IndexedStack(
              index: position,
              children: [
                      WebView(
                        initialUrl: 'https://waterbook.sakura.ne.jp/inquiry.html',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _controller.complete(webViewController);
                        },
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
        });
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('connectionStatus', connectionStatus));
  }

}
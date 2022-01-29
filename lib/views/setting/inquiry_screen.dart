import 'dart:async';
import 'dart:io';

import 'package:compare_2way/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

//todo 濁点入らない、英字入力で日本語へ戻ってしまう、予測変換されない
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
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

//    return  CupertinoPageScaffold(
//        navigationBar: CupertinoNavigationBar(
//          backgroundColor: primaryColor,
//          middle: const Text(
//            '設定',
//            style: middleTextStyle,
//          ),
//          trailing:  GestureDetector(
//            child: const Icon(
//              //CupertinoIcons.keyboard_chevron_compact_downない
//              Icons.keyboard_hide,
//              color: Colors.white,
//            ),
//            onTap:()=> _unFocusTap(context),
//          ),
//        ),
//        child: Scaffold(//todo Consumer必要?
//          body: connectionStatus == true
//
//              ?
//          SingleChildScrollView(
//            child: FutureBuilder<dynamic>(
//              future: check(), // Future or nullを取得
//                builder: (BuildContext context, AsyncSnapshot snapshot) {
//                  return
//                  IndexedStack(
//                    index: position,
//                    children: [
//                      WebView(
//                        initialUrl: 'https://waterbook.sakura.ne.jp/inquiry.html',
//                        javascriptMode: JavascriptMode.unrestricted, // JavaScriptを有効化
//                        onWebViewCreated:
//                            (WebViewController webViewController) {
//                          _controller.complete(webViewController);
//                        },
//                        key: key,
//                        onPageFinished: doneLoading,
//                        // indexを０にしてWebViewを表示
//                        onPageStarted: startLoading, // indexを1にしてプログレスインジケーターを表示
//                      ),
//                      // プログレスインジケーターを表示
//                      Container(
//                        child: Center(
//                          child: CircularProgressIndicator(
//                              backgroundColor: Colors.blue),
//                        ),
//                      ),
//                    ],
//                  );
//                }),
//          )
//
//          /// インターネットに接続されていない場合の処理
//              : SafeArea(
//            child: Center(
//              child: Column(
//                children: [
//                  Padding(
//                    padding: EdgeInsets.only(
//                      top: 120,
//                      bottom: 20,
//                    ),
//                    child: Container(),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(
//                      bottom: 20,
//                    ),
//                    child: Text(
//                      'インターネットに接続されていません',
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ));


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
              trailing:  GestureDetector(
                child: const Icon(
                  //CupertinoIcons.keyboard_chevron_compact_downない
                  Icons.keyboard_hide,
                  color: Colors.white,
                ),
                onTap:()=> _unFocusTap(context),
              ),
            ),
            child: Scaffold(
//            appBar: AppBar(
//              title: Text('不具合を報告'),
//              leading:         GestureDetector(
//            child: const Icon(
//            //CupertinoIcons.keyboard_chevron_compact_downない
//            Icons.keyboard_hide,
//              color: Colors.white,
//            ),
//          ),


            body: connectionStatus == true
            //todo LayoutBuilder&SingleChildScrollView追加もエラー：RenderAndroidView object was given an infinite size during layout.
               ?
               IndexedStack(
              index: position,
              children: [
                      WebView(
                        initialUrl: 'https://waterbook.sakura.ne.jp/inquiry.html',
                        javascriptMode: JavascriptMode.unrestricted, // JavaScriptを有効化
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _controller.complete(webViewController);
                        },
                        key: key,
                        onPageFinished: doneLoading, /// indexを０にしてWebViewを表示
                        onPageStarted: startLoading, /// indexを1にしてプログレスインジケーターを表示
                      ),
                      // プログレスインジケーターを表示
                      Container(
                        child: Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.blue),
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
                      padding: EdgeInsets.only(
                        top: 120,
                        bottom: 20,
                      ),
                      child: Container(),
                    ),
                    Padding(
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


  void _unFocusTap(BuildContext context) {
    //setStateしてない
    print('unFocus!');
    FocusScope.of(context).unfocus();
  }

}
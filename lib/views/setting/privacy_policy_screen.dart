import 'dart:io';

import 'package:compare_2way/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool connectionStatus=false;
  int position = 1;
  final key = UniqueKey();
  ///web_view_flutter ver4.0以降は中級編1の動画参考
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController=WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
        onNavigationRequest:(request,){
          if (request.url.startsWith('https://www.youtube.com/')) {
            // debugPrint('blocking navigation to ${request.url}');
            return NavigationDecision.prevent;
          }
          debugPrint('allowing navigation to ${request.url}');
          return NavigationDecision.navigate;
        } ,),)
      ..loadRequest(Uri.parse('https://waterboook.com/privacy-policy'));
  }

  //todo disposeでcontroller破棄?

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
  Future<void> check() async {
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
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: primaryColor,
                // actionsForegroundColor: Colors.white,
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
                    //todo ロード中プログレスインジケーターを表示
                    WebViewWidget(controller: _webViewController),
                    // WebView(
                    //   initialUrl: 'https://waterboook.com/privacy-policy',
                    //   javascriptMode: JavascriptMode.unrestricted,
                    //   key: key,
                    //   /// indexを０にしてWebViewを表示
                    //   onPageFinished: doneLoading,
                    //   /// indexを1にしてプログレスインジケーターを表示
                    //   onPageStarted: startLoading,
                    // ),
                    Container(
                      child: const Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.blue,),
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
              ),);
        }
    ,);
  }
}

import 'dart:io';

import 'package:compare_2way/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserPolicyScreen extends StatefulWidget {
  const UserPolicyScreen({Key? key}) : super(key: key);

  @override
  State<UserPolicyScreen> createState() => _UserPolicyScreenState();
}

class _UserPolicyScreenState extends State<UserPolicyScreen> {
  late WebViewController _webViewController;
  bool connectionStatus = true; //インターネット接続の有無
  bool isLoading = true; // ローディングの有無
  double downloadPercentage = 0; // 進捗バー用

  // インターネット接続チェック
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

  // ローディングの切り替え
  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  // 進捗計算
  void calculateProgress(int progress) {
    setState(() {
      downloadPercentage = progress / 100;
    });
  }

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (
            request,
          ) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              // debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onProgress: calculateProgress,
          onPageFinished: (_) {
            if (isLoading) {
              toggleLoading();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://waterboook.com/terms_of_service'));
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).colorScheme.secondary;

    return FutureBuilder<dynamic>(
      future: check(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: primaryColor,
            // actionsForegroundColor: Colors.white,
            middle: const Text(
              '利用規約',
              style: middleTextStyle,
            ),
          ),
          child: Scaffold(
            body: connectionStatus
                ? SafeArea(
                    child: Column(
                      children: [
                        // 進捗バー
                        isLoading
                            ? LinearProgressIndicator(
                                color: accentColor,
                                backgroundColor: Colors.grey,
                                value: downloadPercentage,
                                minHeight: 7,
                              )
                            : const SizedBox.shrink(),
                        Expanded(
                          child: Scrollbar(
                            child: WebViewWidget(
                              controller: _webViewController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )

                /// インターネットに接続されていない場合の処理 //todo 文字中央に
                : SafeArea(
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
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
          ),
        );
      },
    );
  }
}

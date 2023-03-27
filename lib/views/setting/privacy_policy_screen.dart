import 'package:compare_2way/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<PrivacyPolicyScreen> {
  late WebViewController _webViewController;
  bool isLoading = true; // ローディングの有無
  double downloadPercentage = 0; // 進捗バー用

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
      ..loadRequest(Uri.parse('https://waterboook.com/privacy-policy'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).colorScheme.secondary;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: const Text(
          'プライバシーポリシー',
          style: middleTextStyle,
        ),
      ),
      child: Scaffold(
        body: Column(
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
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:compare_2way/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart' ;
import 'package:flutter_email_sender/flutter_email_sender.dart';


class InquiryTest extends StatefulWidget {
  @override
  _InquiryTestState createState() => _InquiryTestState();
}

//class _InquiryTestState extends State<InquiryTest> {
//
//  final Completer _controller = Completer<dynamic>();
//  bool connectionStatus;
//  int position = 1;
//  final key = UniqueKey();
//
//  void doneLoading(String A) {
//    setState(() {
//      position = 0;
//    });
//  }
//
//  void startLoading(String A) {
//    setState(() {
//      position = 1;
//    });
//  }
//
//  Future check() async {
//    try {
//      final result = await InternetAddress.lookup('google.com');
//      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        connectionStatus = true;
//        print('Furure check/connectionStatus:$connectionStatus');
//      }
//    } on SocketException catch (_) {
//      connectionStatus = false;
//      print('Furure check/connectionStatus:$connectionStatus');
//    }
//  }
//
//
//  @override
//  void initState() {
//    super.initState();
//    if (Platform.isAndroid) {
//      WebView.platform = SurfaceAndroidWebView();
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//
//
//
//    return GestureDetector(
//      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//      child: Scaffold(
//        resizeToAvoidBottomInset: false,
//        appBar: AppBar(
//          title: Text('Flutter Demo Home Page'),
////          leading:
////          GestureDetector(
//////                behavior: HitTestBehavior.opaque,
////            child: const Icon(
////              //CupertinoIcons.keyboard_chevron_compact_downない
////              Icons.keyboard_hide,
////              color: Colors.white,
////            ),
////            onTap:
////                (){setState(() {
////                  print('appBar_unFocus!');
////                  final FocusScopeNode currentScope = FocusScope.of(context);
////                  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
////                    FocusManager.instance.primaryFocus.unfocus();
////                  }
////                });
////            },
////          ),
//        ),
//        body: GestureDetector(
//          onTap: (){
//            print('unfocus');
//            final FocusScopeNode currentScope = FocusScope.of(context);
//            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
//              FocusManager.instance.primaryFocus.unfocus();
//            }
//          },
//          child: WebView(
//            initialUrl: 'https://docs.google.com/forms/d/e/1FAIpQLSdm9NkEdPBrzejb8J-DC9jkmN1NOI_Pb3YtNv6S3RpNbDdIfQ/viewform?usp=sf_link',
//            javascriptMode: JavascriptMode.unrestricted,
//            onWebViewCreated:
//                (WebViewController webViewController) {
//              _controller.complete(webViewController);
//            },
//            key: key,
//            /// indexを０にしてWebViewを表示
//            onPageFinished: doneLoading,
//            /// indexを1にしてプログレスインジケーターを表示
//            onPageStarted: startLoading,
//          ),
//        ),
//      ),
//    );
//  }
//
//}



class _InquiryTestState extends State<InquiryTest> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メールパッケージ'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'メールアドレスを入力してください'),
            ),
            RaisedButton(
              child: Text('url_launcherで送る'),
              onPressed: () {
                urlLauncherMail();
              },
            ),
            RaisedButton(
              child: Text('flutter_email_senderで送る'),
              onPressed: () {
                flutterEmailSenderMail();
              },
            )
          ],
        ),
      ),
    );
  }

//url_launcherを使ってメールを送信
//  Future<bool> urlLauncherMail() {
//    final Uri _emailLaunchUri = Uri(
//      scheme: 'mailto',
//      path: '${emailController.text}',
//      queryParameters: {
//        'subject': 'url_launcherを使ってメールを送ります！',
//        'body': '${Template().text}'
//      },
//    );
//
//    return launch(
//      _emailLaunchUri.toString(),
//    );
//  }

  void urlLauncherMail() async {
    final title = Uri.encodeComponent('転ばぬ先の2way：サポート');
    final body = Uri.encodeComponent('ご意見・ご要望をこちらにご記入ください');
    const mailAddress = 'waterbook.tokyo@gmail.com';//メールアドレス

    return launchMail(
      'mailto:$mailAddress?subject=$title&body=$body',
    );
  }

  Future<void> launchMail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final Error error = ArgumentError('Error launching $url');
      throw error;
    }
  }



//flutter_email_senderを使ってメールを送信
  Future<void> flutterEmailSenderMail() async {
    final Email email = Email(
      body: '${Template().text}',
      subject: '転ばぬ先の2way：サポート',
      recipients: ['waterbook.tokyo@gmail.com'],
//      attachmentPaths: ['images/sample1.png'],
    );

    await FlutterEmailSender.send(email);
  }
}

//本文のテンプレート的な
class Template {
  String text =
      'ご意見・ご要望をこちらにご記入ください';
}

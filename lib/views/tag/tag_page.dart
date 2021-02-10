import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = CupertinoTheme.of(context).primaryColor;

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: primaryColor,
          middle: const Text(
            'タグ',
            style: middleTextStyle,
          ),
          trailing: const Text(
            '編集',
            style: trailingTextStyle,
          ),
        ),
        child: Scaffold(
            backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
            body: Container(
              child: const Center(child: Text('タグページ')),
            ),
        ),
    );
  }
}

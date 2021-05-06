import 'package:compare_2way/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///List<Tag>で一覧のデータ取得しつつ、tagTitleで重複するものを削除するのにtoSet()を使う
///削除したlistをタグ一覧として表示する（tagChips参照）

class TagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;


    return CupertinoPageScaffold(
        navigationBar:  CupertinoNavigationBar(
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
          floatingActionButton: SizedBox(
            width: 56,
            height: 56,
            child: FloatingActionButton(
              backgroundColor: accentColor,
              child: const Icon(Icons.add, color: Colors.black, size: 40),
              onPressed: () => print('押したぜFAB'),
            ),
          ),
        ),
    );
  }
}

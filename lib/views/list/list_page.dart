import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/common/page_transition.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

//    final accentColor = CupertinoTheme
//        .of(context)
//        .primaryContrastingColor;

    final accentColor = Theme.of(context).accentColor;

    return CupertinoPageScaffold(
      //todo trailing修正時はconst削除
      navigationBar: const CupertinoNavigationBar(
        middle: const Text(
          'Compare List',
          style: middleTextStyle,
        ),
        trailing: const Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme
            .of(context)
            .scaffoldBackgroundColor,
        body: const Center(child: Text('リスト表示')),
        floatingActionButton: SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
              backgroundColor: accentColor,
              child: const Icon(Icons.add, color: Colors.black, size: 40),

            onPressed: () => _saveComparisonItems(context),

          ),
        ),
      ),
    );
  }

  // DB登録とComparePageへ移動
  void _saveComparisonItems(BuildContext context) {

///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
        Navigator.of(context,rootNavigator: true).push(MaterialPageRoute<void>(
      builder: (context) => AddScreen(),
    ));
  }


}

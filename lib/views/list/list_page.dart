import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/common/show_modal_dialog.dart';
import 'package:compare_2way/views/list/components/add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;

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
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: Container(
          child: const Center(child: Text('リスト表示')),
        ),
        floatingActionButton: SizedBox(
          width: 56,
          height: 56,
          child: FloatingActionButton(
            backgroundColor: accentColor,
            child: const Icon(Icons.add, color: Colors.black, size: 40),
            onPressed: () => showModalDialog(
                context: context,
                dialogWidget: AddDialog(
                  //todo DB登録とComparePageへ移動
                  onSave: ()=>_saveComparisonItems(context),
                ),
                isScrollable: true),
          ),
        ),
      ),
    );
  }

  //todo DB登録とComparePageへ移動
  void _saveComparisonItems(BuildContext context) {
    print('DB登録とComparePageへ移動');
  }
}

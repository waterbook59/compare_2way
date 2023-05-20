import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ListPageEditButton extends StatelessWidget {
  const ListPageEditButton({Key? key}) : super(key: key);

  ///選択削除のとき確認ダイアログ出す(選択ゼロのときは出さない)
  ///Selector=>Consumer editStatusとdeleteItemIdListで分岐
  @override
  Widget build(BuildContext context) {
    return Consumer<CompareViewModel>(
      builder: (context, viewModel, child) {
        return (viewModel.editStatus == ListEditMode.display)
            ? CupertinoButton(
                onPressed: () => _changeEdit(context),

                /// 編集ボタンの下切れるのを防ぐ
                padding: const EdgeInsets.all(8),
                child: const Text(
                  '編集',
                  style: trailingTextStyle,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ///deleteItemListにidがあれば削除
                  if (viewModel.deleteItemIdList.isNotEmpty)
                    CupertinoButton(
                      onPressed: () => _deleteItem(context), //押したら選択行削除
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        '削除',
                        style: TextStyle(
                          fontFamily: regularFontJa,
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                    )
                  else
                    CupertinoButton(
                      onPressed: () {}, //選択されないと押せない
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        '削除',
                        style: TextStyle(
                          fontFamily: regularFontJa,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 4,
                  ),
                  if (viewModel.deleteItemIdList.isNotEmpty)
                    CupertinoButton(
                      onPressed: () {}, //選択中は押せない
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        '完了',
                        style: TextStyle(
                          fontFamily: regularFontJa,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    CupertinoButton(
                      onPressed: () => _changeEdit(context),
                      //押したら通常モードへ変更
                      padding: const EdgeInsets.all(8),
                      child: const Text('完了', style: trailingTextStyle),
                    ),
                ],
              );
      },
    );
  }

  Future<void> _changeEdit(
    BuildContext context,
  ) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.changeEditStatus();
  }

  //ListPage選択行削除
  Future<Future<Widget?>> _deleteItem(BuildContext context) async {
    ///選択削除のとき確認ダイアログ出す(選択ゼロのときは出さない)
    return showDialog<Widget>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('選択したアイテム'),
          content: const Text('を削除してもいいですか？'),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Provider.of<CompareViewModel>(context, listen: false)
                    .deleteItemList();
                Fluttertoast.showToast(
                  msg: '削除完了',
                );
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            CupertinoDialogAction(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}

import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ListPageEditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<CompareViewModel, ListEditMode>(
        selector: (context, viewModel) => viewModel.editStatus,
        builder: (context, editStatus, child) {
          return (editStatus == ListEditMode.display)
              ? CupertinoButton(
                  child: const Text(
                    '編集',
                    style: trailingTextStyle,
                  ),
                  onPressed: () => _changeEdit(context, editStatus),

                  /// 編集ボタンの下切れるのを防ぐ
                  padding: const EdgeInsets.all(8),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton(
                      child: const Text(
                        '削除',
                        style: TextStyle(
                            fontFamily: regularFontJa,
                            fontSize: 16,
                            color: Colors.redAccent),
                      ),
                      onPressed: () => _deleteItem(context), //押したら選択行削除
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CupertinoButton(
                      child: const Text('完了', style: trailingTextStyle),
                      onPressed: () => _changeEdit(context, editStatus),
                      //押したら通常モードへ変更
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                );
        });
  }

  Future<void> _changeEdit(
      BuildContext context, ListEditMode editStatus) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.changeEditStatus(editStatus);
  }

  //ListPage選択行削除
  Future<void> _deleteItem(BuildContext context) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.deleteItemList();
  }
}

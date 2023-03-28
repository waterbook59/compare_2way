import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/common/nav_bar_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

///CupertinoNavigationBar内ではCupertinoActionSheetAction

class TagEditButtonAction extends StatelessWidget {
  const TagEditButtonAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompareViewModel>(
      // selector: (context, viewModel) => viewModel.tagEditMode,
      builder: (context, viewModel, child) {
        switch (viewModel.tagEditMode) {
          case TagEditMode.normal:
            //CupertinoButtonに変更すると黄色二十線出ない
            return CupertinoButton(
              onPressed: () {
                showCupertinoModalPopup<CupertinoActionSheet>(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text(
                            'タグ名編集',
                            style: actionSheetTextStyle,
                          ),
                          onPressed: () => _onPopupMenuSelected(
                            context: context,
                            selectedMenu: TagEditMode.tagTitleEdit,
                          ),
                        ),
                        CupertinoActionSheetAction(
                          child: const Text(
                            '並び替えと削除',
                            style: actionSheetCationTextStyle,
                          ),
                          onPressed: () {
                            _onPopupMenuSelected(
                              context: context,
                              selectedMenu: TagEditMode.tagDelete,
                            );
                          },
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('キャンセル'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                );
              }, //押したら長いActionSheet選択
              padding: const EdgeInsets.all(8),
              child: const Text(
                '編集',
                style: trailingTextStyle,
              ),
            );
          case TagEditMode.tagTitleEdit:
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NavBarButton(
                  navBarIcon: Icons.keyboard_hide,
                  onTap: () => _unFocusTap(context),
                ),
                const SizedBox(
                  width: 4,
                ),
                CupertinoButton(
                  onPressed: () => _changeEdit(context), //押したら通常モードへ変更
                  padding: const EdgeInsets.all(8),
                  child: const Text('完了', style: trailingTextStyle),
                ),
              ],
            );
          case TagEditMode.tagDelete:
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (viewModel.deleteItemIdList.isNotEmpty)
                  CupertinoButton(
                    onPressed: () => _deleteSelectTagList(context),
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
                    onPressed: () {},
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
                    onPressed: () {}, //押したら通常モードへ変更
                    //押したら通常モードへ変更
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
                    onPressed: () => _changeEdit(context), //押したら通常モードへ変更
                    //押したら通常モードへ変更
                    padding: const EdgeInsets.all(8),
                    child: const Text('完了', style: trailingTextStyle),
                  ),
              ],
            );
        }
        // return null;//null safety有効にするとエラー出ない
        ///https://zenn.dev/mono/articles/082dde5601ab4de858a1
      },
    );
  }

  void _onPopupMenuSelected({
    required BuildContext context,
    required TagEditMode selectedMenu,
  }) {
    switch (selectedMenu) {
      case TagEditMode.tagTitleEdit:
        Navigator.pop(context);
        final viewModel = Provider.of<CompareViewModel>(context, listen: false);
        viewModel.changeToTagTitleEdit();
        break;
      case TagEditMode.tagDelete:
        Navigator.pop(context);
        final viewModel = Provider.of<CompareViewModel>(context, listen: false);
        viewModel.changeToTagDelete();
        break;
      case TagEditMode.normal:
        // TODO: Handle this case.
        break;
    }
  }

  void _changeEdit(BuildContext context) {
    Provider.of<CompareViewModel>(context, listen: false).changeToNormal();
  }

  void _unFocusTap(BuildContext context) {
    Provider.of<CompareViewModel>(context, listen: false).unFocusTagPageList();
  }

  //TagPage選択行削除
  Future<void> _deleteSelectTagList(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('選択したタグ'),
          content: const Text('を削除してもいいですか？'),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Provider.of<CompareViewModel>(context, listen: false)
                    .deleteSelectTagList();
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

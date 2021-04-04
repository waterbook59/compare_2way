///CupertinoNavigationBar内ではCupertinoActionSheetAction
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditBottomAction extends StatelessWidget {

  const EditBottomAction({this.comparisonItemId});

  final String comparisonItemId;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Text(
        '編集',
        style: trailingTextStyle,
      ),
      onPressed: () {
        showCupertinoModalPopup<CupertinoActionSheet>(
            context: context,
            builder: (BuildContext context) {
              return CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    child: const Text(
                      'タイトル編集',
                      style: actionSheetTextStyle,
                    ),
                    onPressed: () =>
                        _onPopupMenuSelected(
                          context,
                          CompareEditMenu.titleEdit,
                        ),
                  ),
                  CupertinoActionSheetAction(
                    child: const Text(
                      '削除',
                      style: actionSheetCationTextStyle,
                    ),
                    onPressed: () =>
                        _onPopupMenuSelected(
                          context,
                          CompareEditMenu.allListDelete,
                        ),
                  ),

                ],
              );
            });
      },
    );
  }

  void _onPopupMenuSelected(BuildContext context,
      CompareEditMenu selectedMenu) {
    switch (selectedMenu) {
      case CompareEditMenu.titleEdit:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
          builder: (context) => const AddScreen(AddScreenMode.edit),
        ));
        break;
      case CompareEditMenu.allListDelete:
        print('comparisonItemIdを元に全削除$comparisonItemId');
        break;
    }
  }
}

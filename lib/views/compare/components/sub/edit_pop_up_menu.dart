///AppBarの中でないとPopupMenuButtonはNGなので、EditBottomActionを採用
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/material.dart';

class EditPopUpMenu extends StatelessWidget {

  const EditPopUpMenu({this.comparisonItemId});
  final String comparisonItemId;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CompareEditMenu>(
      child: const Text('編集', style: trailingTextStyle,),
      onSelected: (value) => _onPopupMenuSelected(context, value),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: CompareEditMenu.titleEdit,
            child: Text('タイトル編集', style: trailingTextStyle,),
          ),
          const PopupMenuItem(
            value: CompareEditMenu.allListDelete,
            child: Text('削除', style: trailingTextStyle,),
          ),
        ];
      },
    );
  }

  void _onPopupMenuSelected(BuildContext context,
      CompareEditMenu selectedMenu) {
    switch (selectedMenu) {
      case CompareEditMenu.titleEdit:
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
          builder: (context) =>
          const AddScreen(displayMode: AddScreenMode.edit),
        ));
        break;
      case CompareEditMenu.allListDelete:
        print('comparisonItemIdを元に全削除$comparisonItemId');
        break;
    }
  }
}

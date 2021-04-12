import 'package:compare_2way/data_models/comparison_overview.dart';
///CupertinoNavigationBar内ではCupertinoActionSheetAction
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBottomAction extends StatelessWidget {

  const EditBottomAction({
    this.comparisonOverview
  });

  final ComparisonOverview comparisonOverview;

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
                cancelButton: CupertinoActionSheetAction(
                  child:  const Text('キャンセル'),
                  onPressed: ()=>Navigator.pop(context),

                ),
              );
            });
      },
    );
  }

  void _onPopupMenuSelected(BuildContext context,
      CompareEditMenu selectedMenu,) {
    switch (selectedMenu) {
      case CompareEditMenu.titleEdit:
        final viewModel = Provider.of<CompareViewModel>(context, listen: false)
          ..itemTitle = comparisonOverview.itemTitle
          ..way1Title = comparisonOverview.way1Title
          ..way2Title = comparisonOverview.way2Title;


        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
          builder: (context) => AddScreen(displayMode: AddScreenMode.edit,
            itemTitle: comparisonOverview.itemTitle,
            way1Title: comparisonOverview.way1Title,
            way2Title: comparisonOverview.way2Title,
          ),

        ));
        break;
      case CompareEditMenu.allListDelete:
        print('comparisonItemIdを元に全削除${comparisonOverview.comparisonItemId}');
        break;
    }
  }
}

import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/home_screen.dart';
///CupertinoNavigationBar内ではCupertinoActionSheetAction
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:compare_2way/views/list/single_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                    onPressed: () {
                      _onPopupMenuSelected(
                          context,
                          CompareEditMenu.allListDelete,
                        );
                    },
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

        //画面移行する前にCupertinoActionSheetを閉じる(戻ると表示されたままになってしまう)
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
          builder: (context) => AddScreen(displayMode: AddScreenMode.edit,
            comparisonOverview: comparisonOverview,
          ),
        ));
        break;
      case CompareEditMenu.allListDelete:
        //todo 必要なら非同期に変更
        Navigator.pop(context);
        showDialog<Widget>(
            context: context,
        builder: (context){
              return CupertinoAlertDialog(
                title: Text('「${comparisonOverview.itemTitle}」の削除'),
                content:const Text('削除してもいいですか？'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('Delete'),
                    isDestructiveAction: true,
                    onPressed: (){
        final viewModel = Provider.of<CompareViewModel>(context, listen: false)
                        ..deleteList(comparisonOverview.comparisonItemId);
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: '削除完了',
                      );
                      // Navigator.popで画面おちる場合あり、pushReplacement変更
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                              builder: (context) => HomeScreen(
                              )));
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('キャンセル'),
                    onPressed: ()=>Navigator.pop(context),
                  ),
                ],
              );
        });
        break;
    }
  }



}

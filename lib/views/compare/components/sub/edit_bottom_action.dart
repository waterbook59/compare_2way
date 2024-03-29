import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/home_screen.dart';
///CupertinoNavigationBar内ではCupertinoActionSheetAction
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditBottomAction extends StatelessWidget {

  const EditBottomAction({Key? key,
    required this.comparisonOverview,
//    this.tagTitle,this.itemTitleEditMode,
  }) : super(key: key);

  final ComparisonOverview comparisonOverview;
//  final String tagTitle;
//  final ItemTitleEditMode itemTitleEditMode;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(8),
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
                          context:context,
                          selectedMenu:CompareEditMenu.titleEdit,
                        ),
                  ),
                  CupertinoActionSheetAction(
                    child: const Text(
                      '削除',
                      style: actionSheetCationTextStyle,
                    ),
                    onPressed: () {
                      _onPopupMenuSelected(
                          context:context,
                          selectedMenu:CompareEditMenu.allListDelete,
                        );
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child:  const Text('キャンセル'),
                  onPressed: ()=>Navigator.pop(context),

                ),
              );
            },);
      },
    );
  }


  void _onPopupMenuSelected({required BuildContext context,
      required CompareEditMenu selectedMenu,
//    String tagTitle,
//      ItemTitleEditMode itemTitleEditMode
  }) {
    switch (selectedMenu) {
      case CompareEditMenu.titleEdit:
//        print('edit_bottom_actionでタイトル編集押す/tagTitle&itemTitleEditMode:$tagTitle & $itemTitleEditMode');
        final viewModel = Provider.of<CompareViewModel>(context, listen: false);
//        inputPartの初期表示するものをset
        //インスタンスのcomparisonOverviewではなく、viewModel格納のitemTitleをAddScreen側で使用
        viewModel.setEditController();

        //画面移行する前にCupertinoActionSheetを閉じる(戻ると表示されたままになってしまう)
        Navigator.pop(context);
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
          builder: (context) => AddScreen(
            displayMode: AddScreenMode.edit,
            //comparisonItemIdしか使わない
            comparisonOverview:comparisonOverview,
          ),
        ),);
        break;
      case CompareEditMenu.allListDelete:
        /// //todo 必要なら非同期に変更
        Navigator.pop(context);
        showDialog<Widget>(
            context: context,
        builder: (context){
              return CupertinoAlertDialog(
                title: Text('「${comparisonOverview.itemTitle}」の削除'),
                content:const Text('削除してもいいですか？'),
                actions: [
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: (){
        // final viewModel =
        Provider.of<CompareViewModel>(context, listen: false)
                        .deleteItem(comparisonOverview.comparisonItemId);
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: '削除完了',
                      );
                      // Navigator.popで画面おちる場合あり、pushReplacement変更
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                              builder: (context) => const HomeScreen(
                              ),),);
                    },
                    child: const Text('削除'),
                  ),
                  CupertinoDialogAction(
                    child: const Text('キャンセル'),
                    onPressed: ()=>Navigator.pop(context),
                  ),
                ],
              );
        },);
        break;
    }
  }



}

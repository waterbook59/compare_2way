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

class TagEditBottomAction extends StatelessWidget {

  const TagEditBottomAction(
//  {
//    this.comparisonOverview,
//    this.tagTitle,this.itemTitleEditMode,
//  }
  );

//  final ComparisonOverview comparisonOverview;
//  final String tagTitle;
//  final ItemTitleEditMode itemTitleEditMode;

  @override
  Widget build(BuildContext context) {
    return
      Selector<CompareViewModel,TagEditMode>(
        selector: (context, viewModel) => viewModel.tagEditMode,
      builder:(context, tagEditMode, child){
            switch(tagEditMode){
              case TagEditMode.normal:
               return  CupertinoButton(
                  child: const Text('編集',
                      style: trailingTextStyle),
                  onPressed: (){
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
                                onPressed: () =>
                                    _onPopupMenuSelected(
                                      context:context,
                                      selectedMenu:TagEditMode.tagTitleEdit,
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
                                    selectedMenu:TagEditMode.tagDelete,
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
                  },//押したら長いActionSheet選択
                  padding: const EdgeInsets.all(8),);
                break;
              case TagEditMode.tagTitleEdit:
               return  CupertinoButton(
              child: const Text('完了', style: trailingTextStyle),
          onPressed: ()=> _changeEdit(context),//押したら通常モードへ変更
            padding: const EdgeInsets.all(8),);
                break;
              case TagEditMode.tagDelete:
                return CupertinoButton(
                  child: const Text('完了', style: trailingTextStyle),
                  onPressed: ()=>_changeEdit(context),//押したら通常モードへ変更
                  padding: const EdgeInsets.all(8),);
                break;
            }
          ///CupertinoButtonに変更すると黄色二十線出ない
//              ?  CupertinoButton(
//            child: const Text('編集',
//              style: trailingTextStyle),
//          onPressed: ()=>_changeEdit(context),//押したらActionSheet選択
//          padding: const EdgeInsets.all(8),)
//              : CupertinoButton(
//              child: const Text('完了', style: trailingTextStyle),
//          onPressed: ()=>_changeEdit(context),//押したら通常モードへ変更
//            padding: const EdgeInsets.all(8),);
        },
//         const Text('編集', style: trailingTextStyle,
        );





//      CupertinoButton(
//      padding: const EdgeInsets.all(8),
//      child: const Text(
//        '編集',
//        style: trailingTextStyle,
//      ),
//      onPressed: () {
//        showCupertinoModalPopup<CupertinoActionSheet>(
//            context: context,
//            builder: (BuildContext context) {
//              return CupertinoActionSheet(
//                actions: [
//                  CupertinoActionSheetAction(
//                    child: const Text(
//                      'タグ名編集',
//                      style: actionSheetTextStyle,
//                    ),
//                    onPressed: () =>
//                        _onPopupMenuSelected(
//                          context:context,
//                          selectedMenu:TagEditMode.tagTitleEdit,
//                        ),
//                  ),
//                  CupertinoActionSheetAction(
//                    child: const Text(
//                      '削除',
//                      style: actionSheetCationTextStyle,
//                    ),
//                    onPressed: () {
//                      _onPopupMenuSelected(
//                        context:context,
//                        selectedMenu:CompareEditMenu.allListDelete,
//                      );
//                    },
//                  ),
//                ],
//                cancelButton: CupertinoActionSheetAction(
//                  child:  const Text('キャンセル'),
//                  onPressed: ()=>Navigator.pop(context),
//
//                ),
//              );
//            });
//      },
//    );
  }


  void _onPopupMenuSelected({BuildContext context,
    TagEditMode selectedMenu,
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
    }
  }

  void _changeEdit(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
    ..changeToNormal();
  }



}

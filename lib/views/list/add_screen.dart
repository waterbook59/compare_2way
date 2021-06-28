import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/componets/input_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddScreen extends StatelessWidget {

  const AddScreen({
    this.displayMode,
    this.comparisonOverview,
//    this.tagTitle,
//    this.itemTitleEditMode,
  });
  final AddScreenMode displayMode;
  final ComparisonOverview comparisonOverview;
//  final String tagTitle;
//  final ItemTitleEditMode itemTitleEditMode;
//  final String way1Title;
//  final String way2Title;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        //todo Androidでの端末下の戻るボタン無効:WillPopScopeのonWillPopをfalse
//        automaticallyImplyLeading: false,
      leading: displayMode == AddScreenMode.add
      //新規追加時キャンセル
        ? GestureDetector(
        child: const Icon(
          CupertinoIcons.clear_thick_circled,
          color: Colors.white,
        ),
        onTap: () =>Navigator.pop(context)
      )
      //タイトル編集時キャンセル
        : GestureDetector(
          child: const Icon(
            CupertinoIcons.clear_thick_circled,
            color: Colors.white,
          ),
          onTap: ()=> _cancelTitleEdit(context),
      ),
        backgroundColor: primaryColor,
        middle:displayMode == AddScreenMode.add
        ? const Text(
          '新規作成',
          style: middleTextStyle,
        )
        :const Text('名称編集',style: middleTextStyle,),
        /// 下から出てくる場合は右上に比較ボタンでもいいかも

//        trailing:displayMode == AddScreenMode.add
//        //todo  onPressedでDBに項目登録して比較画面に遷移
//        ? const Text(
//          '作成',
//          style: trailingTextStyle,
//        )
//      :
      //todo Containerにするとmiddle文字まで消える
//        Container(),
//        const Text('更新',style: middleTextStyle,),

      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme
            .of(context)
            .scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 48,
              ),
///InputPart
                    InputPart(
                    displayMode: displayMode,
                    comparisonOverview: comparisonOverview,)

            ],
          ),
        ),
      ),
    );
  }

  void _cancelTitleEdit(BuildContext context) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //todo 画面閉じる前にTextFieldへの変更が少し見える
     Navigator.pop(context);
     displayMode == AddScreenMode.add
    ? viewModel.itemControllerClear()
    :viewModel.cancelControllerEdit(comparisonOverview);
  }

}

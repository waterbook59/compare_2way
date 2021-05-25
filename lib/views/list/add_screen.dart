import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/views/list/componets/input_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        //todo Androidでの端末下の戻るボタン無効:WillPopScopeのonWillPopをfalse
        //todo leading新規作成時はキャンセルボタン、編集時はleadingの表示なし
//        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        middle:displayMode == AddScreenMode.add
        ? const Text(
          '新規作成',
          style: middleTextStyle,
        )
        :const Text('名称編集',style: middleTextStyle,),
        /// 下から出てくる場合は右上に比較ボタンでもいいかも
        trailing:displayMode == AddScreenMode.add
        //todo  onPressedでDBに項目登録して比較画面に遷移
        ? const Text(
          '作成',
          style: trailingTextStyle,
        )
      :const Text('更新',style: middleTextStyle,),
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
              InputPart(displayMode: displayMode,
                comparisonOverview: comparisonOverview,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

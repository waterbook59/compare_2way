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
  });
  final AddScreenMode displayMode;
  final ComparisonOverview comparisonOverview;


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        //todo Androidでの端末下の戻るボタン無効:WillPopScopeのonWillPopをfalse
//        automaticallyImplyLeading: false,
      leading:  GestureDetector(
        child: const Icon(
        CupertinoIcons.clear_thick_circled,
        color: Colors.white,
    ),
          onTap: () =>_cancelTitleEdit(context)),
        backgroundColor: primaryColor,
        middle:displayMode == AddScreenMode.add
        ? const Text(
          '新規作成',
          style: middleTextStyle,
        )
        :const Text('名称編集',style: middleTextStyle,),
        /// 下から出てくる場合は右上に比較ボタンでもいいかも

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
    viewModel.itemControllerClear();
  }

}

import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/list/componets/sub/text_field_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class InputPart extends StatelessWidget {
  const InputPart({Key? key, this.displayMode, this.comparisonOverview})
      : super(key: key);

  final AddScreenMode? displayMode;
  final ComparisonOverview? comparisonOverview;

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //todo autofocusが三項条件演算子から変更してできているか確認
    print('autofocusのtrue/false:${displayMode == AddScreenMode.add}');
    return Column(
      children: [
        ///タイトル
        //AddScreenMode.editの場合、
        // controllerはviewModelのitemTitle,way1Title,way2Titleを代入
        TextFieldPart(
          label: 'タイトル',
          placeholder: 'タイトルを入力',
          autofocus:
              // displayMode == AddScreenMode.add ? true : false,
              displayMode == AddScreenMode.add,
          textEditingController: viewModel.titleController,
          //テキスト入力があるかどうかを下のRaisedButtonを押せる押せないのために通知するだけ
          didChanged: (text) => viewModel.itemTitleChanged(),
          iconData: CupertinoIcons.squares_below_rectangle, errorText: '',
        ),
        const SizedBox(height: 8),

        ///way1
        TextFieldPart(
          label: 'way1',
          placeholder: '比較項目を入力',
          autofocus: false,
          textEditingController: viewModel.way1Controller,
          //テキスト入力があるかどうかを下のRaisedButtonを押せる押せないのために通知するだけ
          didChanged: (text) => viewModel.itemTitleChanged(),
          iconData: CupertinoIcons.arrow_uturn_left, errorText: '',
        ),
//        const SizedBox(height: 8),
//        const Text('と', style: TextStyle(color: Colors.black)),
        const SizedBox(height: 8),

        ///way2
        TextFieldPart(
          label: 'way2',
          placeholder: '比較項目を入力',
          autofocus: false,
          textEditingController: viewModel.way2Controller,
          //テキスト入力があるかどうかを下のRaisedButtonを押せる押せないのために通知するだけ
          didChanged: (text) => viewModel.itemTitleChanged(),
          iconData: CupertinoIcons.arrow_uturn_right, errorText: '',
//          iconData: CupertinoIcons.chevron_left_2 ,
//          iconData: CupertinoIcons.arrowshape_turn_up_left_2 ,
//          iconData: CupertinoIcons.arrowshape_turn_up_left ,
//          iconData: CupertinoIcons.arrow_turn_up_left ,
        ),
        const SizedBox(height: 16),
//todo way3のアイコン
//          iconData: CupertinoIcons.arrow_uturn_up ,
        ///button
        Consumer<CompareViewModel>(
          builder: (context, compareViewModel, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: viewModel.titleController.text.isNotEmpty &&
                      viewModel.way1Controller.text.isNotEmpty &&
                      viewModel.way2Controller.text.isNotEmpty
                  ? displayMode == AddScreenMode.add
                      ? () => _createComparisonItems(context)
                      : () => _updateComparisonItems(context)
                  : null,
              child: displayMode == AddScreenMode.add
                  ? const Text('作成')
                  : const Text('更新'),
            );
          },
        ),
      ],
    );
  }

  ///新規作成
  Future<void> _createComparisonItems(BuildContext context) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
      //初期表示は読み込みさせる
      ..compareScreenStatus = CompareScreenStatus.set;

    //Uuid渡したいので、view側でcomparisonOverview作成
    final newComparisonOverview = ComparisonOverview(
      comparisonItemId: const Uuid().v1(),
      itemTitle: viewModel.titleController.text,
      way1Title: viewModel.way1Controller.text,
      way2Title: viewModel.way2Controller.text,
      way1MeritEvaluate: 0,
      way1DemeritEvaluate: 0,
      way2MeritEvaluate: 0,
      way2DemeritEvaluate: 0,
      //todo way3追加
      conclusion: '',
      createdAt: DateTime.now(),
    );

    //最初は1つだけComparisonIdが入ったWay1Merit,Way2Meritを入れたい
    final initWay1Merit = Way1Merit(
      comparisonItemId: newComparisonOverview.comparisonItemId,
      way1MeritDesc: '',
    );
    final initWay2Merit = Way2Merit(
      comparisonItemId: newComparisonOverview.comparisonItemId,
      way2MeritDesc: '',
    );
    final initWay1Demerit = Way1Demerit(
      comparisonItemId: newComparisonOverview.comparisonItemId,
      way1DemeritDesc: '',
    );
    final initWay2Demerit = Way2Demerit(
      comparisonItemId: newComparisonOverview.comparisonItemId,
      way2DemeritDesc: '',
    );
    //todo way3追加

    ///DB登録
    ///viewModel側でcontroller.textを入力してDB登録
    await viewModel.createNewItem(newComparisonOverview);
    //DB登録 Merit/Demeritの1行だけをUuidでつけたComparisonIdを入れて登録する
    await viewModel.createDesc(
      initWay1Merit,
      initWay2Merit,
      initWay1Demerit,
      initWay2Demerit,
    );

    //DBからUuidでつけたComparisonIdを元に1行だけ読込(overviewDBへ格納)=>compareScreenへ渡す
    ///Merit/DemeritのリストはCompareScreenでFutureBuilderから読込のでviewModel側への格納はなし
    await viewModel
        .getComparisonOverview(newComparisonOverview.comparisonItemId);

    ///DBに登録されたcomparisonOverviewをCompareScreenへ渡したい
    ///非同期処理内でBuildContext使う場合context.mounted内で行う
    if (context.mounted) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => CompareScreen(
            screenEditMode: ScreenEditMode.fromListPage,
//                  comparisonOverview: comparisonOverview,
            comparisonOverview: viewModel.overviewDB,
          ),
        ),
      );
    }

    //DB登録後controllerクリア
    await viewModel.itemControllerClear();

    //この時点でcontrollerが破棄されるので、CompareScreenから戻るときにclearメソッドがあると、
    //Once you have called dispose() on a TextEditingController,のエラー出る
  }

  ///更新メソッド
  Future<void> _updateComparisonItems(
    BuildContext context,
  ) async {
    //テキスト入力したものをviewModel側へ格納
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    ///更新時は必ずcomparisonOverviewが入ってくるので強制呼び出し
    await viewModel.updateTitles(comparisonOverview!);

    //todo この書き方でBuildContextを非同期処理内で使っても良いか
    if (context.mounted) {
      return;
    }
    //CompareScreenへ
    Navigator.pop(context);
  }
}

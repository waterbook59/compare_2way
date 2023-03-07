import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/list/componets/input_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class AddScreen extends StatelessWidget {

  const AddScreen({Key? key,
    this.displayMode,
    this.comparisonOverview,
  }) : super(key: key);
  final AddScreenMode? displayMode;
  final ComparisonOverview? comparisonOverview;


  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    final accentColor = Theme.of(context).colorScheme.secondary;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
      leading:  GestureDetector(
        child: const Icon(
        CupertinoIcons.clear_thick_circled,
        color: Colors.white,
    ),
          onTap: () =>_cancelTitleEdit(context),),
        backgroundColor: primaryColor,
        middle:displayMode == AddScreenMode.add
        ? const Text(
          '新規作成',
          style: middleTextStyle,
        )
        :const Text('名称編集',style: middleTextStyle,),
        /// 下から出てくる場合は右上に比較ボタンでもいいかも
        //todo 作成・更新ボタン nullの場合、灰色にしたい
      trailing:
      Consumer<CompareViewModel>(
          builder: (context, compareViewModel, child) {
            return
              viewModel.titleController.text.isNotEmpty &&
                  viewModel.way1Controller.text.isNotEmpty &&
                  viewModel.way2Controller.text.isNotEmpty
            //入力されているとき
             ? CupertinoButton(
                padding: const EdgeInsets.all(8),
                onPressed:
                    displayMode == AddScreenMode.add
                    ?() => _createComparisonItems(context)
                    :()=>_updateComparisonItems(context),
                child: displayMode == AddScreenMode.add
                    ? Text('作成',style: TextStyle(color: accentColor),)
                    : Text('更新',style: TextStyle(color: accentColor),)
            ,)
              //入力されていないとき
             : CupertinoButton(
                padding: const EdgeInsets.all(8),
                onPressed: null,
                child:displayMode == AddScreenMode.add
                    ? const Text('作成',style: TextStyle(color: Colors.grey),)
                    :const Text('更新',style: TextStyle(color: Colors.grey),),);
          },),

      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme
            .of(context)
            .scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
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
     Navigator.pop(context);
    viewModel.itemControllerClear();
  }

  ///新規作成
  Future<void> _createComparisonItems(BuildContext context) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
    //初期表示は読み込みさせる
      ..compareScreenStatus = CompareScreenStatus.set;

    //Uuid渡したいので、view側でcomparisonOverview作成
    //null safty対応でEvaluateの初期値入力
    // =>comparison_item_databaseで初期値0に設定しているので、いらないかも
    final newComparisonOverview = ComparisonOverview(
      comparisonItemId: const Uuid().v1(),
      itemTitle: viewModel.titleController.text,
      way1Title: viewModel.way1Controller.text,
      way2Title: viewModel.way2Controller.text,
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
        initWay1Merit, initWay2Merit,initWay1Demerit,initWay2Demerit,);

    //DBからUuidでつけたComparisonIdを元に1行だけ読込(overviewDBへ格納)=>compareScreenへ渡す
    ///Merit/DemeritのリストはCompareScreenでFutureBuilderから読込のでviewModel側への格納はなし
    await viewModel.getComparisonOverview(
        newComparisonOverview.comparisonItemId,);

    ///DBに登録されたcomparisonOverviewをCompareScreenへ渡したい
    ///非同期処理内でBuildContext使う場合context.mounted内で行う
    if (context.mounted) {
      // return;
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (context) => CompareScreen(
            screenEditMode: ScreenEditMode.fromListPage,
//                  comparisonOverview: comparisonOverview,
            comparisonOverview: viewModel.overviewDB,
          ),),);
    }

    //DB登録後controllerクリア
    await viewModel.itemControllerClear();

    //この時点でcontrollerが破棄されるので、CompareScreenから戻るときにclearメソッドがあると、
    //Once you have called dispose() on a TextEditingController,のエラー出る
  }

  ///更新メソッド
  Future<void>_updateComparisonItems(BuildContext context,
      ) async{
    //テキスト入力したものをviewModel側へ格納
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    ///更新時は必ずcomparisonOverviewが入ってくるので強制呼び出し
    await viewModel.updateTitles(comparisonOverview!);

    //todo この書き方でBuildContextを非同期処理内で使っても良いか
    if (context.mounted) {
      //CompareScreenへ
      Navigator.pop(context);
    }

  }


}

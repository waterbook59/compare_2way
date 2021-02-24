import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/add_view_model.dart';
import 'package:compare_2way/views/common/input_part.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/compare/compare_screen_stateful_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AddViewModel>(context, listen: false);
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;


    return Scaffold(
      appBar:
          //todo 背景色設定
        CupertinoNavigationBar(
          backgroundColor: primaryColor,
        //todo キャンセル表示で入力破棄するかalertDialogで聞く
//        leading:const Text('キャンセル'),
        middle: const Text(
          '新規作成',
          style: middleTextStyle,
        ),

        /// 下から出てくる場合は右上に比較ボタンでもいいかも
        trailing:
            //todo  onPressedでDBに項目登録して比較画面に遷移
            const Text(
          '比較',
          style: trailingTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 72,
            ),
            InputPart(
              label: 'way1',
              placeholder: '比較項目を入力',
              autofocus: true,
              textEditingController: viewModel.way1Controller,
            ),
            const SizedBox(height: 40),
            const Text('と', style: TextStyle(color: Colors.black)),
            const SizedBox(height: 40),
            InputPart(
              label: 'way2',
              placeholder: '比較項目を入力',
              autofocus: false,
              textEditingController: viewModel.way2Controller,
            ),
            const SizedBox(height: 40),
            //todo TextField2つ入力した場合のみボタン押せる
            RaisedButton(
              child: const Text('比較'),
              //todo
              onPressed: () => _createComparisonItems(context),
            )
          ],
        ),
      ),
    );
  }

  ///way1,way2タイトル作成
  //todo 押せる・押せないはinsta_cloneのcomment_input_part参照
  Future<void> _createComparisonItems(BuildContext context) async {
    final viewModel = Provider.of<AddViewModel>(context, listen: false);

    // モデルクラス(compare)に比較項目を登録(idを次の画面に渡したいのでview側で設定)
    //todo ComparisonItemではなく、ComparisonOverviewに変更しては？？
    final comparisonItem = ComparisonItem(
      //comparisonItemIdをuuidで生成
      comparisonItemId: Uuid().v1(),
      way1Title: viewModel.way1Controller.text,
      way2Title: viewModel.way2Controller.text,
    );

    await viewModel.createComparisonItems(comparisonItem);
    ///createComparisonItems()メソッドで設定したcomparisonItemIdを次の画面にわたすには？
    await Navigator.pushReplacement(context,
        MaterialPageRoute<void>(builder: (context) =>
            CompareScreen(comparisonItemId:comparisonItem.comparisonItemId)));

    await viewModel.initializeController();
    print('テキストコントローラー初期化');
  }
}

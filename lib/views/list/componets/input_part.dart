import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/view_model/add_view_model.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/list/componets/text_field_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

///Screenへの通知を行い、登録ボタンを押せるか判断するためstatefulへ変更

class InputPart extends StatefulWidget {

  @override
  _InputPartState createState() => _InputPartState();
}

class _InputPartState extends State<InputPart> {
  final _titleController = TextEditingController();
  final _way1Controller =TextEditingController();
  final _way2Controller = TextEditingController();
  bool  isCreateItemEnabled = false;


  @override
  void initState() {
  _titleController.addListener(_onInputChanged);
  _way1Controller.addListener(_onInputChanged);
  _way2Controller.addListener(_onInputChanged);
  super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme
        .of(context)
        .accentColor;
    return
    Column(children: [
      ///タイトル
      TextFieldPart(
        label: 'タイトル',
        placeholder: 'タイトルを入力',
        autofocus: true,
        textEditingController: _titleController,
      ),
      const SizedBox(height: 24),
      ///way1
      TextFieldPart(
        label: 'way1',
        placeholder: '比較項目を入力',
        autofocus: false,
        textEditingController: _way1Controller,
      ),
      const SizedBox(height: 8),
      const Text('と', style: TextStyle(color: Colors.black)),
      const SizedBox(height: 8),
      ///way2
      TextFieldPart(
        label: 'way2',
        placeholder: '比較項目を入力',
        autofocus: false,
        textEditingController: _way2Controller,
      ),
      const SizedBox(height: 40),
      ///button
      RaisedButton(
        child: const Text('比較'),
        color: accentColor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)),
      //todo
        onPressed:isCreateItemEnabled
        ? () => _createComparisonItems(context)
        : null,
    ),
    ],);

  }

  ///ここでAddViewModelのisCreateItemEnabledをセットする
  void _onInputChanged() {
    final viewModel = Provider.of<AddViewModel>(context, listen: false);
    setState(() {
      if (
          _titleController.text.isNotEmpty &&
          _way1Controller.text.isNotEmpty &&
          _way2Controller.text.isNotEmpty
      ) {
        isCreateItemEnabled = true;
      } else {
        isCreateItemEnabled = false;
      }
    });
  }

  ///textEditingControllerをviewModel側でもたずに、ここでのcontrollerを入力して
///createConparisonItems=>viewModel.createComparisonItems(comparisonItem);を実行
  // 押せる・押せないはinsta_cloneのcomment_input_part参照
  Future<void> _createComparisonItems(BuildContext context) async {
    final viewModel = Provider.of<AddViewModel>(context, listen: false);

    // モデルクラス(compare)に比較項目を登録(idを次の画面に渡したいのでview側で設定)
    //todo ComparisonItemではなく、ComparisonOverviewに変更しては？？
    final comparisonItem = ComparisonItem(
      //comparisonItemIdをuuidで生成
      comparisonItemId: Uuid().v1(),
      itemTitle: _titleController.text,
      way1Title: _way1Controller.text,
      way2Title: _way2Controller.text,
    );

    await viewModel.createComparisonItems(comparisonItem);

    ///createComparisonItems()メソッドで設定したcomparisonItemIdを次の画面にわたすには？
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (context) =>
                CompareScreen(
                    comparisonItemId: comparisonItem.comparisonItemId)));

    _titleController.clear();
    _way1Controller.clear();
    _way2Controller.clear();
    print('テキストコントローラー初期化');
  }

}

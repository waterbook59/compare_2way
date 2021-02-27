import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/add_view_model.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/list/componets/text_field_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

///Screenへの通知を行い、登録ボタンを押せるか判断するためstatefulへ変更
///Changenoitfierのbuilder内で実行しないとエラー？？？(instacloneのcommentscreenの場所確認)
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
    _way1Controller.dispose();
    _way2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;
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
            onPressed:isCreateItemEnabled
            ? () => _createComparisonItems(context)
            : null,
        ),
        ],);


  }

  ///ここでAddViewModelのisCreateItemEnabledをセットする
  void _onInputChanged() {
    final viewModel = Provider.of<AddViewModel>(context, listen: false);

    viewModel.title = _titleController.text;
    viewModel.way1Title = _way1Controller.text;
    viewModel.way2Title = _way2Controller.text;
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

  // 押せる・押せないはinsta_cloneのcomment_input_part参照
  ///textEditingControllerをview側で設定=>viewModelに設定するメソッド
  Future<void> _createComparisonItems(BuildContext context) async {
    final viewModel = Provider.of<AddViewModel>(context, listen: false);

    // モデルクラス(compare)に比較項目を登録(idを次の画面に渡したいのでview側で設定)
    //todo ComparisonItemではなく、ComparisonOverviewに変更しては？？
    final comparisonItem = ComparisonItem(
      //comparisonItemIdをuuidで生成
      comparisonItemId: Uuid().v1(),
      itemTitle: viewModel.title,
      way1Title: viewModel.way1Title,
      way2Title: viewModel.way2Title,
    );

    await viewModel.createComparisonItems(comparisonItem);

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (context) =>
                CompareScreen(
                    comparisonItemId: comparisonItem.comparisonItemId)));
            //この時点でcontrollerが破棄されるので、CompareScreenから戻るときにclearメソッドがあると、
            //Once you have called dispose() on a TextEditingController,のエラー出る
  }

}

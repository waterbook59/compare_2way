import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/merit_demerit.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/add_view_model.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/compare/compare_screen_stateful.dart';
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


  //todo ListPageの更新が必要ないならaddListenerいらないかも（無駄に何度もConsumerが反応してしまうので。）
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
    final viewModel = Provider.of<AddViewModel>(context, listen: false)
    ..title =_titleController.text
    ..way1Title = _way1Controller.text
    ..way2Title = _way2Controller.text;

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
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
    //初期表示は読み込みさせる
    ..compareScreenStatus =CompareScreenStatus.set;

    // ComparisonItemではなく、ComparisonOverviewに変更,CompareScreenへ値渡し
    final comparisonOverview = ComparisonOverview(
      comparisonItemId: Uuid().v1(),
      itemTitle: _titleController.text,
      way1Title: _way1Controller.text,
      way2Title: _way2Controller.text,
      createdAt: DateTime.now(),
    );

    //最初は1つだけComparisonIdが入ったWay1Merit,Way2Meritを入れたい
    final initWay1Merit = Way1Merit(
      comparisonItemId: comparisonOverview.comparisonItemId,
      way1MeritDesc: '',
    );
    final initWay2Merit = Way2Merit(
      comparisonItemId: comparisonOverview.comparisonItemId,
      way2MeritDesc: '',
    );

    //登録
    await viewModel.createComparisonOverview(comparisonOverview);
    //Merit/DemeritのListをComparisonIdを入れて登録する
    await viewModel.createDesc(initWay1Merit,initWay2Merit);

    //読み込み=>compareScreenへ渡す
    await viewModel.getComparisonOverview(comparisonOverview.comparisonItemId);

    ///DBに登録されたcomparisonOverviewをCompareScreenへ渡したい
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (context) =>
                CompareScreen(
                  itemEditMode: ItemEditMode.add,
//                  comparisonOverview: comparisonOverview,
                  comparisonOverview: viewModel.overviewDB,

                )));
            //この時点でcontrollerが破棄されるので、CompareScreenから戻るときにclearメソッドがあると、
            //Once you have called dispose() on a TextEditingController,のエラー出る
  }

}

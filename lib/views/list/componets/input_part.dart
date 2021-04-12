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
  const InputPart({
    this.displayMode,
    this.itemTitle,
    this.way1Title,
    this.way2Title,
  });

  final AddScreenMode displayMode;
  final String itemTitle;
  final String way1Title;
  final String way2Title;

  @override
  _InputPartState createState() => _InputPartState();
}

class _InputPartState extends State<InputPart> {
  final _titleController = TextEditingController();
  final _way1Controller = TextEditingController();
  final _way2Controller = TextEditingController();
  bool isCreateItemEnabled = false;

  //addListenerはcontrollerの入力値とviewModelの値とのやりとりをするのに必須
  @override
  void initState() {

    _titleController.addListener(_onInputChanged);
    _way1Controller.addListener(_onInputChanged);
    _way2Controller.addListener(_onInputChanged);

    //add画面で入力しても''の状態のまま
        switch(widget.displayMode){
      case AddScreenMode.add:
        _titleController.text = '';
        _way1Controller.text = '';
        _way2Controller.text = '';
        break;
    //todo キャンセルして戻った場合、仮でも変更値がviewModelを経由してして画面に反映されてしまう
      case AddScreenMode.edit:
        _titleController.text = widget.itemTitle;
        _way1Controller.text = widget.way1Title;
        _way2Controller.text = widget.way2Title;
    }

//    switch(widget.displayMode){
//      case AddScreenMode.add:
//        _titleController.addListener(onCaptionAdd);
//        _way1Controller.addListener(onCaptionAdd);
//        _way2Controller.addListener(onCaptionAdd);
//        break;
//      case AddScreenMode.edit:
//        onCationEdit();
//        break;
//    }


//    _titleController.addListener(()=>_onCaptionUpdated(
//    widget.itemTitle,widget.way1Title, widget.way2Title,widget.displayMode,));
//    _way1Controller.addListener(()=>_onCaptionUpdated(
//    widget.itemTitle,widget.way1Title, widget.way2Title,widget.displayMode,));
//    _way2Controller.addListener(()=>_onCaptionUpdated(
//    widget.itemTitle,widget.way1Title, widget.way2Title,widget.displayMode,));

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
    return Column(
      children: [
        ///タイトル
        TextFieldPart(
          label: 'タイトル',
          placeholder: 'タイトルを入力',
          autofocus: widget.displayMode == AddScreenMode.add
               ?true:false,
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
          child: widget.displayMode == AddScreenMode.add
              ?const Text('比較')
              :const Text('更新'),
          color: accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: isCreateItemEnabled
          //todo AddScreenMode.addならcreateメソッド、
          // AddScreenMode.editならupdateメソッド
              ? () => _createComparisonItems(context)
              : null,
        ),
      ],
    );
  }

  ///ここでAddViewModelのisCreateItemEnabledをセットする
  //todo AddViewModel=>CompareViewModelで統一
  void _onInputChanged() {
    //add画面で入力しても''の状態のまま
//        switch(widget.displayMode){
//      case AddScreenMode.add:
//        _titleController.text = '';
//        _way1Controller.text = '';
//        _way2Controller.text = '';
//        break;
        //edit画面では入力値の状態のまま
//      case AddScreenMode.edit:
//        _titleController.text = widget.itemTitle;
//        _way1Controller.text = widget.way1Title;
//        _way2Controller.text = widget.way2Title;
//    }

    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
      ..itemTitle = _titleController.text
      ..way1Title = _way1Controller.text
      ..way2Title = _way2Controller.text;

    setState(() {
      if (_titleController.text.isNotEmpty &&
          _way1Controller.text.isNotEmpty &&
          _way2Controller.text.isNotEmpty) {
        isCreateItemEnabled = true;
      } else {
        isCreateItemEnabled = false;
      }
    });
  }

  void _onCaptionUpdated(String itemTitle, String way1Title, String way2Title,
      AddScreenMode displayMode) {
    final viewModel = Provider.of<AddViewModel>(context, listen: false);
    print('inputPart/onCaptionUpdated/itemTitle:$itemTitle');
    switch (displayMode) {
      case AddScreenMode.add:
        viewModel.title = _titleController.text;
        viewModel.way1Title = _way1Controller.text;
        viewModel.way2Title = _way2Controller.text;
        setState(() {
          if (_titleController.text.isNotEmpty &&
              _way1Controller.text.isNotEmpty &&
              _way2Controller.text.isNotEmpty) {
            isCreateItemEnabled = true;
          } else {
            isCreateItemEnabled = false;
          }
        });
        break;
        //todo 入力文字がタップしないと出てこない＆テキスト入力できない
      case AddScreenMode.edit:
        _titleController.text = itemTitle;
        _way1Controller.text = way1Title;
        _way2Controller.text = way2Title;
        setState(() {
          if (_titleController.text.isNotEmpty &&
              _way1Controller.text.isNotEmpty &&
              _way2Controller.text.isNotEmpty) {
            isCreateItemEnabled = true;
          } else {
            isCreateItemEnabled = false;
          }
        });
        break;
    }
  }

  // 押せる・押せないはinsta_cloneのcomment_input_part参照
  ///textEditingControllerをview側で設定=>viewModelに設定するメソッド
  Future<void> _createComparisonItems(BuildContext context) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
      //初期表示は読み込みさせる
      ..compareScreenStatus = CompareScreenStatus.set;

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
    await viewModel.createDesc(initWay1Merit, initWay2Merit);

    //読み込み=>compareScreenへ渡す
    await viewModel.getComparisonOverview(comparisonOverview.comparisonItemId);

    ///DBに登録されたcomparisonOverviewをCompareScreenへ渡したい
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (context) => CompareScreen(
                  itemEditMode: ItemEditMode.add,
//                  comparisonOverview: comparisonOverview,
                  comparisonOverview: viewModel.overviewDB,
                )));
    //この時点でcontrollerが破棄されるので、CompareScreenから戻るときにclearメソッドがあると、
    //Once you have called dispose() on a TextEditingController,のエラー出る
  }


  void onCaptionAdd() {
    _titleController.text = '';
    _way1Controller.text = '';
    _way2Controller.text = '';
    //todo 入力変更を通知しないと入力してもボタン押せない=>textControllerのaddListener登録
    //=>このままaddListener登録しても入力できない(viewModelのプロパティへの代入が必要)
    setState(() {
      if (_titleController.text.isNotEmpty &&
          _way1Controller.text.isNotEmpty &&
          _way2Controller.text.isNotEmpty) {
        isCreateItemEnabled = true;
      } else {
        isCreateItemEnabled = false;
      }
    });
  }

  void onCationEdit() {
    _titleController.text = widget.itemTitle;
    _way1Controller.text = widget.way1Title;
    _way2Controller.text = widget.way2Title;
    //入力変更を通知しないとテキストがnullでもボタン押せてしまう
    setState(() {
      if (_titleController.text.isNotEmpty &&
          _way1Controller.text.isNotEmpty &&
          _way2Controller.text.isNotEmpty) {
        isCreateItemEnabled = true;
      } else {
        isCreateItemEnabled = false;
      }
    });
  }
}

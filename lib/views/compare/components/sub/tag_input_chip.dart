import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TagInputChip extends StatefulWidget {

  const TagInputChip({
    this.onSubmitted,
    this.setTempoInput,
    this.onFocusChange});
  //入力値をtagChipsへ上げる
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> setTempoInput;
  final ValueChanged<FocusNode>onFocusChange;

  @override
  _TagInputChipState createState() => _TagInputChipState();
}

class _TagInputChipState extends State<TagInputChip> {
  final _tagTitleController = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool isInput=false;


  @override
  void initState() {
  _tagTitleController.text = '';
  //参考 https://qiita.com/superman9387/items/33908a0fd67cab109d7e
  _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _tagTitleController.dispose();
    super.dispose();
  }

  @override
  //バリデーションや入力完了後のメソッドを入れたいのでTextFormFiledへ変更
  Widget build(BuildContext context) {
    return
      //todo 入力に合わせてChipのばしたい
//      _focus.hasFocus
  isInput
      //フォーカスしてる時はプラスアイコンなしのTextField
    ?Chip(
        backgroundColor: Colors.blue[100],
        label:SizedBox(
          //todo focus時プラスアイコンの残像がでる
        width:
        MediaQuery.of(context).size.width*0.3,
        child:
        //todo CupertinoTextFIeldへ変更
        //            CupertinoTextField(
//              onSubmitted: null,
//              autofocus: true,
//              controller: _tagTitleController,
//              placeholder: 'タグを追加',
//            ),
        TextField(
          // ignore: lines_longer_than_80_chars
          // onChangedでviewModelのtempoInputTagに一旦setし、tagDialogPageで完了をおしたら入力有無のvalidationしつつ_tagNameListに追加&登録
          onChanged: (tempoInput){
            print('tagInputChip/onChanged/tempoInput:$tempoInput');
            widget.setTempoInput(tempoInput);
          },
          focusNode: _focus,
          onSubmitted: (input){
            print('tagInputChip/onSubmitted/input:$input');
            //入力完了したらDB登録し、chipsのリスト内に入れて、入力chipの左に並べて表示
            _onSubmitted(context,input);
          },
          maxLines: 1,
          autofocus: true,
          controller: _tagTitleController,
          //decorationをnullにするとpadding含め余計な装飾は全てなくなる
          decoration:
//          null,
          const InputDecoration(
            hintText: 'タグを追加',
            border: InputBorder.none,
            //isDenseで少し幅狭くなる
            isDense:true,
//              contentPadding: EdgeInsets.all(8),
          ),

        ),
      ),)
    : ActionChip(
        avatar: const Icon(Icons.add_circle_outline),
        backgroundColor: Colors.blue[100],
        label: const Text('タグを入力'),
        onPressed: (){
          setState(() {
            isInput = true;
          });
        }
//        =>_onTapFocused(context, isInput),
      );
//      Chip(
//      avatar: const Icon(Icons.add_circle_outline),
//      backgroundColor: Colors.blue[100],
//      label:
//          //todo focusで場合わけしたのでtetFieldいらん
//     SizedBox(
//        width: MediaQuery.of(context).size.width*0.3,
//       //todo CupertinoTextFIeldへ変更
//        child:TextField(
//          // ignore: lines_longer_than_80_chars
//          // onChangedでviewModelのtempoInputTagに一旦setし、tagDialogPageで完了をおしたら入力有無のvalidationしつつ_tagNameListに追加&登録
//          onChanged: (tempoInput){
//            widget.setTempoInput(tempoInput);
//          },
//          focusNode: _focus,
//            onSubmitted: (input){
//              //入力完了したらDB登録し、chipsのリスト内に入れて、入力chipの左に並べて表示
//              _onSubmitted(context,input);
//            },
//            maxLines: 1,
//            controller: _tagTitleController,
//            //decorationをnullにするとpadding含め余計な装飾は全てなくなる
//            decoration:
//            const InputDecoration(
//              hintText: 'タグを追加',
//              border: InputBorder.none,
//              //isDenseで少し幅狭くなる
//              isDense:true,
////              contentPadding: EdgeInsets.all(8),
//            ),
//
//        ),
//      ),
//
//    );


  }

  //todo 削除
  ///ここではviewModelへのセットは行わず、AppBarの完了ボタンでセットする
  //直接入力値をセットする場合のみinitStateでメソッドをAddListener登録する
  void _onCaptionUpdated(){
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
      ..tagTitle = _tagTitleController.text;
  }

  void _onSubmitted(
    BuildContext context, String input,){
//    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
//    ..createTag(input,comparisonOverview);
    print('tagInputChip/_onSubmitted:$input');
  widget.onSubmitted(input);
  _tagTitleController.text ='';
  //controller破棄してリフレッシュ
  setState(() {
  });
  }

  //tagInputChipのautoFocus外して入力モードになったら+create'...'ボタン出す
  void _onFocusChange() {
    widget.onFocusChange(_focus);
  }

//  void _onTapFocused(BuildContext context, bool isInput) {
////    FocusScope.of(context).requestFocus(_focus);
//       setState(() {
//         isInput = !isInput;
//       });
//  }
}


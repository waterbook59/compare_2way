import 'package:flutter/material.dart';

class TagInputChip extends StatefulWidget {

  const TagInputChip({Key? key,
    required this.onSubmitted,
    required this.setTempoInput,
    required this.onFocusChange,
  required this.isInput,
  required this.onChangeInputMode,}) : super(key: key);
  //入力値をtagChipsへ上げる
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> setTempoInput;
  final ValueChanged<FocusNode>onFocusChange;
  final VoidCallback onChangeInputMode;
  final bool isInput;

  @override
  State<TagInputChip> createState() => _TagInputChipState();
}

class _TagInputChipState extends State<TagInputChip> {
  final _tagTitleController = TextEditingController();
  final FocusNode _focus = FocusNode();


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
    /// //todo _focus dispose?
    super.dispose();
  }

  @override
  //バリデーションや入力完了後のメソッドを入れたいのでTextFormFiledへ変更
  Widget build(BuildContext context) {
    return
      /// //todo 入力に合わせてChipのばしたい
   widget.isInput
      //フォーカスしてる時はプラスアイコンなしのTextField
    ?Chip(
        backgroundColor: Colors.blue[100],
        label:SizedBox(
        width:
        MediaQuery.of(context).size.width*0.3,
        child:
        /// //todo CupertinoTextFieldへ変更
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
            widget.setTempoInput(tempoInput);
          },
          focusNode: _focus,
          onSubmitted: (input){
            //入力完了したらDB登録し、chipsのリスト内に入れて、入力chipの左に並べて表示
            _onSubmitted(context,input);
          },
          autofocus: true,
          controller: _tagTitleController,
          decoration:
          const InputDecoration(
            hintText: 'タグを追加',
            border: InputBorder.none,
            //isDenseで少し幅狭くなる
            isDense:true,
          ),

        ),
      ),)
    : ActionChip(
        avatar: const Icon(Icons.add_circle_outline),
        backgroundColor: Colors.blue[100],
        label: const Text('タグを入力'),
        onPressed: (){
          //TagInputChip表示をTextFieldへ変更
          widget.onChangeInputMode();
          _tagTitleController.text = '';
        }
      ,);


  }

  void _onSubmitted(
    BuildContext context, String input,){
  widget.onSubmitted(input);
  _tagTitleController.text ='';
  }

  //tagInputChipのautoFocus外して入力モードになったら+create'...'ボタン出す
  void _onFocusChange() {
    widget.onFocusChange(_focus);
  }

}

import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///初期値をString conclusionで渡して、controllerは分割先で設定
class ConclusionInputPart extends StatefulWidget {
  const ConclusionInputPart(
      {

        this.conclusion,
      this.conclusionController,
      this.inputChanged,
      this.onEditingCompleted,
      this.onFieldSubmitted,
      this.onSaved});

  final TextEditingController conclusionController;
  final String conclusion;
//  final GlobalKey<FormState> formKey;
  ///CompareScreenへ新しく入力した文字を渡す
  ///final Function(String) inputChangedでも良い(ValueChangedは引数を<>で記載)

  final Function(String) inputChanged;
  final Function(String) onEditingCompleted;
  final Function(String) onFieldSubmitted;
  final Function(String) onSaved;

  @override
  _ConclusionInputPartState createState() => _ConclusionInputPartState();
}

class _ConclusionInputPartState extends State<ConclusionInputPart> {
  final _conclusionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _conclusionController.text = widget.conclusion;
    super.initState();
  }

  ///disposeしないとCompareScreen側で保存されない
  @override
  void dispose() {
    _conclusionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      ///Formにコンストラクタ経由でformKey渡すとキーボードが開いてすぐ閉じてしまう
      ///とりあえずCompareScreenで実装（widget分割はあとで）
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextFormField(
          //initialValueとcontrollerの両方は使用できない
//          initialValue: widget.conclusion,
          controller: _conclusionController,
//          onChanged: widget.inputChanged,
//          onEditingComplete: () {
//            widget.onEditingCompleted(_conclusionController.text);
//          },
      onSaved: widget.onSaved,


        ///onFiledSubmittedはdoneボタン時
//        onFieldSubmitted: widget.onFieldSubmitted,
        ///onSaved+key設定でFormの内容保存できる？
          minLines: 6,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),//Padding
    );
  }
  //新しく入力した文字を表示=>onEditingCompleted
  // CompareScreenへ渡す=>onChanged

}

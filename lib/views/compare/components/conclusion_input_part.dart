import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///初期値をString conclusionで渡して、controllerは分割先で設定
class ConclusionInputPart extends StatefulWidget {
  const ConclusionInputPart(
      {this.conclusion,
      this.conclusionController,
      this.inputChanged,
      this.onEditingCompleted});

  final TextEditingController conclusionController;
  final String conclusion;

  ///CompareScreenへ新しく入力した文字を渡す
  ///final Function(String) inputChangedでも良い(ValueChangedは引数を<>で記載)
//  final ValueChanged<String> inputChanged;
  final Function(String) inputChanged;
  final Function(String) onEditingCompleted;

  @override
  _ConclusionInputPartState createState() => _ConclusionInputPartState();
}

class _ConclusionInputPartState extends State<ConclusionInputPart> {
  final _conclusionController = TextEditingController();

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        //initialValueとcontrollerの両方は使用できない
        controller: _conclusionController,
        onChanged: widget.inputChanged,
        onEditingComplete: () {
          widget.onEditingCompleted(_conclusionController.text);
        },
        minLines: 6,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
  //新しく入力した文字を表示=>onEditingCompleted
  // CompareScreenへ渡す=>onChanged

}

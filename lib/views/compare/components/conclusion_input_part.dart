import 'package:flutter/material.dart';

///初期値をString conclusionで渡して、controllerは分割先で設定
class ConclusionInputPart extends StatefulWidget {
  const ConclusionInputPart(
      {Key? key,
        required this.conclusion,
//      this.conclusionController,
      this.inputChanged,
//      this.onEditingCompleted,
//      this.onFieldSubmitted,
//      this.onSaved
      }) : super(key: key);

//  final TextEditingController conclusionController;
  final String conclusion;
//  final GlobalKey<FormState> formKey;
  ///CompareScreenへ新しく入力した文字を渡す
  ///final Function(String) inputChangedでも良い(ValueChangedは引数を<>で記載)

  final Function(String)? inputChanged;
//  final Function(String) onEditingCompleted;
//  final Function(String) onFieldSubmitted;
//  final Function(String) onSaved;

  @override
  _ConclusionInputPartState createState() => _ConclusionInputPartState();
}

class _ConclusionInputPartState extends State<ConclusionInputPart> {
  final _conclusionController = TextEditingController();


  @override
  void initState() {
    ///直接viewModelへ変更した値を保存するならaddListener(都度notifyListenerなのでコスト高？)
//    _conclusionController.addListener(_onInputChanged);
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
///変更した値をviewに渡して非同期保存するならonChanged(都度notifyListenerはなし)
          onChanged: widget.inputChanged,
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

  // void _onInputChanged() {
  //   final viewModel=Provider.of<CompareViewModel>(context, listen: false)
  //   ..conclusion= _conclusionController.text
  //   ..compareScreenStatus = CompareScreenStatus.update;
  //   print('viewModel.conclusion:${viewModel.conclusion}');
  //   setState(() {
  //   });
  //   }


}

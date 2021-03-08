import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConclusionInputPart extends StatefulWidget {
  const ConclusionInputPart({this.controller});
  final TextEditingController controller;

  @override
  _ConclusionInputPartState createState() => _ConclusionInputPartState();
}

class _ConclusionInputPartState extends State<ConclusionInputPart> {

//  final _conclusionController = TextEditingController();

  @override
  void initState() {
//    _conclusionController.addListener(_onInputChanged);
    super.initState();
  }

  @override
  void dispose() {
//    _conclusionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        // any number you need (It works as the rows for the textarea)
        controller: widget.controller,
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

//  void _onInputChanged() {
//    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
//    //viewModelのプロパティに入力テキストをセット
//    viewModel.conclusion = _conclusionController.text;
//    //画面更新
//    setState(() {
//    });
//
//  }
}

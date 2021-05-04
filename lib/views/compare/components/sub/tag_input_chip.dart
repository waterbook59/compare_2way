import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TagInputChip extends StatefulWidget {

  const TagInputChip({this.onSubmitted});
  //入力値をtagChipsへ上げる
  final ValueChanged<String> onSubmitted;

  @override
  _TagInputChipState createState() => _TagInputChipState();
}

class _TagInputChipState extends State<TagInputChip> {
  final _tagTitleController = TextEditingController();


  @override
  void initState() {
  _tagTitleController.text = '';
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
    Chip(
      avatar: const Icon(Icons.add_circle_outline),
      backgroundColor: Colors.blue,
      label: Container(
        width: MediaQuery.of(context).size.width*0.3,
        child:
//            CupertinoTextField(
//              onSubmitted: null,
//              autofocus: true,
//              controller: _tagTitleController,
//              placeholder: 'タグを追加',
//            ),
        TextField(
            onSubmitted: (input){
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

      ),
    );


  }

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

}


import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TagInputPart extends StatefulWidget {
  @override
  _TagInputPartState createState() => _TagInputPartState();
}

class _TagInputPartState extends State<TagInputPart> {
  final _tagTitleController = TextEditingController();


  @override
  void initState() {
    ///addListenerしているのでCompareScreenのAccordionPartとかは同時に回る(致し方なし)
    _tagTitleController.addListener(_onCaptionUpdated);
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
    //textfieldにあわせてchipを伸ばしたい
      Container(
        width: MediaQuery.of(context).size.width*0.3,
//        height: MediaQuery.of(context).size.height*0.01,
        child:
//            CupertinoTextField(
//              onSubmitted: null,
//              autofocus: true,
//              controller: _tagTitleController,
//              placeholder: 'タグを追加',
//            ),
        TextField(
//          textAlignVertical: TextAlignVertical(y: 0),
          onSubmitted: (input){
            //todo 入力完了したらDB登録し、chipsのリスト内に入れて、入力chipの左に並べて表示
            print('tagの入力完了！！:$input');
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
              isDense:true,
//              contentPadding: EdgeInsets.all(8),
          )
    ),

      );
  }

  void _onCaptionUpdated(){
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
      ..tagTitle = _tagTitleController.text;
  }

}


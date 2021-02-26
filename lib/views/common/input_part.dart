import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Screenへの通知を行い、登録ボタンを押せるか判断するためstatefulへ変更

class InputPart extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool autofocus;
  final TextEditingController textEditingController;
  final String errorText;
  final ValueChanged<String> didChanged;

  // ignore: sort_constructors_first
  const InputPart(
      {this.label, this.textEditingController,
        this.errorText, this.didChanged, this.placeholder, this.autofocus});

//  final bool isTextInputEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      //TextとTextField左寄せ、デフォルトは中央よせ
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left:40),
          child: Text(label,
//todo style設定
            style: TextStyle(color: Colors.black),
//          style: addTaskTextStyle,
            textAlign: TextAlign.start,),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8,left: 40,right: 40),
          child: CupertinoTextField(
            controller: textEditingController,
            placeholder: placeholder,
            autofocus: autofocus,
//            enabled: isTextInputEnabled,
            //todo style設定
            style: TextStyle(color: Colors.black),
//            style: inputTextStyle,
            keyboardType: TextInputType.text,
            //decoration:InputDecoration()をいれるとバリデーション後エラーメッセージ表示
//            decoration: InputDecoration(errorText: errorText),
            //リアルタイムで入力した文字を返せる
            onChanged: didChanged,
//            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

}

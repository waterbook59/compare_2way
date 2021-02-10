import 'package:flutter/material.dart';

class InputPart extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final String errorText;
  final ValueChanged<String> didChanged;

  // ignore: sort_constructors_first
  const InputPart(
      {this.label, this.textEditingController,
        this.errorText, this.didChanged});

//  final bool isTextInputEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      //TextとTextField左寄せ、デフォルトは中央よせ
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,
//todo style設定
//          style: addTaskTextStyle,
          textAlign: TextAlign.start,),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: TextField(
            controller: textEditingController,
//            enabled: isTextInputEnabled,
            //todo style設定
//            style: inputTextStyle,
            keyboardType: TextInputType.text,
            //decoration:InputDecoration()をいれるとバリデーション後エラーメッセージ表示
            decoration: InputDecoration(errorText: errorText),
            //リアルタイムで入力した文字を返せる
            onChanged: didChanged,
//            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

}

import 'package:compare_2way/views/compare/components/icon_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldPart extends StatelessWidget {
  const TextFieldPart(
      {Key? key, required this.label,
      required this.textEditingController,
      required this.errorText,
      required this.didChanged,
      required this.placeholder,
      required this.autofocus,
      required this.iconData,}) : super(key: key);

  final String label;
  final String placeholder;
  final bool autofocus;
  final TextEditingController textEditingController;
  final String errorText;
  final ValueChanged<String> didChanged;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    return Column(
      //TextとTextField左寄せ、デフォルトは中央よせ
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: //todo Text=>アイコンタイトルへ変更
              IconTitle(
            title: label,
            iconData: iconData,
            iconColor: accentColor,
          ),
//          Text(label,
//            style: TextStyle(color: Colors.black),
////          style: addTaskTextStyle,
//            textAlign: TextAlign.start,),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 40, right: 40),
          child: CupertinoTextField(
            controller: textEditingController,
            placeholder: placeholder,
            autofocus: autofocus,
//            enabled: isTextInputEnabled,
            //todo style設定
            style: const TextStyle(color: Colors.black),
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

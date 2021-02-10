import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/common/input_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {

  AddDialog({@required this.onSave});
  ///保存おしたらDB登録とComparePageへ移動
  final VoidCallback onSave;

  TextEditingController _way1Controler =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        //todo キャンセル,Navigator.pop(context)
        middle: const Text(
          '新規作成',
          style: middleTextStyle,
        ),
        trailing:
            //todo  onPressedでDBに項目登録して比較画面に遷移
        const Text(
          '保存',
          style: trailingTextStyle,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8,),
          InputPart(
            label: 'way1',
            textEditingController: _way1Controler,
          ),
          const SizedBox(height: 8,),
          RaisedButton(
            //todo
            onPressed: ()=>print('DBに項目登録して比較画面に遷移'),
          )

        ],
      ),
    );
  }
}

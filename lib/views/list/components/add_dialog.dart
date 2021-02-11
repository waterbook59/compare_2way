import 'package:compare_2way/style.dart';
import 'package:compare_2way/views/common/input_part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {

  AddDialog({@required this.onSave});
  ///保存おしたらDB登録とComparePageへ移動
  final VoidCallback onSave;

  TextEditingController _way1Controller =TextEditingController();
  TextEditingController _way2Controller =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        //todo キャンセル表示で入力破棄するかalertDialogで聞く
//        leading:const Text('キャンセル'),
        middle: const Text(
          '新規作成',
          style: middleTextStyle,
        ),
        /// 下から出てくる場合は右上に比較ボタンでもいいかも
        trailing:
            //todo  onPressedでDBに項目登録して比較画面に遷移
        const Text(
          '比較',
          style: trailingTextStyle,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 72,),
            InputPart(
              label: 'way1',
              placeholder: '比較項目を入力',
              autofocus: true,
              textEditingController: _way1Controller,
            ),
            const SizedBox(height: 40),
            const Text('と',style:TextStyle(color: Colors.black)),
            const SizedBox(height: 40),
            InputPart(
              label: 'way2',
              placeholder: '比較項目を入力',
              autofocus: false,
              textEditingController: _way2Controller,
            ),
            const SizedBox(height: 40),
            RaisedButton(
              child: const Text('比較'),
              //todo
              onPressed: ()=>print('DBに項目登録して比較画面に遷移'),
            )

          ],
        ),
      ),
    );
  }
}

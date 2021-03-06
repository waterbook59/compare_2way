import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/add_view_model.dart';
import 'package:compare_2way/views/list/componets/input_part.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        //todo キャンセル表示で入力破棄するかalertDialogで聞く&textcontrollerクリア
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
      child: Scaffold(
        backgroundColor: CupertinoTheme
            .of(context)
            .scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 48,
              ),
///InputPart
              InputPart(),
            ],
          ),
        ),
      ),
    );
  }

}

import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/add_view_model.dart';
import 'package:compare_2way/views/common/input_part.dart';
import 'package:compare_2way/views/compare/compare_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<AddViewModel>(context, listen: false);

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
              textEditingController: viewModel.way1Controller,
            ),
            const SizedBox(height: 40),
            const Text('と',style:TextStyle(color: Colors.black)),
            const SizedBox(height: 40),
            InputPart(
              label: 'way2',
              placeholder: '比較項目を入力',
              autofocus: false,
              textEditingController: viewModel.way2Controller,
            ),
            const SizedBox(height: 40),
            //todo TextField2つ入力した場合のみボタン押せる
            RaisedButton(
              child: const Text('比較'),
              //todo
              onPressed:()=>_createComparisonItems(context),

            )

          ],
        ),
      ),
    );
  }


 Future<void> _createComparisonItems(BuildContext context) async{
   final viewModel = Provider.of<AddViewModel>(context, listen: false);
   await viewModel.createComparisonItems();
   await Navigator.pushReplacement(context,  MaterialPageRoute<void>(builder: (context) => ComparePage()));
    print('DBに項目登録して比較画面に遷移');
  }
}

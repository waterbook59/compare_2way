import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagDialogPage extends StatelessWidget {
  final _tagTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFF363A44),
          middle:const Text('タグの追加・編集'),
//todo leadingはxボタンに変更
//          leading: CupertinoButton(
//            child:const Text('キャンセル'),
//            onPressed:  () {
//              Navigator.of(context).pop();
//            },
//          ),
          trailing: CupertinoButton(
            child:const Text('完了'),
            onPressed: (){
              print('タグ編集完了してCompareScreenに戻る');
              Navigator.of(context).pop();
            },
          )
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'タグ',
                textAlign: TextAlign.left,
              ),
            ),
            InputChip(
              avatar: const Icon(Icons.add_circle_outline),
              backgroundColor: Colors.red,
              label:
//              Theme(
//                data:
//                Theme.of(context).copyWith(splashColor: Colors.transparent),
//                child:
                TextField(
                  autofocus: true,
                  controller: _tagTitleController,
                    decoration:InputDecoration(
                      hintText: 'タグを追加',
                      border: InputBorder.none
                    )
//                  :
                ),
//              ),
            ),
            Chip(
              label: Text('普通のchip'),
            ),



          ],
        ),
      ),


    );
  }
}

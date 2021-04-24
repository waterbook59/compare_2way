import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/views/compare/components/sub/tag_chips.dart';
import 'package:compare_2way/views/compare/components/sub/tag_input_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TagDialogPage extends StatelessWidget {

  const TagDialogPage({this.comparisonOverview});
  final ComparisonOverview comparisonOverview;

  @override
  Widget build(BuildContext context) {

    var _tagNameList = <String>[];

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
              //todo 完了を押したらinput内容(List<String>)とcomparisonIdを基にtagクラスをDB登録
              print('タグ編集完了してCompareScreenに戻る:$_tagNameList');
              Navigator.of(context).pop();
            },
          )
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(//cupertino
          child: Column(
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

              const Text('Chip'),
                Wrap(
                  children: [
                    TagChips(onSubmitted: (tagNameList){
                      _tagNameList = tagNameList;
                    },),
                  ],
                ),
//              ),
              const Text('この下にタグの候補表示'),
              Chip(
                label: Text('普通のchip'),
              ),



            ],
          ),
        ),
      ),


    );
  }
}

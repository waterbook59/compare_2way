import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/tag_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TagDialogPage extends StatelessWidget {

  const TagDialogPage({this.comparisonOverview});
  final ComparisonOverview comparisonOverview;

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    return  CupertinoPageScaffold(
      //todo navBarのUI調整
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
            onPressed: ()async{
              //完了を押したらinput内容(List<String>)とcomparisonIdを基にtagクラスをDB登録
              //todo 完了時createdAtを更新
              ///同一のcomparisonId且つ同一tagTitleはDB登録できないようにメソッド変更
              print('tagDialogPageの完了ボタン！');
                await viewModel.createTag(comparisonOverview);
                await viewModel.deleteTag();
                await viewModel.getTagList(comparisonOverview.comparisonItemId);
              Navigator.of(context).pop();
            },
          )
      ),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: GestureDetector(//cupertino
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(//cupertino
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

                //TagChips以外のところを押すとキーボード下げる
                TagChips(
                  tagList: viewModel.tagList,
                  onSubmitted: (tagNameList){
                    print('TagInputChip=>TagDialogへのtagNameList:$tagNameList');
                    //tagNameListをviewModelへset
                            viewModel.setTagNameList(tagNameList);
                      },
                  onDeleted: (tempoDeleteLabels){
                    print('tagDialogPage/tempoDeleteLabels:$tempoDeleteLabels');
                    //削除項目抽出：viewModelにsetしてある
                    // _tagNameListとtempoDeleteLabels比較し、重複しているものだけを抜き出す
                    viewModel.createDeleteList(
                        tempoDeleteLabels,comparisonOverview.comparisonItemId);
                  },
                ),

                const Text('この下にタグの候補表示'),
                Chip(
                  label: Text('普通のchip'),
                ),



              ],
            ),
          ),
        ),
      ),


    );
  }
}

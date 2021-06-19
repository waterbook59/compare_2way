import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/tag_chips.dart';
import 'package:compare_2way/views/compare/components/sub/candidate_tag.dart';
import 'package:compare_2way/views/compare/components/sub/tag_chips_stateless.dart';
import 'package:compare_2way/views/tag/components/tag_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TagDialogPage extends StatelessWidget {

  const TagDialogPage({this.comparisonOverview});
  final ComparisonOverview comparisonOverview;

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    ///初回TagChipPart=>TagDialogPageの時だけ,initState的にDB登録してあるtagListをtempoTagNameListへ変換したい

//    Future(()async{
//      await viewModel.getCandidateTagList();
//      //todo tagChipsStateless使用しないなら削除
//      await viewModel.setTempoSelectList();
//    });

    ///それ以外のSelectChip表示の追加(CandidateTag,TagInputChip)や削除(SelectChipのonDelete)はviewModelのtempoTagNameListに直接追加・削除すれば良い


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
      //todo iPhoneだとtrailingの'完了'の下が切れてる..
          //todo 完了ボタン押した時にTagInputChip入力中の項目も追加されるように(キーボード完了よりこっちをおしてしまう)
          trailing: CupertinoButton(
            child:const Text('完了'),
            onPressed: ()async{
              //完了を押したらinput内容(List<String>)とcomparisonIdを基にtagクラスをDB登録
              //todo 完了時createdAtを更新
              ///同一のcomparisonId且つ同一tagTitleはDB登録できないようにメソッド変更
//              print('tagDialogPageの完了ボタン！');
                await viewModel.createTag(comparisonOverview);
                await viewModel.deleteTag();
                //TagPage側更新
                await viewModel.updateSelectTagPage();
                //tagChipPart更新
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
                  child: Text('タグ', textAlign: TextAlign.left,),),
                //TagChips以外のところを押すとキーボード下げる
                //todo ChoiceTagのonTapするとtagListを更新する,Selector設定(viewModel.tempoSelctList)
//              Consumer<CompareViewModel>(
//                Selector<CompareViewModel, List<String>>(
//                  selector: (context, viewModel) => viewModel.tempoSelectList,
//                  builder: (context,tempoSelectList, child) {
//                   return
          ///Selector=>TagChipsStateless
//                     TagChipsStateless(
//                       tempoSelectList: tempoSelectList,
//                       onSubmitted:(input)async{
//                         print('TagChipsStateless:$input');
//                         await viewModel.inputTagName(input);
//                        },
//                         onDeleted: (index)
//                       {
////                           print('tagDialogPage/TagChipsStateless/onDelete:$input:$tempoDeleteLabels');
//                          viewModel.onDeleteSelectChip(index);
//                           // _tagNameListとtempoDeleteLabels比較し、重複しているものだけを抜き出す
//                           viewModel.createDeleteList(comparisonOverview.comparisonItemId);
//                       },
//                     );
            ///Consumer=>TagChips
//                     TagChips(
//                      tagList: compareViewModel.tagList,
//                      onSubmitted: (tagNameList){
//                        print('TagInputChip=>TagDialogへのtagNameList:$tagNameList');
//                        //tagNameListをviewModelへset
//                        viewModel.setTagNameList(tagNameList);
//                      },
//                      onDeleted: (tempoDeleteLabels){
//                        print('tagDialogPage/tempoDeleteLabels:$tempoDeleteLabels');
//                        //削除項目抽出：viewModelにsetしてある
//                        // _tagNameListとtempoDeleteLabels比較し、重複しているものだけを抜き出す
//                        viewModel.createDeleteList(
//                            tempoDeleteLabels,comparisonOverview.comparisonItemId);
//                      },
//                     addTagTitle: compareViewModel.addTagTitle,
//                    );

//    }
///TagChips内をStatefulで完結:文頭のFutureで取るのではなく、FutureBuilderで初回ビルド時のnull回避?

              //viewModelのtagListとtagNameListにはcomparisonItemIdに紐づいたDBからの選択タグが格納されている
//                  FutureBuilder(
//                    future: viewModel.getCandidateTagList(),
//                    builder: (context,AsyncSnapshot<List<String>> snapshot){
//                      if(snapshot.data == null) {
//       print('AsyncSnapshot<List<String>> viewModel.candidateTagNameListがnull');
//                        return Container();
//                      }
//                      if (snapshot.hasData && snapshot.data.isEmpty) {
//                      print('候補タグリストなし');
//                      return Container();
//                  //todo 中央に位置変更 listPage参考
//                  return Container();
//                    }else{
//                        return
                          TagChips(
                          tagNameList: viewModel.tagNameList,
                          onSubmitted: (tempoDisplayList){
                            print('TagInputChip=>TagDialogへのtagNameList:$tempoDisplayList');
                            //_tempoDisplayListをviewModelへset
                            viewModel.setTagNameList(tempoDisplayList);
                          },
                          onDeleted: (tempoDeleteLabels){
                            print('tagDialogPage/tempoDeleteLabels:$tempoDeleteLabels');
                            //削除項目抽出：viewModelにsetしてある
                            // _tagNameListとtempoDeleteLabels比較し、重複しているものだけを抜き出す
                            viewModel.createDeleteList(
                                tempoDeleteLabels,comparisonOverview.comparisonItemId);
                          },
                          //TagDialogPageの冒頭getCandidateTagListで取得したviewModel.candidateTagNameListを渡して、
                          //Container or ListView.builderで場合わけ
                            candidateTagNameList: viewModel.candidateTagNameList,
                        ),

//                      }
//                    },
//
//                  ),

//                ),
                ///Divider
//                const Divider(
//                  color: Colors.black,
//                ),
              ///FutureBuilder CandidateTag
//                FutureBuilder(
//                  future:viewModel.getCandidateTagList(),
//                  builder:  (context, AsyncSnapshot<List<String>> snapshot) {
//                  if (snapshot.data == null) {
//                  print('AsyncSnapshot<List<Tag>> snapshotがnull');
//                  return Container();
//                  }
//                  if (snapshot.hasData && snapshot.data.isEmpty) {
//                  print('EmptyView側通って描画');
//                  //todo 中央に位置変更 listPage参考
//                  return Container(
//                  child:
//                   const Center(child: Text('タグづけされたリストはありません')));
//                  } else {
//                  return ListView.builder(
//                  shrinkWrap: true,
//                  //リストが縦方向にスクロールできるようになる
//                  physics: const NeverScrollableScrollPhysics(),
////                  separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey,),
//                  itemCount: snapshot.data.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      final overview = snapshot.data[index];
//                      ///ListTileのスペースがいまいちなのでDescDisplay参照
//                      return CandidateTag(
//                        title: overview,
////                        createdAt: '登録時間',
//                        onTap: (title)=>_onAddTag(context,title),
//                        listNumber: index,
//                      );
//                    },
//                  );
//                  }}),



              ],
            ),
          ),
        ),
      ),


    );
  }

  Future<void> _onAddTag(BuildContext context, String title) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //viewModelの_tagNameListに追加するだけでいいかも
    await viewModel.onAddTag(title);
  }
}

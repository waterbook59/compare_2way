import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/components/sub/tag_chips.dart';
import 'package:compare_2way/views/compare/components/sub/candidate_tag.dart';
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

    return CupertinoPageScaffold(
      //todo navBarのUI調整
      navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFF363A44),
//        leadingはxボタンに変更
          leading: GestureDetector(
              child: const Icon(
                CupertinoIcons.clear_thick_circled,
                color: Colors.white,
              ),
              onTap: () =>_cancelPage(context),
          ),
          middle: const Text('タグの追加・削除',style: middleTextStyle),

          //CupertinoButtotonに変更でtrailingの'完了'の下が切れない..
          // 完了ボタン押した時にTagInputChip入力中の項目も追加されるように(キーボード完了よりこっちをおしてしまう)
          trailing: CupertinoButton(
            padding: const EdgeInsets.all(8),
            child: const Text('完了',style: trailingTextStyle,),
            onPressed: () async {
              //完了を押したらinput内容(List<String>)とcomparisonIdを基にtagクラスをDB登録
              //todo 完了時createdAtを更新
              ///同一のcomparisonId且つ同一tagTitleはDB登録できないようにメソッド変更
//              print('tagDialogPageの完了ボタン！');
            //tempoInputTagに入力がある場合はviewModelの_tagNameListに追加
              await viewModel.createTag(comparisonOverview);//DBと重複してないものを登録
              //削除リストとDBリストで重複してるものを削除
              await viewModel.deleteTag(comparisonOverview.comparisonItemId);
              //TagPage側更新
              await viewModel.updateSelectTagPage();
              //tagChipPart更新
              await viewModel.getTagList(comparisonOverview.comparisonItemId);
              Navigator.of(context).pop();
            },
          )),
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body: GestureDetector(
          //cupertino
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            //cupertino
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
                ///FutureBuilder=>TagChips
                FutureBuilder(
                    future: viewModel.getCandidateTagList(),
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.data == null) {
                        print('AsyncSnapshot candidateがnull');
                        return Container();
//                      }
                        /// candidateが空の時はTagChipsのCandidateTag以外表示
//                      if (snapshot.hasData && snapshot.data.isEmpty) {
//                        print('candidateが空');
//                        return Container();
                      } else {
                        return TagChips(
                          tagNameList: viewModel.tagNameList,
                          setTempoInput: (tempoInput){
                            viewModel.setTempoInput(tempoInput);
                          },
                          onSubmitted: (tempoDisplayList) {
    ///いきなりviewModel側のtagNameListにsetするとキャンセルしても残るので仮リストへset
                            //_tempoDisplayListをviewModelへset
                            viewModel.setTempoDisplayList(tempoDisplayList);
                          },
                          onDeleted: (tempoDeleteLabels) {
                      //削除項目抽出：viewModelにsetしてある_tagNameListと
                            // tempoDeleteLabels比較し、重複しているものだけを抜き出す
                            viewModel.createDeleteList(tempoDeleteLabels);
                          },
                    //candidateが空か否かでContainer or ListView.builderで場合わけ
                          candidateTagNameList: viewModel.candidateTagNameList,
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _cancelPage(BuildContext context) {
    Navigator.pop(context);
    //viewModel側のtempoDisplayList,tempoDeleteListは削除が必要
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
    ..clearTempoList();
  }

}

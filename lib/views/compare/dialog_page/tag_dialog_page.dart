import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
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

    //TagDialogPageに以降時に候補タグを毎度取得するのがいい(CompareScreenの文頭だと、TagDialogPage複数回行き来すると表示されない)
//    Future(() async {
//      await viewModel.getCandidateTagList(); //notifyListenersあり
//    });

    return CupertinoPageScaffold(
      //todo navBarのUI調整
      navigationBar: CupertinoNavigationBar(
          backgroundColor: const Color(0xFF363A44),
          middle: const Text('タグの追加・編集'),
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
            child: const Text('完了'),
            onPressed: () async {
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
                //todo 文頭のnotifyListenersに呼応する形でSelector(候補タグ更新するためにviewModel.candidateTagNameListで再ビルドする)
                //Selector使いたくないならTagDialogPageのキャンセル時に viewModel.getCandidateTagList()するか...
                ///Selector(viewModel.candidateTagNameList)=>TagChips
//                Selector<CompareViewModel, List<String>>(
//                  selector: (context, viewModel) => viewModel.candidateTagNameList,
//    builder: (context, candidateTagNameList, child) {
//                  return                   TagChips(
//                    tagNameList: viewModel.tagNameList,
//                    onSubmitted: (tempoDisplayList) {
//                      //_tempoDisplayListをviewModelへset
//                      viewModel.setTagNameList(tempoDisplayList);
//                    },
//                    onDeleted: (tempoDeleteLabels) {
//                      //削除項目抽出：viewModelにsetしてある
//                      // _tagNameListとtempoDeleteLabels比較し、重複しているものだけを抜き出す
//                      viewModel.createDeleteList(
//                          tempoDeleteLabels, comparisonOverview.comparisonItemId);
//                    },
//                    //TagDialogPageの冒頭getCandidateTagListで取得したviewModel.candidateTagNameListを渡して、
//                    //Container or ListView.builderで場合わけ
//                    candidateTagNameList: candidateTagNameList,
//                  );
//    }
//                ),
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
                          onSubmitted: (tempoDisplayList) {
                            //_tempoDisplayListをviewModelへset
                            viewModel.setTagNameList(tempoDisplayList);
                          },
                          onDeleted: (tempoDeleteLabels) {
                      //削除項目抽出：viewModelにsetしてある_tagNameListと
                            // tempoDeleteLabels比較し、重複しているものだけを抜き出す
                            viewModel.createDeleteList(tempoDeleteLabels,
                                comparisonOverview.comparisonItemId);
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

  Future<void> _onAddTag(BuildContext context, String title) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //viewModelの_tagNameListに追加するだけでいいかも
    await viewModel.onAddTag(title);
  }
}

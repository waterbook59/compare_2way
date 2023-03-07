import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/common/nav_bar_icon_title.dart';
import 'package:compare_2way/views/compare/components/sub/tag_chips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagDialogPage extends StatelessWidget {
  const TagDialogPage({Key? key, required this.comparisonOverview})
      : super(key: key);

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
          middle: const NavBarIconTitle(tagTitle:'タグの追加・削除',
            titleIcon: CupertinoIcons.tag,leftFlex: 1,centerFlex: 10,
            rightFlex: 1,),

          //CupertinoButtotonに変更でtrailingの'完了'の下が切れない..
          // 完了ボタン押した時にTagInputChip入力中の項目も追加されるように(キーボード完了よりこっちをおしてしまう)
          trailing: CupertinoButton(
            padding: const EdgeInsets.all(8),
            child: const Text('完了',style: trailingTextStyle,),
            onPressed: () async {
              //完了を押したらinput内容(List<String>)とcomparisonIdを基にtagクラスをDB登録
              ///同一のcomparisonId且つ同一tagTitleはDB登録できないようにメソッド変更
//              print('tagDialogPageの完了ボタン！');
            //tempoInputTagに入力がある場合はviewModelの_tagNameListに追加
              //todo candidateからの選択だとtempoInputに入らない
              await viewModel.createTag(comparisonOverview);//DBと重複してないものを登録
              //削除リストとDBリストで重複してるものを削除
              //todo 削除完了時にTagChart側も削除(Tag削除されてもTagPage側(TagChart表示側)は残っている)
              await viewModel.deleteTag(comparisonOverview.comparisonItemId);
              //TagPage側更新
              await viewModel.updateSelectTagPage();
              //tagChipPart更新
              await viewModel.getTagList(comparisonOverview.comparisonItemId);
    if (context.mounted) {
      Navigator.of(context).pop();
    }

            },
          ),),
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
                          setTempoInput: viewModel.setTempoInput,
     ///いきなりviewModel側のtagNameListにsetするとキャンセルしても残るので仮リストへset
                   //_tempoDisplayListをviewModelへset
                          onSubmitted: viewModel.setTempoDisplayList,
                          onDeleted: (tempoDeleteLabels,tempoDisplayList) {
                      //削除項目抽出：viewModelにsetしてある_tagNameListと
                            // tempoDeleteLabels比較し、重複しているものだけを抜き出す
                            viewModel.createDeleteList(tempoDeleteLabels,
                                tempoDisplayList,);
                          },
                    //candidateが空か否かでContainer or ListView.builderで場合わけ
                          ///null場合分しているので強制呼び出し
                          candidateTagNameList: snapshot.data!,
                        );
                      }
                    },),
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
    Provider.of<CompareViewModel>(context, listen: false)
    .clearTempoList();
  }

}

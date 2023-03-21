import 'package:compare_2way/data_models/dragging_tag_chart.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/common/page_title.dart';
import 'package:compare_2way/views/tag/components/reorderable_tag_list.dart';
import 'package:compare_2way/views/tag/components/sub/tag_page_title.dart';
import 'package:compare_2way/views/tag/components/tag_list.dart';
import 'package:compare_2way/views/tag/select_tag_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'components/sub/tag_edit_button_action.dart';

///List<Tag>で一覧のデータ取得しつつ、tagTitleで重複するものを削除するのにtoSet()を使う
///削除したlistをタグ一覧として表示する（tagChips参照）

class TagPage extends StatelessWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    // final accentColor = CupertinoTheme.of(context).primaryContrastingColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: TagPageTitle(),
        trailing:
            //タグ名編集時にキーボードunFocusできるアイコン追加(viewModel経由=>Consumerに訴える)
            //編集モード(true)の時はリストをタップするとTagListのtagTitle部を編集する形に
            TagEditButtonAction(),
      ),

      ///Scaffoldで全く問題なし
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body:

            ///Selectorに変更するとbuilder:(context,allTagList,child)になって、
            ///FutureBuilderのfuture:でエラーがでる
//        Selector<CompareViewModel,List<Tag>>(
//         selector: (context, compareViewModel) => compareViewModel.allTagList,
            Consumer<CompareViewModel>(
          builder: (context, compareViewModel, child) {
            return (viewModel.tagEditMode == TagEditMode.normal ||
                    viewModel.tagEditMode == TagEditMode.tagTitleEdit)
                //ここでnormal&editとdeleteModeで表示変更
                //todo normal&tagTitleEdit内のdeleteModeの表示削除
                //normal&tagTitleEdit
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      return ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: FutureBuilder(
                          future: compareViewModel.getAllTagChartList(),
                          //compareViewModel.allTagList,
                          builder: (context,
                              AsyncSnapshot<List<TagChart>> snapshot,) {
                            if (snapshot.data == null) {
                              print(
                                'AsyncSnapshot<List<TagChart>> snapshotがnull',);
                              return Container();
                            }

                            ///nullで場合分けしているので、snapshot.data強制呼び出し
                            if (snapshot.hasData && snapshot.data!.isEmpty) {
                              print('TagPage/EmptyView側通って描画');
                              return Container(
                                  child: const Center(
                                      child: Text('タグづけされたアイテムはありません'),),);
                            } else {
                              //todo まとめてスクロール sliver使用 https://kabochapo.hateblo.jp/entry/2021/05/10/190621
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const PageTitle(
                                    title: 'タグ',
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 0,
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      //ListView.builderの高さを自動指定
//                              shrinkWrap: true,
                                      //リストが縦方向にスクロールできるようになる
//                                physics: const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final tagChart = snapshot.data![index];
                               // print('tagPage/snapshot.itemIdList:${tagChart.itemIdList}');
                                        //DateTime=>String変換
                                        return TagList(
                                          title: tagChart.tagTitle,
                                          // selectTagIdList: tagChart.itemIdList,
                                          tagAmount: tagChart.tagAmount!,
                                          createdAt: '登録時間',
                                          onDelete: () => _onDeleteTag(
                                              context, tagChart.tagTitle,),
                                          onTap: () => _onSelectTag(
                                            context,
                                            tagChart.tagTitle,
                                            tagChart.myFocusNode!,
                                          ),
//                            listDecoration: listDecoration,
                                          listNumber: index,
                                          myFocusNode: tagChart.myFocusNode!,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      );
                    },
                  )
                //削除モード
                : LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: FutureBuilder(
                          future: compareViewModel.getTagChartList(),
                          builder: (
                            context,
                            AsyncSnapshot<List<DraggingTagChart>> snapshot,
                          ) {
                            if (snapshot.data == null) {
                              return Container();
                            }
                            if (snapshot.hasData && snapshot.data!.isEmpty) {
                              return Container(
                                child: const Center(child: Text('アイテムはありません')),
                              );
                            } else {
                              return ReorderableTagList(
                                draggedTags: snapshot.data!,
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },);
          },
        ),
      ),
    );
  }

  //ListTile内のTagを押したら
  ///通常：タグ登録されたCompareList一覧表示
  ///編集：タグ名変更のためのフォーカス
  Future<void> _onSelectTag(
    BuildContext context,
    String tagTitle,
    FocusNode myFocusNode,
  ) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //3モードのとき
    switch (viewModel.tagEditMode) {
      ///通常モード：タップでDB検索=>SelectTagPage
      case TagEditMode.normal:
        //IdからcomparisonOverview.titleを取得し表示
        await viewModel.onSelectTag(tagTitle);
        if (context.mounted) {
        ///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
        await Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute<void>(
                builder: (context) => SelectTagPage(
                      tagTitle: tagTitle,
                    ),),);
        }
        break;

      ///編集モード：タップでタイトルをeditTagTitleへ変更=>onSubmittedでitemIdListを元にDBをupdate
      //編集モードでリストの１つをタップ=>tagTitleからList<Tag>をviewModelへ格納
    //タグ名を編集=>新しいTagTitleからList<Tag>上書き、tagIdとcomparisonItemIdの2つからtagTitleを上書き
      case TagEditMode.tagTitleEdit:
        // タップでtextFieldにfocus
        myFocusNode.requestFocus();
        //tagTitleからcomparisonItemIdをviewModelへ格納する
        await viewModel.getTagTitleId(tagTitle);
        break;

      /// 削除モード タップでタグ削除 //todo タップ削除はなくなったのでこの部分はいらない
      case TagEditMode.tagDelete:
        await showDialog<Widget>(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('「$tagTitle」タグ'),
                content: const Text('削除してもいいですか？'),
                actions: [
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      viewModel.onDeleteTag(tagTitle);
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: '削除完了',
                      );
                    },
                    child: const Text('削除'),
                  ),
                  CupertinoDialogAction(
                    child: const Text('キャンセル'),
                    onPressed: () {
                      //キャンセル押した時に_selectedIndexをデフォルトに(選択状態解除)
                      viewModel.unFocusTagPageList();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },);
        break;

    }

    //2モードのとき
    ///通常モード：タップでDB検索=>SelectTagPage
//    if(viewModel.tagEditMode){
//      //IdからcomparisonOverview.titleを取得し表示
//      await viewModel.onSelectTag(tagTitle);
//      await Navigator.push(context,
//          MaterialPageRoute<void>(
//              builder: (context) => SelectTagPage(tagTitle: tagTitle,
//              )));
//    }else{
//      ///編集モード：タップでタイトルをeditTagTitleへ変更=>onSubmittedでitemIdListを元にDBをupdate
//      // タップでtextFieldにfocus
//      myFocusNode.requestFocus();
//      //tagTitleからcomparisonItemIdをviewModelへ格納する
//    await viewModel.getTagTitleId(tagTitle);
//    }
  }

  //編集タップでtagEditMode切替(trueが通常モード)
//  Future<void>_changeEdit(BuildContext context) async{
//    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
//    await viewModel.changeTagEditMode();
//  }

  //tagTitleを元に削除
  Future<Future<Widget?>> _onDeleteTag(
      BuildContext context, String tagTitle,) async {
    //Slidable削除のとき確認ダイアログ出す
    return showDialog<Widget>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('「$tagTitle」タグの削除'),
            content: const Text('削除してもいいですか？'),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  // final viewModel =
                      Provider.of<CompareViewModel>(context, listen: false)
                        .onDeleteTag(tagTitle);
                  Fluttertoast.showToast(
                    msg: '削除完了',
                  );
                  Navigator.pop(context);
                },
                child: const Text('削除'),
              ),
              CupertinoDialogAction(
                child: const Text('キャンセル'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },);

    //確認ダイアログなし削除
    // final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    // await viewModel.onDeleteTag(tagTitle);
  }
}

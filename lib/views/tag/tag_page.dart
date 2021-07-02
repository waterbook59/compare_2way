import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/view_model/tag_view_model.dart';
import 'package:compare_2way/views/list/componets/overview_list.dart';
import 'package:compare_2way/views/tag/components/sub/page_title.dart';
import 'package:compare_2way/views/tag/components/sub/tag_edit_bottom_action.dart';
import 'package:compare_2way/views/tag/select_tag_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'components/tag_list.dart';

///List<Tag>で一覧のデータ取得しつつ、tagTitleで重複するものを削除するのにtoSet()を使う
///削除したlistをタグ一覧として表示する（tagChips参照）

class TagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        //todo 編集:タグを編集、削除:タグを削除
        middle: const Text('タグ', style: middleTextStyle,),
        trailing:
            //todo 編集ボタンをタグ名編集・タグ削除に変更
        //todo タグ名編集時にキーボードunFocusできるアイコン追加
        //編集モード(true)の時はリストをタップするとTagListのtagTitle部を編集する形に

        TagEditBottomAction(),
          //これまでのboolのtagEditModeの時
//      Selector<CompareViewModel,TagEditMode>(
//        selector: (context, viewModel) => viewModel.tagEditMode,
//      builder:(context, tagEditMode, child){
//          return
//            tagEditMode
//          ///CupertinoButtonに変更すると黄色二十線出ない
//              ?  CupertinoButton(
//            child: const Text('編集',
//              style: trailingTextStyle),
//          onPressed: ()=>_changeEdit(context),
//          padding: const EdgeInsets.all(8),)
//              : CupertinoButton(
//              child: const Text('完了', style: trailingTextStyle),
//          onPressed: ()=>_changeEdit(context),
//            padding: const EdgeInsets.all(8),);
//        },
////         const Text('編集', style: trailingTextStyle,
//        ),//Selector
      ),

      ///Scaffoldで全く問題なし
      child: Scaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        body:
///Selectorに変更するとbuilder:(context,allTagList,child)になって、
        ///FutureBuilderのfuture:でエラーがでる
//        Selector<CompareViewModel,List<Tag>>(
//          selector: (context, compareViewModel) => compareViewModel.allTagList,
          Consumer<CompareViewModel>(
          builder: (context, compareViewModel, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageTitle(
                    title: 'タグ',
                  ),
                  FutureBuilder(
                    future:
                    compareViewModel.getAllTagList(),
                    //compareViewModel.allTagList,
                    builder: (context, AsyncSnapshot<List<TagChart>> snapshot) {
                      if (snapshot.data == null) {
                        print('AsyncSnapshot<List<Tag>> snapshotがnull');
                        return Container();
                      }
                      if (snapshot.hasData && snapshot.data.isEmpty) {
                        print('EmptyView側通って描画');
                        //todo 中央に位置変更 listPage参考
                        return Container(
                            child:
                                const Center(child: Text('タグづけされたリストはありません')));
                      } else {
                        return ListView.builder(
                          //ListView.builderの高さを自動指定
                          shrinkWrap: true,
                          //リストが縦方向にスクロールできるようになる
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final overview = snapshot.data[index];
//                            print('tagPage/itemIdList:$overview');
                            //DateTime=>String変換
                            //todo 1つめのリストの上にDivider的な線が必要
                            return TagList(
                            title: overview.tagTitle,
                            selectTagIdList: overview.itemIdList,
                            tagAmount: overview.tagAmount,
                            createdAt: '登録時間',
                            onDelete: ()=> _onDeleteTag(
                                context, overview.tagTitle),
                            onTap: ()=>_onSelectTag(
                                context,overview.tagTitle,overview.myFocusNode),
//                            listDecoration: listDecoration,
                            listNumber: index,
                            myFocusNode:overview.myFocusNode,
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),

      ),
    );
  }

  //ListTile内のTagを押したら
  ///通常：タグ登録されたCompareList一覧表示
  ///編集：タグ名変更のためのフォーカス
  Future<void>_onSelectTag(BuildContext context,
      String tagTitle, FocusNode myFocusNode ) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //3モードのとき
    switch(viewModel.tagEditMode){
    ///通常モード：タップでDB検索=>SelectTagPage
      case TagEditMode.normal:
      //IdからcomparisonOverview.titleを取得し表示
        await viewModel.onSelectTag(tagTitle);
        await Navigator.push(context,
            MaterialPageRoute<void>(
                builder: (context) => SelectTagPage(tagTitle: tagTitle,
                )));
        break;
    ///編集モード：タップでタイトルをeditTagTitleへ変更=>onSubmittedでitemIdListを元にDBをupdate
      case TagEditMode.tagTitleEdit:
      // タップでtextFieldにfocus
        myFocusNode.requestFocus();
        //tagTitleからcomparisonItemIdをviewModelへ格納する
        await viewModel.getTagTitleId(tagTitle);
        break;
    /// 削除モード タップでタグ削除
      case TagEditMode.tagDelete:
        await showDialog<Widget>(
            context: context,
            builder: (context){
              return CupertinoAlertDialog(
                title: Text('「$tagTitle」タグ'),
                content:const Text('削除してもいいですか？'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('削除'),
                    isDestructiveAction: true,
                    onPressed: () {
                        viewModel.onDeleteTag(tagTitle);
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: '削除完了',
                      );
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('キャンセル'),
                    onPressed: ()=>Navigator.pop(context),
                  ),
                ],
              );
            });
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
  Future<void> _onDeleteTag(BuildContext context, String tagTitle) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.onDeleteTag(tagTitle);

  }
}

import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/data_models/tag_chart.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/view_model/tag_view_model.dart';
import 'package:compare_2way/views/list/componets/overview_list.dart';
import 'package:compare_2way/views/tag/components/sub/page_title.dart';
import 'package:compare_2way/views/tag/select_tag_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'components/tag_list.dart';

///List<Tag>で一覧のデータ取得しつつ、tagTitleで重複するものを削除するのにtoSet()を使う
///削除したlistをタグ一覧として表示する（tagChips参照）

class TagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = CupertinoTheme.of(context).primaryContrastingColor;
//    final viewModel = Provider.of<TagViewModel>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: const Text('タグ', style: middleTextStyle,),
        trailing:
        //todo 編集ボタン押すとタグ名編集できるように
        //編集モード(true)の時はリストをタップするとTagListのtagTitle部を編集する形に
        GestureDetector(
          onTap: () => _changeEdit(context),
          child:Selector<CompareViewModel,bool>(
          selector: (context, viewModel) => viewModel.tagEditMode,
          builder:(context, tagEditMode, child){
            return tagEditMode
                ? const Text('編集', style: trailingTextStyle)
                : const Text('完了', style: trailingTextStyle);
          },
//         const Text('編集', style: trailingTextStyle,
        ),
        ),
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
                            //DateTime=>String変換
                            //todo 1つめのリストの上にDivider的な線が必要
                            //todo slidableでアイテムから削除実行
                            return TagList(
                            title: overview.tagTitle,
                            tagAmount: overview.tagAmount,
                            createdAt: '登録時間',
                            onDelete: (){},
                            onTap: ()=>_onSelectTag(
                                context,overview.tagTitle,overview.itemIdList),
                              listDecoration: listDecoration,
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

  ///Tagを押したらタグ登録されたCompareList一覧表示
  ///IdからcomparisonOverview.titleを取得し表示
  Future<void>_onSelectTag(BuildContext context,
      String tagTitle, List<String> itemIdList) async{
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    //通常モード：タップでDB検索=>SelectTagPage
    if(viewModel.tagEditMode){
      await viewModel.onSelectTag(tagTitle);
      await Navigator.push(context,
          MaterialPageRoute<void>(
              builder: (context) => SelectTagPage(tagTitle: tagTitle,
              )));
    }else{
      //編集モード：タップでタイトルをeditTagTitleへ変更=>onSubmittedでitemIdListを元にDBをupdate
    print('編集モード');
    }




  }

  //編集タップでtagEditMode切替(trueが通常モード)
  Future<void>_changeEdit(BuildContext context) async{
    print('編集タップ！');
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.changeTagEditMode();
  }
}

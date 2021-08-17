import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/data_models/dragging_item_data.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:compare_2way/views/list/componets/edit_list_tile.dart';
import 'package:compare_2way/views/list/componets/overview_list.dart';
import 'package:compare_2way/views/list/componets/reorderble_edit_lsit.dart';
import 'package:compare_2way/views/list/componets/sub/reorderable_stateless_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

import 'componets/list_page_edit_button.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: Selector<CompareViewModel, ListEditMode>(
            selector: (context, viewModel) => viewModel.editStatus,
            builder: (context, editStatus, child) {
              return (editStatus == ListEditMode.display)
                  ? const Text(
                      'リスト',
                      style: middleTextStyle,
                    )
                  : const Text(
                      'アイテムの並び替え・削除',
                      style: middleTextStyle,
                    );
            }),
        trailing: ListPageEditButton(),
      ),
      child: Scaffold(
        //todo Consumer=>Selectorへ変更を検討
        body: Consumer<CompareViewModel>(

            /// Consumer=>FutureBuilderは空リスト表示できるが、リスト押してからCompareScreen表示が遅い?
            //todo FutureBuilderを再考する(Consumer or Selectorのみ)iPhoneでは遅さ感じない

            builder: (context, compareViewModel, child) {
          return (viewModel.editStatus == ListEditMode.display)

              ///通常時
              //SingleChildScrollViewのchildが中心にこない問題の解決法
              ? LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    //初回描画の時にgetListが２回発動される
                    child: FutureBuilder(
                      future: viewModel.getList(),
                      builder: (context,
                          AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                        if (snapshot.data == null) {
                          print('List<ComparisonOverview>>snapshotがnull');
                          return Container();
                        }
                        ///viewModel.comparisonOverviews.isEmptyだとEmptyView通ってしまう
                        ///あくまでFutureBuilderで待った結果（snapshot.data）で条件分けすべき
                        if (snapshot.hasData && snapshot.data.isEmpty) {
                          print('ListPage/EmptyView側通って描画');
                          return Container(
                              child:
                                  const Center(child: Text('アイテムを追加してください')));
                        } else {
//print('ListView側通って描画');
                          return
//print(compareViewModel.comparisonOverviews.map((overview)
// => overview.conclusion).toList());
                              ListView.builder(
                            //ListView.builderの高さを自動指定
                            shrinkWrap: true,
                            //リストが縦方向にスクロールできるようになる
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final overview = snapshot.data[index];
                              //DateTime=>String変換
                              final formatter =
                                  DateFormat('yyyy/MM/dd(E) HH:mm:ss', 'ja_JP');
                              final formatted =
                                  formatter.format(overview.createdAt);
                              return OverViewList(
                                title: overview.itemTitle,
                                conclusion: overview.conclusion,
                                createdAt: formatted,
                                onDelete: () => _deleteItem(
                                    context, overview.comparisonItemId),
                                onTap: () => _updateList(context, overview),
                                listDecoration: listDecoration,
                              );
                            },
                          );
//                              }//ConnectionState.done
                        }
                      },
                    ),
                  )),
                )

              ///編集時  ListTile→ReorderableListView&CheckboxListTile
              //todo Consumerにしないと編集時リストがなくなる
              :
          LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                        child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            //初回描画の時にgetListが２回発動される
//todo reorderable使用でStatefulに変更、ListPageEditButtonの削除表示反映にFutureBuilder入れても画面更新なし
                        ///NavBarの削除ボタンを押した時にReorderableEditListをsetStateするには???ReorderableEditListをStatelessにするしかない？？
                          ///statelessにしても削除がListViewに反映されない
                            child:
                            FutureBuilder(
                              ///List<ComparisonOverview>ではなくList<ItemData>へ変換して取得(getAllTagList参照)
                              future:
//                              viewModel.getList(),
                                viewModel.getItemDataList(),
                              builder: (context,
//                                  AsyncSnapshot<List<ComparisonOverview>>
                                  AsyncSnapshot<List<DraggingItemData>>
                                  snapshot) {
                                if (snapshot.data == null) {
                                        return Container();
                                      }
                                if (snapshot.hasData && snapshot.data.isEmpty) {
                                  return Container(
                                      child: const Center(
                                          child: Text('アイテムはありません')));
                                      } else {
                                       return
//                                         ReorderableStatelessList(
//                                     draggedItems:snapshot.data
//                                           );
                                         ReorderableEditList(
                                             draggedItems:
                                           snapshot.data
                                         );
                                                                      }
                              }

                            ),
                          //削除更新行うならFutureBuilder必要
//                                FutureBuilder(
//                                    future: viewModel.getList(),
//                                    builder: (context,
//                                        AsyncSnapshot<List<ComparisonOverview>>
//                                            snapshot) {
//                                      if (snapshot.data == null) {
//                                        return Container();
//                                      }
//                                      if (snapshot.hasData &&
//                                          snapshot.data.isEmpty) {
//                                        return Container(
//                                            child: const Center(
//                                                child: Text('アイテムはありません')));
//                                      } else {
//                                        return ListView.builder(
//                                          shrinkWrap: true,
//                                          itemCount: compareViewModel
//                                              .comparisonOverviews.length,
//                                          itemBuilder: (BuildContext context,
//                                              int index) {
//                                            final overview = compareViewModel
//                                                .comparisonOverviews[index];
//                                            return
//
//                                                ///チェックボックス用ListTile
//                                                EditListTile(
//                                                  onTap: () => checkDeleteIcon(
//                                                        context,
//                                                        overview.comparisonItemId),
//                                                    title: overview.itemTitle,
//                                                    icon: compareViewModel.deleteItemIdList.contains(overview.comparisonItemId)
//                          //deleteItemIdListにidがある場合はチェック、ない場合はblank
//                                                        ?
//                                                     Icon(
//                                          CupertinoIcons.checkmark_circle_fill,
////                                                            Icons.check,
//                                                            size: 30,
//                                                            color: accentColor,
//                                                          )
//                                                        :  Icon(
//                                                      CupertinoIcons.circle,
//                                                            size: 30,
//                                                            color: primaryColor,
//                                                          ));
//                                          },
//                                        );
//                                      }
//                                    }),
                        ),
                      )
          );
        }),
        floatingActionButton: Consumer<CompareViewModel>(
            builder: (context, compareViewModel, child) {
          return (viewModel.editStatus == ListEditMode.display)
              ? SizedBox(
                  width: 56,
                  height: 56,
                  child: FloatingActionButton(
                    ///heroTag設定しないとエラー：
                    ///There are multiple heroes that share the same tag within a subtree.
                    ///https://qiita.com/rei_012/items/c07e95b5793d943229e3
                    heroTag: 'hero1',
                    backgroundColor: accentColor,
                    child: const Icon(Icons.add, color: Colors.black, size: 40),
                    onPressed: () => _createComparisonItems(context),
                  ),
                )
              : Container();
        }),
      ),
    );
  } //buildはここまで

  // DB登録とComparePageへ移動
  //todo ページ遷移は下からに変更
  void _createComparisonItems(BuildContext context) {
    ///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
      builder: (context) => const AddScreen(displayMode: AddScreenMode.add),
    ));
  }

  //ListPage単一行削除
  Future<void> _deleteItem(
      BuildContext context, String comparisonItemId) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.deleteItem(comparisonItemId);
  }

  void _updateList(BuildContext context, ComparisonOverview updateOverview) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)

      ///初期表示は読み込みさせる
      ..compareScreenStatus = CompareScreenStatus.set;

    ///画面遷移時、bottomNavbarを外す
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
        builder: (context) => CompareScreen(
              comparisonOverview: updateOverview,
              screenEditMode: ScreenEditMode.fromListPage,
            )));
  }

  void checkDeleteIcon(BuildContext context, String itemId) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false)
      ..checkDeleteIcon(itemId);
  }
}

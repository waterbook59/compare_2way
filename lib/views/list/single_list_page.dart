import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/compare/compare_screen.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:compare_2way/views/list/componets/overview_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

class SingleListPage extends StatelessWidget {
  final bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
//    if(viewModel.comparisonOverviews.isEmpty){
//      Future(viewModel.getOverviewList);
//    }
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: const Text(
          'Compare List',
          style: middleTextStyle,
        ),
        trailing: GestureDetector(
            onTap: () => _changeEdit(context, viewModel.editStatus),
            child: Consumer<CompareViewModel>(
                builder: (context, compareViewModel, child) {
              return (viewModel.editStatus == ListEditMode.display)
                  ? const Text(
                      '編集',
                      style: trailingTextStyle,
                    )
                  : const Text(
                      '完了',
                      style: trailingTextStyle,
                    );
            })),
      ),
      child: Scaffold(
//        appBar: CupertinoNavigationBar(
//          backgroundColor: primaryColor,
//          middle: const Text(
//            'Compare List',
//            style: middleTextStyle,
//          ),
//          trailing: GestureDetector(
//              onTap: () => _changeEdit(context, viewModel.editStatus),
//              child: Consumer<CompareViewModel>(
//                  builder: (context, compareViewModel, child) {
//                    return (viewModel.editStatus == ListEditMode.display)
//                        ? const Text(
//                      '編集',
//                      style: trailingTextStyle,
//                    )
//                        : const Text(
//                      '完了',
//                      style: trailingTextStyle,
//                    );
//                  })),
//        ),
        //todo リスト長くなったときにスライドできない
        body: Consumer<CompareViewModel>(
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
                      //todo Consumer=>Selectorへ変更を検討
                      future: viewModel.getList(),
                      builder: (context,
                          AsyncSnapshot<List<ComparisonOverview>> snapshot) {
                        if (snapshot.data == null) {
                          print('snapshotがnull');
                          return Container();
                        }
                      ///viewModel.comparisonOverviews.isEmptyだとEmptyView通ってしまう
                        ///あくまでFutureBuilderで待った結果（snapshot.data）で条件分けすべき
                        if (snapshot.hasData && snapshot.data.isEmpty) {
                          print('EmptyView側通って描画');
                          return Container(
                              child: const Center(child: Text('リスト追加してください')));
                        } else {
//print('ListView側通って描画');
                          return
//print(compareViewModel.comparisonOverviews.map((overview)
// => overview.conclusion).toList());
                              ListView.builder(
                            //ListView.builderの高さを自動指定
                            shrinkWrap: true,
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
                              onDelete: () => _deleteList(
                                  context, overview.comparisonItemId),
                              onTap: () => _updateList(context, overview),
                              listDecoration: listDecoration,
                            );

                            },
                          );
//                              }//ConnectionState.done
                        }
                        //時間かかる場合indicatorぐるぐるでもいいかも
                        return Container();
                      },
                    ),
                  )),
                )

              ///編集時  ListTile→ReorderableListView&CheckboxListTile
              //todo Consumerにしないと編集時リストがなくなる
              : LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                        child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            //初回描画の時にgetListが２回発動される
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  compareViewModel.comparisonOverviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                final overview =
                                    compareViewModel.comparisonOverviews[index];
                                return

                                    ///checkかラジオボタンを押すと右からSlidableが出てきて削除ボタン表示される
                                    CheckboxListTile(
                                  title: Text(overview.itemTitle),
                                  //conclusionはConsumerで初回描画されない
                                  subtitle: Text(overview.conclusion),
                                  //チェックボックスを左側に
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: _isSelected,
                                );
                              },
                            )
//                        const Text('編集モードです')
                            ),
                      ));
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
  void _createComparisonItems(BuildContext context) {
    ///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
      builder: (context) =>
      const AddScreen(displayMode: AddScreenMode.add),
    ));
  }

  Future<void> _changeEdit(BuildContext context, ListEditMode editMode) async {
    print('編集タップ！：$editMode');
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.changeEditStatus(editMode);
  }

  Future<void> _deleteList(
      BuildContext context, String comparisonItemId) async {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.deleteList(comparisonItemId);
  }

  void _updateList(BuildContext context, ComparisonOverview updateOverview) {
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    ///初期表示は読み込みさせる
    viewModel.compareScreenStatus =CompareScreenStatus.set;
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => CompareScreen(
                  itemEditMode: ItemEditMode.edit,
                  comparisonOverview: updateOverview,
                )));
  }
}

import 'package:compare_2way/style.dart';
import 'package:compare_2way/utils/constants.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleListPage extends StatelessWidget {
   final bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    final accentColor = Theme
        .of(context)
        .accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
//    if(viewModel.comparisonOverviews.isEmpty){
//      Future(viewModel.getOverviewList);
//    }

    return Scaffold(
      appBar: CupertinoNavigationBar(
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
                }
            )

        ),
      ),
      body: Consumer<CompareViewModel>(
          builder: (context, compareViewModel, child) {
            return (viewModel.editStatus == ListEditMode.display)

            ///通常時
            //SingleChildScrollViewのchildが中心にこない問題の解決法
                ? LayoutBuilder(
              builder: (context, constraints) =>
                  SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: constraints.maxHeight),
                        //初回描画の時にgetListが２回発動される
                        child: FutureBuilder(
                          //todo Consumer=>Selectorへ変更を検討
                          future: viewModel.getList(),
                          builder: (context, AsyncSnapshot<void> snapshot) {
                            //リスト空の時の描画はこちらに書いてみる
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (viewModel.comparisonOverviews.isEmpty) {
                                print('EmptyView通って描画');
                                return Container(child: const Center(
                                    child: Text('リスト追加してください')));
                              } else {
                                // 成功処理
                                return
//print(compareViewModel.comparisonOverviews.map((overview)
// => overview.conclusion).toList());
                                  // 成功処理
                                  SizedBox(
                                    //todo SizedBoxのheightを固定値から変更
                                    height: 600,
                                    child: ListView.builder(
                                      itemCount: compareViewModel
                                          .comparisonOverviews
                                          .length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        final overview =
                                        compareViewModel
                                            .comparisonOverviews[index];
                                        return ListTile(
                                          title: Text(overview.itemTitle),
                                          //conclusionはConsumerで初回描画されない
                                          subtitle: Text(
                                              overview.conclusion),
                                        );
                                      },
                                    ),
                                  );
                              }
                            }
                            //時間かかる場合indicatorぐるぐるでもいいかも
                            return Container();
                          },
                        ),
                      )),
            )
            ///編集時  ListTile→ReorderableListView&CheckboxListTile
                : LayoutBuilder(
                builder: (context, constraints) =>
                SingleChildScrollView(
                    child:ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: constraints.maxHeight),
                        //初回描画の時にgetListが２回発動される
                        child: SizedBox(
                          height: 600,
                          child: ListView.builder(
                            itemCount: compareViewModel
                              .comparisonOverviews
                              .length,
                            itemBuilder: (BuildContext context,
                                int index) {
                              final overview =
                              compareViewModel
                                  .comparisonOverviews[index];
                              return CheckboxListTile(
                                title: Text(overview.itemTitle),
                                //conclusionはConsumerで初回描画されない
                                subtitle: Text(
                                    overview.conclusion),
                                //チェックボックスを左側に
                                controlAffinity: ListTileControlAffinity.leading,
                                value: _isSelected,
                              );
                            },
                          ),
                        )
//                        const Text('編集モードです')
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
                onPressed: () => _saveComparisonItems(context),
              ),

            )
                : Container();
          }
      ),
    );
  } //buildはここまで

  // DB登録とComparePageへ移動
  void _saveComparisonItems(BuildContext context) {
    ///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
      builder: (context) => AddScreen(),
    ));
  }

  Future<void> _changeEdit(BuildContext context,
      ListEditMode editMode) async {
    print('編集タップ！：$editMode');
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);
    await viewModel.changeEditStatus(editMode);
  }

}

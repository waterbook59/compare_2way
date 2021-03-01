import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;
    final accentColor = Theme
        .of(context)
        .accentColor;
    final viewModel = Provider.of<CompareViewModel>(context, listen: false);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: const Text(
          'Compare List',
          style: middleTextStyle,
        ),
        //todo 編集ボタンを押したら ListTile→ReorderableListView&CheckboxListTile
        trailing: const Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      body:

      ///SingleChildScrollViewのchildが中心にこない問題の解決法
      LayoutBuilder(
        builder: (context, constraints) =>
            SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: FutureBuilder(
                    ///初回描画の時にgetListが２回発動される
                    ///別のview(CompareScreenのconclusion入力など)で
                    ///notifyListenersすると反応して再描画してしまう
                    //todo Consumer=>Selectorへ変更を検討
                    future: viewModel.getOverviewList(),
                    builder: (context, AsyncSnapshot<void> snapshot) {
                      // 成功処理
                      return Consumer<CompareViewModel>(
                        builder: (context, compareViewModel, child) {
//print(compareViewModel.comparisonOverviews.map((overview)
// => overview.conclusion).toList());
                          //リスト空の時
                          if (compareViewModel.comparisonOverviews.isEmpty) {
                            print('EmptyView通って描画');
                            return Container(child: const Center(
                                child: Text('リスト追加してください')));
                          } else {
                            print('ListView通って描画');
                            // 成功処理
                            return SizedBox(
                              height: 600,
                              child: ListView.builder(
                                itemCount: compareViewModel.comparisonOverviews
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  final overview =
                                  compareViewModel.comparisonOverviews[index];
                                  return ListTile(
                                    title: Text(overview.itemTitle),
                                    //conclusionはConsumerで初回描画されない
                                    subtitle: Text(overview.conclusion),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                )),
      ),
      floatingActionButton: SizedBox(
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
      ),
    );
  }

  // DB登録とComparePageへ移動
  void _saveComparisonItems(BuildContext context) {
    ///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute<void>(
      builder: (context) => AddScreen(),
    ));
  }
}

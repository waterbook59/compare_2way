import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/list_view_model.dart';
import 'package:compare_2way/views/list/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';



class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    final viewModel = Provider.of<ListViewModel>(context, listen: false);
    Future<void>(viewModel.getOverviewList);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: const Text(
          'Compare List',
          style: middleTextStyle,
        ),
        trailing: const Text(
          '編集',
          style: trailingTextStyle,
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child:  Consumer<ListViewModel>(
              builder:(context,listViewModel,child){
                return FutureBuilder(
                  future: listViewModel.getList(),
                  builder: (context,AsyncSnapshot<List<ComparisonOverview>> snapshot){
                    if (snapshot.hasData && snapshot.data.isEmpty) {
                      print('EmptyView通った');
                      return  Center(child: Text('リスト追加してください'));
                    } else{
                      print('snapshot.data:${snapshot.data}');
                      //todo ListView.separatedに変更
                      return SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: listViewModel.overviews.length,
                          itemBuilder: (BuildContext context, int index){
                            final overview = listViewModel.overviews[index];
                            return ListTile(
                              title: Text(overview.itemTitle),
                              subtitle: Text(overview.conclusion),
                            );

                          },
                        ),
                      );
                    }
                  },
                );
              },)

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
      ),
    );
  }

  // DB登録とComparePageへ移動
  void _saveComparisonItems(BuildContext context) {

///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
        Navigator.of(context,rootNavigator: true).push(MaterialPageRoute<void>(
      builder: (context) => AddScreen(),
    ));
  }


}

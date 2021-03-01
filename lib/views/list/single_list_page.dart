import 'package:compare_2way/data_models/comparison_overview.dart';
import 'package:compare_2way/style.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:compare_2way/view_model/list_view_model.dart';
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
    //todo 中級編１のように条件付きでリスト取得する方法もあり
//    if (viewModel.overviews.isEmpty) {
//          Future<void>(viewModel.getOverviewList);
//    }


    return
//      CupertinoPageScaffold(
//      navigationBar:  CupertinoNavigationBar(
//        backgroundColor: primaryColor,
//        middle: const Text(
//          'Compare List',
//          style: middleTextStyle,
//        ),
//        trailing: const Text(
//          '編集',
//          style: trailingTextStyle,
//        ),
//      ),
//      child:
      Scaffold(
        appBar: CupertinoNavigationBar(
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
        body: ///SingleChildScrollViewのchildが中心にこない問題の解決法
        LayoutBuilder(
          builder: (context,constraints)=>
          SingleChildScrollView(
              child:ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child:  FutureBuilder(
                  ///初回描画の時にgetListが２回発動される
///どうしても別のところ(CompareScreenのconclusion入力など)でnotifyListenersすると反応して再描画してしまう
                  //todo Consumer=>Selectorへ変更を検討
                  future: viewModel.getOverviewList(),
                  builder: (context, AsyncSnapshot<void> snapshot) {

//                    if(snapshot.connectionState == ConnectionState.waiting){
//                      print('ぐるぐる〜');
//                      // 非同期処理未完了
//                      return Center(
//                        child: CircularProgressIndicator(),
//                      );
//                    }
                    // 成功処理
                    return Consumer<CompareViewModel>(
                      builder: (context,compareViewModel, child){
                        //ぐるぐるここで入れる？
                      print(compareViewModel.comparisonOverviews.map((overview) => overview.conclusion).toList());
                        //リスト空の時
                        if(compareViewModel.comparisonOverviews.isEmpty){
                          print('EmptyView通った');
                          return Container(child: Center(child: Text('リスト追加してください')));
                        }else{
                          // 成功処理
                          return SizedBox(
                            height: 600,
                            child:
                            ListView.builder(
                              itemCount: compareViewModel.comparisonOverviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                final overview = compareViewModel.comparisonOverviews[index];
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

//          if(snapshot.data == null){
//            print('snapshotがnull通った');
//            return CircularProgressIndicator();
//          }else
                    //snapshot.hasDataはsnapshot.dataがnullではないということ
//            if(snapshot.hasData && snapshot.data.isEmpty){
//            print('EmptyView通って描画し始める');
//            return
//              Container(child: Center(child: Text('リスト追加してください')));
//          }else if(snapshot.hasData && snapshot.data.isNotEmpty){

                  },
                ),
              )
//          Consumer<ListViewModel>(
//            builder:(context,listViewModel,child){
//          return

//            },)
      ),
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
//    );
  }


  // DB登録とComparePageへ移動
  void _saveComparisonItems(BuildContext context) {

    ///画面遷移時にbottomNavbarをキープしたくない時rootNavigatorをtrueにする
    Navigator.of(context,rootNavigator: true).push(MaterialPageRoute<void>(
      builder: (context) => AddScreen(),
    ));
  }

}
